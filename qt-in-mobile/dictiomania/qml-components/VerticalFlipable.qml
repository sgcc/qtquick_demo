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
    VerticalFlipable QML Component.
    Flips between it's front and back sides using a rotation animation around the y axis.
    Emits 'done' signal when the rotation animation is done.
    Properties:
        - flipped: if false display front side, otherwise display back side
        - duration: the amount of time in miliseconds the animation should play
*/
Flipable {
    signal done
    property bool flipped: false
    property int angle: 0
    property int duration: 1000

    id: flipable
    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
    height: childrenRect.height
    width: childrenRect.width
    smooth: true;    

    transform: Rotation {
         origin.x: flipable.width/2; origin.y: flipable.height/2
         axis.x: 0; axis.y: 1; axis.z: 0     // rotate around y-axis
         angle: flipable.angle
     }

     states: State {
         name: "back"
         PropertyChanges { target: flipable; angle: 180 }
         when: flipable.flipped
     }

     transitions: Transition {
         NumberAnimation { properties: "angle"; duration: flipable.duration; onCompleted: flipable.done() }
     }
}
