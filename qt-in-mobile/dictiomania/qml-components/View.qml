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
    View QML Component.
    A container that expands to the parent's size and takes into account the device orientation.
    Contains the view softkeys on the bottom of the view.
    Emits 'clicked' signal when clicked.
    Emits 'leftKey' and 'rightKey' signals when softKeys are clicked (see SoftKeys.qml).
    Properties:
        - background: the background of the view
        - animationsDuration: the amount of time in miliseconds that size change and rotation animations should play
        - softKeysVisible: true if softKeys should be displayed, false otherwise
        - leftKeyVisible: alias for softKeys.leftKeyVisible (see SoftKeys.qml)
        - rightKeyState: alias for softKeys.rightKeyState (see SoftKeys.qml)
*/
Item {
    signal clicked
    property string background: view.landscape ? "../gfx/background_landscape.jpg" : "../gfx/background.jpg"    

    property int animationsDuration: 500

    property bool landscape: false
    property int rotationAngle: 0

    property real baseWidth: landscape ? parent.width : parent.height
    property real baseHeight: landscape ? parent.height : parent.width
    property variant rotationDelta: parent.width > parent.height ? -90 : 0    


    property bool softKeysVisible: true
    property alias leftKeyVisible: softKeys.leftKeyVisible
    property alias rightKeyState: softKeys.rightKeyState

    signal leftKey
    signal rightKey

    id: view
    width: baseWidth
    height: baseHeight
    anchors.centerIn: parent
    rotation: rotationDelta
    visible: false

    transform: Rotation{
        origin.x: baseWidth / 2
        origin.y: baseHeight / 2
        angle: view.rotationAngle

        Behavior on angle {
            RotationAnimation {
                direction: RotationAnimation.Shortest
                duration: animationsDuration
                easing.type: Easing.InOutQuint
            }
        }
    }

    Behavior on width{
        NumberAnimation { duration: animationsDuration }
    }

    Behavior on height{
        NumberAnimation { duration: animationsDuration }
    }

    Image {
        id: backImage
        source: view.background
        anchors.fill: parent
        smooth: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent        
    }


    Softkeys {
        id: softKeys
        z: 10
        visible: view.softKeysVisible
        onLeftKey: view.leftKey()
        onRightKey: view.rightKey()
    }

    PropertyChanges {}

    states: [
        State {
            name: "Portrait"
            when: runtime.orientation == Orientation.Portrait
            PropertyChanges { target: view; landscape: false; rotationAngle: 0; restoreEntryValues: false }
        },
        State {
            name: "Landscape"
            when: runtime.orientation == Orientation.Landscape
            PropertyChanges { target: view; landscape: true; rotationAngle: 90; restoreEntryValues: false }
        },
        State {
            name: "PortraitInverted"
            when: runtime.orientation == Orientation.PortraitInverted
            PropertyChanges { target: view; landscape: false; rotationAngle: 180; restoreEntryValues: false }
        },
        State {
            name: "LandscapeInverted"
            when: runtime.orientation == Orientation.LandscapeInverted
            PropertyChanges { target: view; landscape: true; rotationAngle: 270; restoreEntryValues: false }
        }
    ]
}
