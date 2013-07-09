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
import "MusicUpdateScript.js" as Js

Item {
    id: musicDetails

    property real playHeadPos: 0
    property int duration: 60

    // Album cover
    Image {
        id: musicPic
        source: music_picture
        anchors.top: parent.top
        fillMode: Image.PreserveAspectFit
        sourceSize.height: height
        anchors.topMargin: 0.1*parent.height
        anchors.bottom: progressBar.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

    }

    ProgressBar {
        id: progressBar
        width: 0.75*parent.width
        //y: parent.height - height - 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

   // Timer for updating the elapsed time. The timer
   //triggers once per second
    Timer {
        id: musicPositionTimer
        interval: 50
        running: false
        repeat: true
        onTriggered: {
            var tempPosition = interval/1000 + playHeadPos;
            // If the end of the tack is reached,
            // switch to the next rrack
            if (tempPosition >= duration)
                Js.nextTrack();
            else
                playHeadPos = tempPosition;
        }
    }

    states: [
        State {
            name: "playing";
            PropertyChanges { target: musicPositionTimer; running: true }
        },
        State {
            name: "paused";
            PropertyChanges { target: musicPositionTimer; running: false }
        }
    ]
}
