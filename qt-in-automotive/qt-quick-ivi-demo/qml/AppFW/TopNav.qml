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
import "../Home"

// A navigation pane at the top of the screen
// The buttons are set according to active
// configuration defined in dummydata
Item {
    id: container

    property alias configuration: navButtons.model

    signal itemClicked(string appName)

    // Listen for a change in active application
    // and activate the associated button
    Connections {
        target: appFw
        onApplicationActive: {
            var found = -1;
            for (var i=0; i < configuration.count; i++) {
                if (configuration.get(i).name == appName) {
                    found = i;
                    break;
                }
             }
            if (found > -1)
                navButtons.currentIndex = found;
        }
    }

    // When TopNav is loaded, add
    // the Home button to it
    Component.onCompleted: {
        var component = Qt.createComponent("../Home/TopNavItemHome.qml");
        if (component.status == Component.Ready) {
            var button = component.createObject(null);
            configuration.insert(0, button);
        }
    }

    Rectangle {
        id:  bg
        color: "black"
        border.color:"white"
        border.width: 2
        y: -topNav.height
        anchors.fill: parent
        radius: 15
        opacity: appFw.transparentControls ? 0.2 : 0.0
    }

    // List item drawer for buttons
    Component {
        id: buttonDrawer

        Item {
            id: wrapper
            width: normalImage.width
            height: normalImage.height

            // Images for normal and selected buttons
            Image {
                id: normalImage
                source: "../images/buttons/"+topNavImage+"_passive.png"
            }

            Image {
                id: normalImageActive
                source: "../images/buttons/"+topNavImage+"_active.png"
                opacity: 0
            }

            MouseArea {
                id: delegateRegion
                anchors.fill: parent
                onPressed:  container.itemClicked(name)
            }

            states:
                State {
                    name: "Current"
                    when: wrapper.ListView.isCurrentItem
                    PropertyChanges {
                        target: normalImageActive
                        opacity: 1
                    }
            }

            transitions:
                Transition {
                    to: "Current"
                    reversible: true
                    NumberAnimation {properties: "opacity"; easing.type: "InQuad"; duration: 300}
            }
        }
    }

    // The list of application shortcuts
    ListView {
        id: navButtons
        model: ""
        delegate: buttonDrawer
        focus: true
        orientation: "Horizontal"
        anchors.fill: parent
        interactive: false
        spacing: (parent.width - currentItem.width*count) / count
    }
}
