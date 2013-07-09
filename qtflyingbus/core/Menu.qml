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
    id: menu
    width: background.width
    height: background.height

    signal playClicked();
    signal helpClicked();
    signal restartClicked();
    signal nextLevelClicked();

    state: "default"

    Image {
        id: background
        source: "images/menu/menu.png"
    }

    PlayMenu {
        id: playMenu
        anchors.fill: parent

        onPlayClicked: menu.playClicked();
        onHelpClicked: menu.helpClicked();
        onExitClicked: menu.state = "leave";
        onMoreInfoClicked: menu.state = "about";
    }

    AboutMenu {
        id: aboutMenu
        x: 110
        y: 106
        opacity: 0.0
        visible: false

        onClicked: menu.state = "default";
    }

    LeaveMenu {
        id: leaveMenu
        opacity: 0.0
        visible: false
        anchors.fill: parent

        onYesClicked: Qt.quit();
        onNoClicked: menu.state = "default";
    }

    CompleteMenu {
        id: completeMenu
        opacity: 0.0
        visible: false
        anchors.fill: parent
        playerScore: screen.score
        highScore: screen.highScore

        onMenuClicked: menu.state = "default";
        onNextLevelClicked: menu.nextLevelClicked();
    }

    YouWinMenu {
        id: youWinMenu
        opacity: 0.0
        visible: false
        anchors.fill: parent
        playerScore: screen.score
        highScore: screen.highScore

        onMenuClicked: menu.state = "default";
        onRestartClicked: menu.restartClicked();
    }

    GameOverMenu {
        id: gameOverMenu
        opacity: 0.0
        visible: false
        anchors.fill: parent
        playerScore: screen.score
        highScore: screen.highScore

        onMenuClicked: menu.state = "default";
        onRetryClicked: menu.restartClicked();
    }

    states : [
        State {
            name: "default"
            PropertyChanges { target: playMenu; opacity: 1.0; visible: true; }
        },
        State {
            name: "about"
            PropertyChanges { target: playMenu; opacity: 0.0; visible: false; }
            PropertyChanges { target: aboutMenu; opacity: 1.0; visible: true; }
        },
        State {
            name: "leave"
            PropertyChanges { target: playMenu; opacity: 0.0; visible: false; }
            PropertyChanges { target: leaveMenu; opacity: 1.0; visible: true; }
        },
        State {
            name: "nextlevel"
            PropertyChanges { target: playMenu; opacity: 0.0; visible: false; }
            PropertyChanges { target: completeMenu; opacity: 1.0; visible: true; }
        },
        State {
            name: "youwon"
            PropertyChanges { target: playMenu; opacity: 0.0; visible: false; }
            PropertyChanges { target: youWinMenu; opacity: 1.0; visible: true; }
        },
        State {
            name: "gameover"
            PropertyChanges { target: playMenu; opacity: 0.0; visible: false; }
            PropertyChanges { target: background; opacity: 0.0; }
            PropertyChanges { target: gameOverMenu; opacity: 1.0; visible: true; }
        }
    ]

    transitions: [
        Transition {
            from: "default"; to: "about"; reversible: true;
            MenuAnimation { first: playMenu; second: aboutMenu; }
        },
        Transition {
            from: "default"; to: "leave"; reversible: true;
            MenuAnimation { first: playMenu; second: leaveMenu; }
        },
        Transition {
            from: "default"; to: "nextlevel"; reversible: true;
            MenuAnimation { first: playMenu; second: completeMenu; }
        },
        Transition {
            from: "default"; to: "youwon"; reversible: true;
            MenuAnimation { first: playMenu; second: youWinMenu; }
        },
        Transition {
            from: "default"; to: "gameover"; reversible: true;
            SequentialAnimation {
                PropertyAction { target: gameOverMenu; property: "visible"; }
                ParallelAnimation {
                    NumberAnimation { target: playMenu; property: "opacity";
                                      duration: 300; }
                    NumberAnimation { target: background; property: "opacity";
                                      duration: 300; }
                }
                NumberAnimation { target: gameOverMenu; property: "opacity";
                                  duration: 300; }
                PropertyAction { target: playMenu; property: "visible"; }
            }
        }
    ]

    function setState(state, animated) {
        if (!animated) {
            // XXX: workaround to avoid transition
            // There is a pending suggestion to avoid this (QTBUG-14488)
            menu.state = "undefined";
        }
        menu.state = state;
    }
}
