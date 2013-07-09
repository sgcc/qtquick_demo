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

// Volume pane. Used in the left side of the screen
Item {
    id: volumeBar

    // By default, mute is off
    state: "Off"

    Rectangle {
        id: 'bg'
        color: "black"
        border.color:"white"
        border.width: 2
        anchors.fill: parent
        radius: 15
        opacity: appFw.transparentControls ? 0.2 : 0.0
    }

    Item  {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height

        // Create background image for the slider slot
        BorderImage {
            id: groove
            border.left: 2; border.top: 24
            border.right: 2; border.bottom: 20
            height: parent.height - muteBtnBg.height
            source: "../images/volume/volume_slider_back.png"
            verticalTileMode: BorderImage.Repeat
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Mute/unmute button with a background and
        // mute/unmute icons.
        Image {
            id: muteBtnBg
            anchors.top: groove.bottom
            source: "../images/volume/mute_button.png"
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: speakerImage
                source: "../images/icons/icon_mute_speaker.png"
                anchors.centerIn: parent
            }

            // Create both mute/unmute images at the same time
            // as the images are faded in/out when muting
            Image {
                id: muteOnIcon
                source: "../images/icons/icon_unmute.png"
                anchors.centerIn: parent
            }

            Image {
                id: muteOffIcon
                source: "../images/icons/icon_mute_bigger.png"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (volumeBar.state == "On")
                        volumeBar.state = "Off";
                    else
                        volumeBar.state = "On";
                }
            }
        }
    }

    Image {
        id: knob
        anchors.horizontalCenter: parent.horizontalCenter
        source: "../images/volume/volume_slider_button.png"
        y: groove.height - knob.height

        MouseArea {
            id: region
            anchors.fill: knob
            // Allow dragging the knob along Y axis
            drag.target: knob
            drag.axis: "YAxis"
            drag.minimumY: 0
            drag.maximumY: groove.height - knob.height
        }
    }

    // Volume pane has 'On' and 'Off' states which
    // reflect the current mute status. Mute on/off
    // icon visibility is switched between states.
    // Color of the background images is changed in
    // muteBtnBg Mouse event handler
    states: [
        State {
            name: "On"
            PropertyChanges { target: muteOnIcon; opacity: 1 }
            PropertyChanges { target: muteOffIcon; opacity: 0 }
        },
        State {
            name: "Off"
            PropertyChanges { target: muteOnIcon; opacity: 0 }
            PropertyChanges { target: muteOffIcon; opacity: 1 }
        }
    ]

    transitions:
        Transition {
            NumberAnimation { properties: "opacity"; easing.type: "InQuad"; duration: 200 }
        }
}
