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
import "../shared"

Item {
    // Adds a new entry to the log history
    // Data is obtained from the current log view
    function appendlogHistory() {
        var tempTitle = currentLog.log_title;
        if (tempTitle == "")
               tempTitle = "Log started at "+currentLog.log_starttime;

        history.model.append({
                       "log_title": tempTitle,
                       "log_starttime": currentLog.log_starttime,
                       "log_triptype": currentLog.log_triptype,
                       "log_triplength": currentLog.log_triplength,
                       "log_endtime": currentLog.log_endtime,
                       "log_ecoindex": currentLog.log_ecoindex,
                       // New entries are not synched
                       "log_synched": false
                       });
    }

    // Component for drawing the list items
    Component {
        id: listDrawer

        Item {
            id: wrapper

            width: history.width
            height: 60

            // A simple rounded rectangle for the background
            BorderImage {
                id: background
                anchors.fill: parent
                border.left: 22; border.top: 2
                border.right: 22; border.bottom: 2
                horizontalTileMode: BorderImage.Repeat
                source: "../images/bars/listbar_log.png"
            }

            // Log entry title and trip length
            Row {
                anchors.leftMargin: 15
                anchors.left: wrapper.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                Text {
                    id: title
                    text: log_title
                    font.bold: true
                    font.pixelSize: 16
                    color: "white"
                }

                Text {
                    text: log_triplength
                    color: "white"
                    font.pixelSize: 16
                }
            }

            // Eco index
            EcoIndexMeter {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: synchIcon.left
                anchors.rightMargin: 20
                ecoindexvalue: log_ecoindex
            }

            // Synchronization logo
            Image {
                id: synchIcon
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                // Select an icon depending whether
                // the item is synched or not
                source: {
                    if (log_synched)
                        return "../images/icons/icon_synched.png";
                    else
                        return "../images/icons/icon_synchronization.png";
                }
            }
        }
    }

    // List of the log entries
    ListView {
        id: history

        width: parent.width-scroller.width
        height: parent.height
        spacing: 5
        // logHistoryData is obtained from the dummydata directory
        model: logHistoryData
        delegate: listDrawer
    }

    // Scroll indicator
    ScrollIndicator {

        id: scroller
        anchors.left: history.right
        anchors.top: history.top
        anchors.bottom: history.bottom
        position: history.visibleArea.yPosition
        zoom: history.visibleArea.heightRatio
        shown: history.moving
    }
}
