/** This file is part of QtQuickIVIDemo**

Copyright  2010 Nokia Corporation and/or its subsidiary(-ies).*
All rights reserved.

Contact:  Nokia Corporation qt-info@nokia.com

You may use this file under the terms of the BSD license as follows:

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
  the names of its contributors may be used to endorse or promote
  products derived from this software without specific prior written
  permission.


THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
*/
import Qt 4.7

Item {
    id: mainView

    // Handle toolbar events
    function handleToolbarEvent(event) {
        switch (event) {
            case "start":
                currentLog.state="started";
                setButtons("stopping");
                break;
            case "stop":
                currentLog.state="stopped";
                logHistoryList.appendlogHistory();
                setButtons("new");
                // Notify the log app listener that
                // a new log has been recorded
                var title = currentLog.log_title;
                if (!title)
                    title = currentLog.log_endtime;
                appDataChanged(appName,
                              { title: title,
                                status: currentLog.log_triptype,
                                other: currentLog.log_triplength });
                break;
            case "new":
                currentLog.state="new";
                setButtons("starting");
                break;
            default:
                mainView.state = event;
        }
    }

    // Change the first toolbar button accoring to
    // the log App state
    function setButtons(btnState) {
        switch (btnState) {
            case "starting":
                setToolbarButton(0, { buttonText: "START", event: "start" });
                break;
            case "stopping":
                setToolbarButton(0, { buttonText: "STOP", event: "stop" });
                break;
             case "new":
                setToolbarButton(0, { buttonText: "NEW", event: "new" });
                break;
        }
    }

    LogCurrentView {
        id: currentLog
        anchors.fill: parent
    }

    LogHistoryList {
        id: logHistoryList
        width: app.width
        height: app.height
        y: app.height
    }

    // LogMainView has the default state that displays
    // LogCurrentView and the 'history' state which displays
    // LogHistoryList
    states:
        State {
            name: "history"
            PropertyChanges {
                target: currentLog
                y: 0-mainView.height
                opacity:0
            }
            PropertyChanges {
                target: logHistoryList
                y: 0
            }
        }

    transitions:
        Transition {
            NumberAnimation { properties: "y,opacity"; easing.type: "InOutQuad"; duration: 500 }
        }
}
