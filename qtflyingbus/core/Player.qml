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
    id: player
    property int life : 3
    property bool imune : false
    property int imunePhase : 0
    property int balloonCount : 0
    property int oldBalloonCount : 0
    property int balloonStep: 160
    property int balloonTop: y - 120
    property bool inflating : false

    frameImages : [
        "images/sprites/van/running/1.png",
        "images/sprites/van/running/2.png",
        "images/sprites/van/running/3.png",
        "images/sprites/van/running/4.png",
        "images/sprites/van/running/5.png",
        "images/sprites/van/running/6.png",
        "images/sprites/van/inflating/1.png",
        "images/sprites/van/inflating/2.png",
        "images/sprites/van/inflating/3.png",
        "images/sprites/van/inflating/4.png",
        "images/sprites/van/inflating/5.png",
        "images/sprites/van/inflating/6.png"
    ]

    property variant balloons : [
        balloon3, balloon2, balloon5, balloon1, balloon4
    ]

    topOffset: 7
    rightOffset: 6
    bottomOffset: 16

    Behavior on y {
        enabled: !screen.paused
        NumberAnimation {
            duration: 450
            easing.type: Easing.OutSine
        }
    }

    Balloon {
        id: balloon1
        color: "yellow"
        x: 0
        z: -1
        lineHeight: 25
        balloonTop: -50
        balloonBottom: -18
        onClicked: explodeBalloon(balloon1);
    }

    Balloon {
        id: balloon2
        color: "green"
        x: 30
        z: -1
        lineHeight: 45
        balloonTop: -80
        balloonBottom: -34
        onClicked: explodeBalloon(balloon2);
    }

    Balloon {
        id: balloon3
        color: "blue"
        x: 84
        z: -1
        lineHeight: 72
        balloonTop: -112
        balloonBottom: -40
        onClicked: explodeBalloon(balloon3);
    }

    Balloon {
        id: balloon4
        color: "red"
        x: 62
        z: -1
        lineHeight: 45
        balloonTop: -82
        balloonBottom: -36
        onClicked: explodeBalloon(balloon4);
    }

    Balloon {
        id: balloon5
        color: "pink"
        x: 108
        z: -1
        lineHeight: 40
        balloonTop: -82
        balloonBottom: -36
        onClicked: explodeBalloon(balloon5);
    }

    MouseArea {
        anchors.fill: parent
        onClicked: fillBalloon();
    }

    onImuneChanged: {
        if (imune)
            imunePhase = 0;
        else
            opacity = 1.0;
    }

    onBalloonCountChanged: {
        if (balloonCount > oldBalloonCount) {
            frameIndex = 6;
            inflating = true;
        }

        player.y = (canvas.height - player.height - 6)
            - balloonCount * balloonStep;

        oldBalloonCount = balloonCount;
    }

    function reset() {
        life = 3;
        imune = false;
        balloonCount = 0;
        x = -player.width;
        y = (canvas.height - player.height - 6);
        for (var i = 0; i < balloons.length; i++)
            balloons[i].full = false;
    }

    function fillBalloon() {
        if (balloonCount > 4)
            return false;

        for (var i = 0; i < balloons.length; i++) {
            if (!balloons[i].full) {
                balloonCount++;
                balloons[i].full = true;
                return true;
            }
        }

        return false;
    }

    function explodeBalloon(balloon) {
        if (balloonCount > 0 && balloon.full) {
            balloonCount--;
            balloon.full = false;
            return true;
        }
        return false;
    }

    function explodeAnyBalloon() {
        if (balloonCount <= 0)
            return;

        for (var i = 0; i < balloons.length; i++) {
            if (explodeBalloon(balloons[i]))
                break;
        }
    }

    function advance(phase) {
        if (phase % 2 == 0) {
            if (balloonCount == 0)
                frameIndex = (frameIndex + 1) % 6;
            else if (inflating) {
                if (frameIndex < 10)
                    frameIndex++;
                else {
                    frameIndex = 0;
                    inflating = false;
                }
            }
        }

        if (imune) {
            imunePhase++;
            var MAX_IMUNE_PHASE = 100;
            if (imunePhase > MAX_IMUNE_PHASE)
                imune = false;
            else
                opacity = (parseInt(phase / 4) % 2 == 0) ? 0.6 : 1.0;
        }

        for (var i = 0; i < balloons.length; i++)
            balloons[i].advance(phase);
    }
}
