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
import "../AppFW"

DynamicApp {
    id: app

    property int leftmargin: 0
    property int rightmargin: 5

    // Properties from DynamicApp
    toolbarHandler: mainView

    PhoneMainView {
        id: mainView

        anchors.left: app.left
        anchors.right: app.right
        anchors.leftMargin: leftmargin
        anchors.rightMargin: rightmargin
        height: 0
        clip: true
    }

    PhoneButtonsData {
            id: toolbarBtns

            // Delay changing to the default view
            // until toolbar buttons have been loaded
            // and assigned to toolbar. Without delaying,
            // the toolbar would not have buttons ready when
            // highlighting a view related button
            Component.onCompleted: {

               setToolbarModel(toolbarBtns);
                mainView.changeView("book");
            }
    }

    // The 'current' state is entered when the Log application becomes active
    // AND the application dimensions have been set by the Loader component.
    // Essentially, this means that the view is expanded from zero height to
    // full height. When deactivating the application, a reverse
    // transition is done
    states:
        State {
            name: "current"
            when: activeApp
            StateChangeScript { script: refresh() }
            PropertyChanges{ target: mainView; height: app.height }
            // Assign Phone related buttons to the toolbar
            StateChangeScript{ script: setToolbarModel(toolbarBtns) }
        }

    transitions:
        Transition {
            to: "current"
            reversible: true
            NumberAnimation { properties: "height"; easing.type: "InOutQuad" ; duration: 500 }
        }
}
