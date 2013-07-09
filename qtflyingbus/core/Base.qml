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
import "engine.js" as Engine

Item {
    id: screen
    property int score : 0
    property int highScore : 0
    property bool ready : false
    property bool paused : true

    signal levelLoaded();

    LevelModel {
        id: levelModel
        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                levelLoaded();
                Engine.startGame(ready);
                ready = true;
            }
        }
    }

    Item {
        id: canvas
        anchors.fill: parent

        property real sceneX: 0.0
        property real sceneY: Math.min(player.balloonTop, 0)
        property real sceneWidth: 0.0
        property real sceneHeight: canvas.height * 6.0

        Background {
            id: background
            anchors.fill: parent
        }

        Score {
            life: player.life
            value: screen.score
            anchors.top: parent.top
            anchors.left: parent.left
        }

        Item {
            id: foreground
            y: -canvas.sceneY
            width: canvas.width
            height: canvas.sceneHeight

            Player { id: player; z: 1; }
        }
    }

    Rectangle {
        id: overlay
        color: "black"
        opacity: 0.7
        anchors.fill: canvas
        anchors.leftMargin: -2

        MouseArea {
            // block mouse event
            anchors.fill: parent
        }
    }

    Menu {
        id: menu
        y: screen.height / 2 - menu.height / 2
        anchors.horizontalCenter: parent.horizontalCenter

        onHelpClicked: screen.state = "help";
        onPlayClicked: Engine.resumeGame();
        onRestartClicked: Engine.restartGame();
        onNextLevelClicked: Engine.gotoNextLevel();
    }

    Button {
        id: pauseButton
        visible: false
        anchors.top: parent.top
        anchors.right: parent.right
        normalImage: "images/buttons/pause.png"
        pressedImage: "images/buttons/pause2.png"
        onClicked: {
            menu.setState("default");
            screen.state = "";
        }
    }

    Button {
        id: closeButton
        anchors.top: parent.top
        anchors.right: parent.right
        normalImage: "images/buttons/close.png"
        pressedImage: "images/buttons/close2.png"
        onClicked: menu.setState("leave");
    }

    HelpScreen {
        id: helpScreen
        visible: false
        anchors.fill: parent
        onBackClicked: screen.state = "";
    }

    FinalSplash {
        id: finalSplash
        anchors.fill: parent

        onDialogRequest: {
            menu.setState("youwon", false);
            screen.state = "";
        }
    }

    Timer {
        id: timer
        repeat: true
        interval: 30
        running: false
        onTriggered: Engine.tick();
    }

    states : [
        State {
            name: "running"
            PropertyChanges { target: timer; running: true; }
            PropertyChanges { target: pauseButton; visible: true; }
            PropertyChanges { target: closeButton; visible: false; }
            PropertyChanges { target: menu; visible: false; opacity: 0.0;
                              y: screen.height / 2 - menu.height / 2 - 20; }
            PropertyChanges { target: overlay; visible: false; opacity: 0.0; }
        },
        State {
            name: "help"
            PropertyChanges { target: canvas; visible: false; }
            PropertyChanges { target: helpScreen; visible: true; }
            PropertyChanges { target: closeButton; visible: false; }
            PropertyChanges { target: menu; visible: false; opacity: 0.0; }
            PropertyChanges { target: overlay; visible: false; opacity: 0.0; }
        }
    ]

    transitions: [
        Transition {
            from: "running"; to: ""; reversible: true;
            PropertyAction { target: menu; property: "visible"; }
            NumberAnimation { target: menu; properties: "y,opacity"; duration: 200; }
        }
    ]

    Component.onCompleted: {
        Engine.loadDatabase();
        Engine.loadLevel(0);
    }
}
