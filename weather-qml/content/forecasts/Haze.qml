/****************************************************************************
**
** This file is part of Weather
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
import "elements"
import "../"

ForecastView {
    id: root
    isClear: false

    SmallCloud {
        id: cloud2
        x: scaledX(341)
        y: scaledY(-800)
        finalY: scaledY(-469);
        type: "cloud_rain"
    }

    HungItem {
        id: sun
        x: isDay ? scaledX(198) : scaledX(220)
        y: scaledY(-800)
        itemX: 0
        itemY:  isDay ? 176 : 180
        height:  isDay ? 460 : 440
        finalY: isDay ? scaledY(-255) : scaledY(-205)
        itemImage: isDay ? folder + "cold_sun.png" : folder + "moon.png"
        lineImage: isDay ? folder + "cold_sun_line.png" : folder + "moon_line.png"
    }

    MediumCloud {
        id: cloud1
        x: scaledX(6)
        y: scaledY(-800)
        finalY: scaledY(-296)
        type: "cloud_rain"
    }

    Image {
        id: haze
        x: scaledX(-30)
        source: "../" + folder + "haze.png"
    }

    states : State {
        name: "final"
        PropertyChanges { target: sun; y: sun.finalY; }
        PropertyChanges { target: cloud1; y: cloud1.finalY; }
        PropertyChanges { target: cloud2; y: cloud2.finalY; }
    }

    transitions: Transition {
        SequentialAnimation {
            ParallelAnimation {
               NumberAnimation { target: cloud1; properties: "y";
                                 easing.type: "OutBack"; duration: 500 }

               SequentialAnimation {
                   PauseAnimation { duration: 200 }
                   NumberAnimation { target: cloud2; properties: "y";
                                     easing.type: "OutBack"; duration: 500 }
               }
            }

            NumberAnimation { target: sun; properties: "y";
                              easing.type: "OutBack"; duration: 500 }
        }
    }

    onPresent: { root.state = "final"; }
}
