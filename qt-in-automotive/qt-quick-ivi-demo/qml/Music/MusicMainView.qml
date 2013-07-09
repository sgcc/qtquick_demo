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
import "MusicUpdateScript.js" as Js

// This is a flipable component that contains the song list
// in the 'front' view, and player controls in the 'back' view
Flipable {
    id: container

    // Changes the track list by changing the model property
    // of the musicList component. The track contents is
    // loaded from the dummydata folder
    function changeMusicListByUser(userIndex) {
        switch (userIndex) {
            case 0:
                musicList.model = musicListUser0;
                break;
            case 1:
                musicList.model = musicListUser1;
                break;
            case 2:
                musicList.model = musicListUser2;
                break;
            case 3:
                musicList.model = musicListUser3;
                break;
        }
    }

    function handleToolbarEvent(event) {
        switch (event) {
            case "rewind":
                Js.prevTrack();
                break;
            case "forward":
                Js.nextTrack();
                break;
            case "pause":
                setToolbarButton(3, { "buttonText": "Play", "event": "play",
                                      "iconImage": "../images/player/icon_play.png" });
                musicDetails.state = "paused";
                break;
            case "play":
                setToolbarButton(3, { "buttonText": "Pause", "event": "pause",
                                      "iconImage": "../images/player/icon_pause.png" });
                musicDetails.state = "playing";
                break;
            case "player":
                container.state = "musicPlayer";
                break;
            case "tracks":
                container.state = "trackList";
                break;
        }
    }

    // Draws individual song list items
    Component {
        id: listDrawer

        Rectangle {
            width: musicList.width
            height: 60
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: musicList.currentIndex == index && music_title != ""
                          ? "#c03050" : "#626e6a"  }
                GradientStop {
                        position: 0.7
                        color: "#000000" }
                }
            radius: 18
            border.width: 2
            border.color: "#c03050"

            Image {
                source: "../images/music/listbar_music_left.png"
            }

            Text {
                id: name
                x: 30
                y: 10
                text: (index+1) + ". " + artist + " - " + title
                font.bold: true; font.pixelSize: 18
                anchors.verticalCenter: parent.verticalCenter
                color: "#FFFFFF"
            }

            // When clicking on a list item the view is
            // changed mode to 'Details'.
            MouseArea {
                id: pageMouse
                anchors.fill: parent
                onClicked: {
                    Js.changeTrack(index);
                    if (musicDetails.state == "")
                        musicDetails.state = "playing";
                    container.state= "musicPlayer";
                }
            }
        }
    }

    // Music list with a scroll bar in the 'front' side
    front:
        ListView {
            id: musicList
            spacing: 5
            // Initially no model is available
            // It is set dynamically according to user data
            model: ""
            delegate: listDrawer
            width: parent.width - scroller.width
            height: parent.height
            focus: true
        }

        // Scroll indicator
        ScrollIndicator {
            id: scroller
            x: musicList.width
            position: musicList.visibleArea.yPosition
            zoom: musicList.visibleArea.heightRatio
            shown: musicList.moving
            height: container.height
        }

    // Player controls on the 'back' side
    back:
        MusicDetails {
            id: musicDetails
            anchors.fill: parent
        }

    states: [
        State {
            name: "musicPlayer"
            PropertyChanges { target: detailsRotation; angle: 180 }
            StateChangeScript {
                script:  toolbar.model.set(0, { buttonText: "Tracks", event: "tracks",
                                                iconImage:  "../images/player/icon_player_back.png"});
            }
        },

        State {
            name: "trackList"
            PropertyChanges { target: detailsRotation; angle: 0 }
            StateChangeScript {
                script: setToolbarButton(0, { buttonText: "Player", event: "player",
                                              iconImage:  "../images/player/icon_now_playing.png"});
            }
        }
    ]

    transitions:
        Transition {
            NumberAnimation { easing.type: "InOutQuad";  property: "angle"; duration: 500 }
        }

    transform:
        Rotation {
            id: detailsRotation
            origin.x: parent.width /2
            axis.y: 1
            axis.z: 0
        }

}
