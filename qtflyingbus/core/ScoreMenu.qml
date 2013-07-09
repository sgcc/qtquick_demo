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
    signal menuClicked();

    property int highScore : -1
    property int playerScore : -1
    property bool special : false

    Image {
        x: 140
        y: 220
        source: "images/menu/dot.png"
    }

    Image {
        x: 240
        y: 208
        source: "images/menu/dot.png"
    }

    Image {
        x: 100
        y: 230
        source: "images/menu/yourscore.png"
    }

    Image {
        x: 198
        y: 240
        source: "images/menu/menu_div.png"
    }

    Image {
        x: 220
        y: 215
        source: "images/menu/highscore.png"
    }

    DigitLabel {
        x: 100
        y: 268
        rotation: -7
        value: playerScore
    }

    DigitLabel {
        x: 220
        y: 251
        rotation: -7
        value: highScore
    }

    Item {
        x: special ? 450 : 410
        y: special ? 230 : 198
        rotation: special ? 18 : 0

        Image {
            x: 40
            y: -16
            source: "images/menu/dot.png"
        }

        Button {
            smooth: true
            normalImage: "images/menu/button/menu.png"
            pressedImage: "images/menu/button/menu_pressed.png"
            onClicked: menuClicked();
        }
    }
}
