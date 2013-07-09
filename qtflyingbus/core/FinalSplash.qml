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

Item {
    id: splash
    visible: false

    signal dialogRequest();

    MouseArea {
        // block mouse events
        anchors.fill: parent
    }

    Image {
        id: world
        visible: false
        source: "images/splash/finalbackground.png"
        anchors.bottom: parent.bottom

        FinalSplashItem {
            jumpSize: 20
            jumpDelay: 40
            x: 300
            sceneY: world.height - 314
            active: world.visible
            source: "images/splash/tablet.png"
        }
        FinalSplashItem {
            jumpSize: 40
            jumpDelay: 20
            x: 520
            sceneY: world.height - 276
            active: world.visible
            source: "images/splash/n8.png"
        }
        FinalSplashItem {
            jumpSize: 25
            jumpDelay: 50
            x: 350
            sceneY: world.height - 224
            active: world.visible
            source: "images/splash/note.png"
        }
        Image {
            x: 0
            y: world.height - 150
            source: "images/sprites/van/running/1.png"
        }
    }

    Rectangle {
        id: overlay
        opacity: 0.0
        color: "black"
        anchors.fill: parent
    }

    function display() {
        animation.start();
    }

    SequentialAnimation {
        id: animation

        PropertyAction { target: splash; property: "visible"; value: true; }
        NumberAnimation { target: overlay; property: "opacity";
                          from: 0.0; to: 1.0; duration: 800; }
        PropertyAction { target: world; property: "visible"; value: true; }

        ParallelAnimation {
            NumberAnimation { target: overlay; property: "opacity";
                              from: 1.0; to: 0.0; duration: 1400; }
            NumberAnimation { target: world; property: "x"; from: -170; to: 0;
                              duration: 1400; easing.type: Easing.OutSine; }
        }

        ScriptAction { script: splash.dialogRequest(); }
        PauseAnimation { duration: 3000; }

        NumberAnimation { target: overlay; property: "opacity";
                          from: 0.0; to: 1.0; duration: 800; }
        PropertyAction { target: world; property: "visible"; value: false; }
        NumberAnimation { target: overlay; property: "opacity";
                          from: 1.0; to: 0.0; duration: 800; }
        PropertyAction { target: splash; property: "visible"; value: false; }
    }
}
