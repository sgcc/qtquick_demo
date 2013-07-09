/****************************************************************************
**
** This file is part of QtFlyingBus
**
** Copyright (c) 2010 Nokia Corporation and/or its subsidiary(-ies).*
** All rights reserved.
** Contact:  Nokia Corporation (qt-info@nokia.com)
**
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions
** are met:
**
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in the
**     documentation and/or other materials provided with the distribution.
**
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
**  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
**  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
**  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
**  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
**  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
**  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
**  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
**  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
**  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
**  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
**  POSSIBILITY OF SUCH DAMAGE."
**
****************************************************************************/

import Qt 4.7

FrameSprite {
    id: balloon

    signal clicked();

    property string color
    property bool full : false
    property int lineHeight : 80
    property int balloonTop : 0
    property int balloonBottom : 0
    property int animationPhase : 0
    property int maxAnimationPhase : 8

    visible: false

    frameImages: [
        "images/balloons/" + color + "/1.png",
        "images/balloons/" + color + "/2.png",
        "images/balloons/" + color + "/3.png",
        "images/balloons/" + color + "/4.png",
        "images/balloons/" + color + "/5.png",
        "images/balloons/" + color + "/6.png",
    ]

    MouseArea {
        anchors.fill: parent
        onClicked: balloon.clicked();
    }

    Image {
        y: 50
        z: -1
        height: lineHeight
        fillMode: Image.TileVertically
        source: "images/balloons/line.png";
        anchors.horizontalCenter : parent.horizontalCenter
    }

    onFullChanged: {
        visible = true;
        animationPhase = 0;

        if (full) {
            frameIndex = 0;
            y = balloonBottom;
            maxAnimationPhase = 8;
        } else {
            frameIndex = 3;
            y = balloonTop;
            maxAnimationPhase = 4;
        }
    }

    function advance(phase) {
        if (animationPhase >= maxAnimationPhase)
            return;

        animationPhase++;
        var progress = animationPhase / maxAnimationPhase;

        if (full) {
            frameIndex = 3 * progress;
            y = balloonBottom + (balloonTop - balloonBottom) * progress;
        } else {
            frameIndex = 4 + progress;
            if (progress >= 1.0)
                visible = false;
        }
    }
}
