/** This file is part of QtQuickIVIDemo**

Copyright 2010 Nokia Corporation and/or its subsidiary(-ies).*
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

// Quit dialog with YES and NO buttons
Rectangle {
    // Semitransparent background covering
    // whole screen area
    id: container

    anchors.fill: parent
    color: "#c0000000"
    // By default, the dialog is not visible
    opacity: 0

    // Background for the dialog
    Rectangle {
        width: 400
        height: 160
        anchors.centerIn: parent
        radius: 10
        smooth: true
        border.color: "white"
        border.width: 2

        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0.0, 0.0, 0.0, 0.8) }
            GradientStop { position: 0.5; color: Qt.rgba(0.2, 0.2, 0.2, 1) }
            GradientStop { position: 1.0; color: Qt.rgba(0.0, 0.0, 0.0, 0.8) }
        }

        // Dialog text
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 20
            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            text: "Are you sure<br>you want to quit?"
            color: "lightgrey"
        }

        // 'YES' button
        Rectangle {
            x: 10
            y: 90
            width: 180
            height: 50
            radius: 10
            smooth: true
            gradient: Gradient {
                id: buttonGradient
                GradientStop { position: 0.0; color: Qt.rgba(0.3, 0.3, 0.3, 0.8) }
                GradientStop { position: 0.5; color: Qt.rgba(0.8, 0.8, 0.8, 1) }
                GradientStop { position: 1.0; color: Qt.rgba(0.3, 0.3, 0.3, 0.8) }
            }
            Text {
                anchors.centerIn: parent
                font.pixelSize: 24
                font.bold: true
                text: "YES"
                color: "black"
            }
            // When clicking the button, quit the application
            MouseArea {
                anchors.fill: parent
                onClicked: Qt.quit()
            }
        }

        // 'NO' button
        Rectangle {
            x: 210
            y: 90
            width: 180
            height: 50
            radius: 10
            gradient: buttonGradient
            smooth: true

            Text {
                anchors.centerIn: parent
                font.pixelSize: 24
                font.bold: true
                text: "NO"
                color: "black"
            }

            // When clicking 'NO', just hide the dialog
            MouseArea {
                anchors.fill: parent
                onClicked: container.state = "hidden"
            }
        }
    }

    states:
        State {
            name: "visible"
            PropertyChanges { target: container; opacity: 1 }
        }

    transitions:
        Transition {
            NumberAnimation { properties: "opacity"; easing.type: "InOutQuad"; duration: 500 }
        }
}
