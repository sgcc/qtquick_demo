/****************************************************************************
**
** This file is part of RadioTuner
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
    id: range
    property string kind
    property real station
    property real stationRange
    property string stationName

    onKindChanged: {
        if (kind == "high")
            background.source = folder+"high_tick.png";
        else if (kind == "medium")
            background.source = folder+"medium_tick.png";
        else if (kind == "low")
            background.source = folder+"low_tick.png";
        else
            background.source = "";
    }

    Image {
        id: background
        anchors.bottom: bgText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Image {
        id: bgText
        visible: (stationName != "")
        source: folder+"scala_rdslabel.png"
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: name
            text: stationName
            anchors.fill: parent
            anchors.topMargin: 220 * scaleFactor
            anchors.leftMargin: -1 * scaleFactor
            horizontalAlignment: Text.AlignLeft
            color: "#514C4A"
            font.family: "Nokia Sans"
            font.pixelSize: 23 * scaleFactor

            transform: Rotation {
                id: textRotation
                origin.x: 0
                origin.y: 0
                angle: 270
            }
        }
    }

    Text {
        id: rangeText
        x: -10 * scaleFactor
        width: 50 * scaleFactor
        text: parseInt(stationRange)
        color: "#000000"
        font.family: "Nokia Sans"
        font.pixelSize: 25 * scaleFactor
        horizontalAlignment: "AlignHCenter"
        visible: (kind == "high")
    }
}
