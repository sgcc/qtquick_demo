/*
 This file is part of Dictiomania

 Copyright (c) 2010 Movial Creative Technologies Inc. and Nokia Corporation
 and/or its subsidiary(-ies).

 All rights reserved.

 Contact: Movial Creative Technologies Inc. (info@movial.com) or
 Qt Development Frameworks Information (qt-info@nokia.com)

 You may use this file under the terms of the BSD license as follows:

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
     * Neither the name of the Movial Creative Technologies Inc. nor Nokia
       Corporation and its Subsidiary(-ies) or the names of its contributors
       may be used to endorse or promote products derived from this software
       without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import Qt 4.7

/*
    Softkeys QML Component.
    Emits 'leftKey' and 'rightKey signals.
    Properties:
        - leftKeyVisible: true if the left button should be visible
        - rightKeyState: the state for the right button (different states show different icons on the button)
                         see rightMenuButton.states for available values
*/
Row {
    property bool leftKeyVisible: true
    property string rightKeyState

    signal leftKey
    signal rightKey

    id: softKeys
    anchors.bottom: parent.bottom
    width: childrenRect.width
    anchors.horizontalCenter: parent.horizontalCenter

    MenuButton {
        id: leftMenuButton
        onClicked: softKeys.leftKey()
        state: "about"
        visible: softKeys.leftKeyVisible
        states: [
            State {
                name: "about"
                PropertyChanges { target: leftMenuButton; icon: "../gfx/icon_key_about.png"; text: "About"}
            }
        ]
    }
    MenuButton {
        id: rightMenuButton
        onClicked: softKeys.rightKey()
        state: softKeys.rightKeyState
        states: [
            State {
                name: "back"
                PropertyChanges { target: rightMenuButton; icon: "../gfx/icon_key_back.png"; text: "Back"}
            },
            State {
                name: "quit"
                PropertyChanges { target: rightMenuButton; icon: "../gfx/icon_key_quit.png"; text: "Quit"}
            },
            State {
                name: "exit"
                PropertyChanges { target: rightMenuButton; icon: "../gfx/icon_key_quit2.png"; text: "Exit"}
            },
            State {
                name: "ok"
                PropertyChanges { target: rightMenuButton; icon: "../gfx/icon_key_back.png"; text: "Back"}
            }
        ]
    }
}
