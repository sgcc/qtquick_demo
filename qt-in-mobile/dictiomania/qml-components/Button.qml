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
    Button QML Component.
    Emits 'clicked' signal when clicked.
    Properties:
        - text: the text to be displayed on the button
        - disabled: the button is disabled (no mouse interaction is allowed)
        - blinking: the button is blinking (it changes the background of the button and starts the blinking animation)
        - active: the button is active (the background of the button changes)
        - locked: same as disabled but also displays a lock icon
        - icon: the icon to display on the right side of the button (optional)
        - message: shows an optional text message under the button
*/
Rectangle {
    signal clicked
    property string text: "Button"
    property bool disabled: false
    property bool locked: false
    property bool blinking: false
    property bool active: false
    property string icon: ""
    property string message: ""
    property int iconRightMargin: 0

    id: button
    width: parent.width - 50
    height: backgroundLeft.height + (message != "" ? messageItem.height : 0)
    clip: true
    color: Qt.rgba(0,0,0,0)

    MouseArea {
        id: mouseArea
        anchors.fill: parent;
        onClicked: !(button.disabled || button.active || button.blinking || button.locked) ? button.clicked() : ""
    }

    Rectangle {
        id: backgroundContainer
        width: parent.width
        height: backgroundLeft.height
        clip: true
        color: Qt.rgba(0,0,0,0)
        radius: 14

        Row {
            Image {
                id: backgroundLeft
                source: "../gfx/button_left.png"
            }
            Image {
                id: backgroundMiddle
                source: "../gfx/button_middle.png"
                width: backgroundContainer.width - backgroundLeft.width - backgroundRight.width
                fillMode: Image.TileHorizontally
            }
            Image {
                id: backgroundRight
                source: "../gfx/button_right.png"
            }
        }

        Image {
            id: icon
            source: button.icon
            visible: button.icon != ""
            anchors.right: backgroundContainer.right
            anchors.verticalCenter: backgroundContainer.verticalCenter
            anchors.rightMargin: iconRightMargin
        }

        NormalText {
            id: txtItem;
            text: button.text
            anchors.centerIn: backgroundContainer
        }
    }

    Text {
        id: messageItem
        visible: button.message != ""
        text: button.message + (button.locked ? "(locked)" : "")
        anchors.right: backgroundContainer.right
        anchors.top: backgroundContainer.bottom
        anchors.rightMargin: 5
        anchors.topMargin: 2
        anchors.bottomMargin: 8
        font.pixelSize: 18
        color: "#E9DFD3"
    }


    PropertyAnimation {
        id: blink
        running: false
        target: backgroundContainer
        property: "opacity"
        from: 1
        to: 0.7
        duration: 200
        loops: Animation.Infinite
    }

    states: [
        State {
            name: "";
            PropertyChanges { target: backgroundContainer; opacity: 1 }
        },

        State {
            name: "pressed"
            when:  !button.disabled && !button.locked && mouseArea.pressed
            PropertyChanges { target: backgroundLeft; source: "../gfx/button_flashing_left.png" }
            PropertyChanges { target: backgroundMiddle; source: "../gfx/button_flashing_middle.png" }
            PropertyChanges { target: backgroundRight; source: "../gfx/button_flashing_right.png" }
        },
        State {
            name: "locked"
            when: button.locked
            PropertyChanges { target: icon; source: "../gfx/icon_locked.png"; visible: true }
        },
        State {
            name: "blinking"
            extend: "pressed"
            when: button.blinking
            PropertyChanges { target: blink; running: true }
        },
        State {
            name: "active"
            extend: "pressed"
            when: button.active
        }
    ]
}
