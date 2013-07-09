/****************************************************************************
**
** This file is part of CoffeeTweed
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

Rectangle {
    id: root

    property real scaleFactor: root.width/800.0

    property int coffeeCount: 0
    property int coffeeTotal: 12
    property bool isAdding: false
    property bool isAnimating: false
    property bool animationHappening: root.isAnimating || cup.isAnimating

    signal doTransition()

    function addOne() {
        if (!animationHappening && coffeeCount < coffeeTotal) {
            isAdding = true;
            isAnimating = true;
            cup.state = "less_one";
            doTransition();
            tray.addCup(coffeeCount + 1);
        }
    }

    function removeOne() {
        if (!animationHappening && coffeeCount > 0) {
            isAdding = false;
            isAnimating = true;
            doTransition();
            tray.removeCup(coffeeCount - 1);
        }
    }

    Image {
        id: bg
        source: folder + "bg.png"
        anchors.bottom: root.bottom
    }

    Text {
        id: counterUp
        y: 65 * scaleFactor
        text: coffeeTotal - coffeeCount
        color: "white"
        font.bold: true
        font.pixelSize: 100
        anchors.right: toGo.left
        anchors.rightMargin: 12
    }

    Text {
        id: counterDown
        text: coffeeCount
        y: 31 * scaleFactor
        color: "#999999"
        font.bold: true
        font.pixelSize: 50 * scaleFactor
        anchors.right: cupsDown.left
        anchors.rightMargin: 12
    }

    Text {
        id: toGo;
        x: 345 * scaleFactor
        y: 65 * scaleFactor
        text: "to go"
        font.pixelSize: 100 * scaleFactor
        font.letterSpacing: -2
        color: "white"
    }

    Text {
        id: cupsDown
        x: 390 * scaleFactor
        y: 31 * scaleFactor
        text: "cups down"
        font.pixelSize: 50 * scaleFactor
        font.letterSpacing: -2
        color: "#999"
    }

    onDoTransition: transition.running = true;
    SequentialAnimation { id: transition
        running: false
        loops: 1
        ParallelAnimation {
            PropertyAnimation { target: counterUp; property: "opacity"; to: 0.0; }
            PropertyAnimation { target: counterDown; property: "opacity"; to: 0.0; }
        }
        PauseAnimation { duration: isAdding ? 1500 : 300; }
        PropertyAction { target: root; property: "coffeeCount"; value: coffeeCount + (isAdding ? 1 : -1); }
        ParallelAnimation {
            PropertyAnimation { target: counterUp; property: "opacity"; to: 1.0; }
            PropertyAnimation { target: counterDown; property: "opacity"; to: 1.0; }
        }
        PropertyAction { target: root; property: "isAnimating"; value: false; }
    }

    Tray {
        id: tray
        x: 335 * scaleFactor
        y: 225 * scaleFactor
    }

    Cup {
        id: cup
        x: 120 * scaleFactor
        y: 0
    }

    Button {
        x: -7 * scaleFactor
        y: 100 * scaleFactor
        sourceOn: folder+"bt_add_on.png"
        sourceOff: folder+"bt_add_off.png"
        onClicked: addOne()
    }

    Button {
        x: 619 * scaleFactor
        y: 100 * scaleFactor
        sourceOn: folder+"bt_remove_on.png"
        sourceOff: folder+"bt_remove_off.png"
        onClicked: removeOne()
    }

    Button {
        id: bt_close
        anchors.top: parent.top
        anchors.right: parent.right
        sourceOff: folder + "close.png"

        onClicked: Qt.quit()
    }
}
