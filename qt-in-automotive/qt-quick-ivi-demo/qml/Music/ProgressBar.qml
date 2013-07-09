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
import "../jsUtil/time.js" as TimeUtil

// Track position information
Item {
    id: container
    height: title.height + timer.height + 10

    Text {
        id: title
        text: music_artist + ": " + music_title
        font.pixelSize: 20
        color: "white"
        anchors.left: indicator.left
        anchors.leftMargin: 10
        visible: text != "No title"
    }

    Rectangle {
        id: indicator

        anchors.top:title.bottom
        anchors.topMargin: 10
        width: parent.width - timer.width - 10
        height: timer.height
        radius: 10
        color: "#222222"

        // Displays the elapsed time as a light gray bar in the indicator
        Rectangle {
            radius: 10
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: indicatorKnob.right
            anchors.left: parent.left
            color: "#424242"
        }

        Image {
            id: indicatorKnob
            source: "../images/player/indicator.png"
            x: (indicator.width - indicatorKnob.width)
                * (musicDetails.playHeadPos / musicDetails.duration)
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.fill: parent
                drag.target: indicatorKnob
                drag.axis: "XAxis"
                drag.minimumX: 0
                drag.maximumX: indicator.width-indicatorKnob.width
                onPressed: musicPositionTimer.running = false
                onReleased: musicPositionTimer.running = true
                onPositionChanged: {
                     playHeadPos = (indicatorKnob.x)
                                   / (indicator.width - indicatorKnob.width)
                                   * musicDetails.duration;
                }
            }
        }
    }

    Text {
        id: timer
        // Use utility function to convert the track position
        // into format MM:sS
        text: TimeUtil.numToTime(playHeadPos)
        color: "white"
        font.pixelSize: 14
        font.bold: true
        anchors.right: container.right
        anchors.verticalCenter: indicator.verticalCenter
    }
}
