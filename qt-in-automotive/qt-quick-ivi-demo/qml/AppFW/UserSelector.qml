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

// A component that displays a list
// of available users. A user can be
// selected, which sends a signal
// about the change
Item {
    id: container
    property int leftmargin: 0
    property int topmargin: 10
    property int bottommargin: 10
    // By default no user has been selected
    property int currentUser: -1

    signal userChanged

    // Select user
    function selectUser(user, userBg) {
       // Set user specific background image
       document.properties.backgroundImage = userBg;
       currentUser = user;
       // Notify observer(s) that user has changed
       userChanged();
       // Switch to minimized state
       changeState();
    }

    // Switch between minimized and normal states
    function changeState() {
        // not possible to switch state before
        // a user has been selected
        if (currentUser == -1)
            return;
        if (container.state == "minimized")
            container.state = "userSelection";
        else
            container.state = "minimized";
    }

    // List item drawer for the person list
    Component {
        id: personDrawer
        Item {
            id: wrapper
            width: parent.width
            height: 75

            BorderImage {
                id: background
                border.left: 20; border.top: 2
                border.right: 20; border.bottom: 2
                anchors.fill: parent
                source: {
                    // Set the background for the list item
                    // use the highlight version for the highlighted item
                    // (if not using UserSelector for the first time
                    if (personView.currentIndex == index && currentUser > -1)
                        return "../images/bars/user_bar_selected.png"
                    else
                        return "../images/bars/user_bar.png"
                }
            }

            Image {
                id: userImg
                anchors.top: background.top
                anchors.topMargin: 2
                anchors.left: background.left
                anchors.leftMargin: 30
                source: picture
            }

            Column {
                anchors.left: userImg.right
                anchors.leftMargin: 15
                spacing: 3

                Text {
                    id: usernameText
                    text: username
                    font.pixelSize: 20
                    color: "lightgrey"
                }

                Row {
                    spacing: 3
                    Text {
                        text: "Eco Index  "
                        color: "lightgrey"
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        font.pixelSize: 12
                    }

                    EcoIndexMeter {
                        ecoindexvalue: ecoindex
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    personView.currentIndex = index;
                    person.source = picture;
                    selectUser(index, personalbackground);
                }
            }
       }
    }

    // Components that scale when switching between states
    // are grouped within a single Item
    Item   {
        id: scalingContent

        // Scaling factor that is changed upon transition
        property real scaleFactor: 1

        anchors.fill: parent

        // Do a scaling transform to scalingContent
        transform:
            Scale {
                id: scaler
                origin.x: person.x
                origin.y: person.y
                xScale: scalingContent.scaleFactor
                yScale: scalingContent.scaleFactor
            }

        // Background image for UserSelector, which
        // covers the whole display
        Image {
            id: bgImage
            anchors.fill: parent
            source: "../images/backgrounds/background_main.png"
            MouseArea {
                anchors.fill: parent
                // By clicking the background state is changed
                // (if a user has been already selected)
                onClicked: changeState()
            }
        }

        Image {
            id: driverText
            source: "../images/text_drivers.png"
            anchors.horizontalCenter: parent.horizontalCenter
            y: topmargin
        }

        // List of users
        ListView {
            id: personView
            model: personData
            delegate: personDrawer
            width: 0.75*document.properties.width
            height: 320
            y: 80
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            clip: true
        }

        // Digia and Qt logo
        LogoBox {
            id: logoBox
            x: container.leftmargin + 10
            width: 0.75*document.properties.width
            height: 70
            anchors.bottom: parent.bottom
            anchors.bottomMargin: bottommargin
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    // Semitransparent background
    Rectangle {
        id: 'bg'
        color: "black"
        border.color:"white"
        border.width: 2
        width: volumeBar.width
        height: topNav.height
        radius: 15
        opacity: appFw.transparentControls && person.opacity ? 0.2 : 0.0
    }

    // Person image is placed to tl-corner
    Image {
        id: person
        source: ""
        smooth: true
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 20
        anchors.topMargin: 20
        opacity: 0

        MouseArea {
          anchors.fill: parent
          onClicked: changeState()
        }
    }

    // Add a quit button to tr-corner to be
    // able to exit the application (also in fullscreen mode)
    QuitButton {
        id: quitBtn
        anchors.right: parent.right
        onClicked: quitDialog.state = "visible"
    }

    states:
        State {
            name: "minimized"
            PropertyChanges { target: quitBtn; opacity: 0 }
            PropertyChanges { target: person; opacity: 1 }
            PropertyChanges { target: scalingContent; scaleFactor: 0 }
        }
    transitions:
        Transition {
            to: "minimized"
            reversible: true
            NumberAnimation { properties: "scaleFactor,opacity"; easing.type: "InOutQuad"; duration: 500 }
        }
}
