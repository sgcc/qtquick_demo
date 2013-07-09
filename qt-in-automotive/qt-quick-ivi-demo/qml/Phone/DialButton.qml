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

Rectangle {
    id: button

    property int textSize: 12
    property alias blink: iconAnimation.running
    property alias buttontext : iconText.text
    property alias iconImage : icon.source

    // Signal button observer that
    // the button has been clicked
    signal clicked

    width: 100
    height: 100
    border.color: "lightgray"
    radius: 5
    border.width: 1
    // Add gradient backround for the button
    gradient: Gradient {
        GradientStop { id: g1; position: 0.0; color: "gray" }
        GradientStop { id: g2; position: 1.0; color: "black" }
    }

    // Center icon and text in the
    // middle of the background
    Item {
        anchors.centerIn: parent
        width: parent.width
        height: icon.height + iconText.height

        // An image that flashes when blink == true
        Image {
            id: icon
            source: ""
            anchors.horizontalCenter: parent.horizontalCenter

            SequentialAnimation on opacity {
                id: iconAnimation
                running: false
                loops: Animation.Infinite
                NumberAnimation { from: 0; to: 1; duration: 300 }
                PauseAnimation { duration: 200 }
                NumberAnimation { from: 1; to: 0; duration: 300 }
            }
        }

        // Place text below the image
        Text {
            id: iconText
            text: ""
            color: "white"
            anchors.top: icon.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: textSize
        }
    }

    // When button is clicked, notify the button observer
    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
    }
}
