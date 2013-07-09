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
    id: helpScreen

    signal backClicked();

    Image {
        source: "images/help/background.png"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: 3300
        contentHeight: helpScreen.height
        boundsBehavior: Flickable.StopAtBounds

        Item {
            width: flickable.contentWidth
            height: flickable.height

            Image {
                x: 40
                anchors.bottom: parent.bottom
                source: "images/help/tap.png"
            }
            Image {
                x: 440
                anchors.bottom: parent.bottom
                source: "images/help/pop.png"
            }
            Image {
                x: 840
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 70
                source: "images/help/peace.png"
            }
            Image {
                x: 1140
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                source: "images/help/rock.png"
            }
            Image {
                x: 1440
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                source: "images/help/bird.png"
            }
            Image {
                x: 1740
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 48
                source: "images/help/ladybug.png"
            }
            Image {
                x: 2040
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 48
                source: "images/help/cloud.png"
            }
            Image {
                x: 2340
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 44
                source: "images/help/tree.png"
            }
            Image {
                x: 2640
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 44
                source: "images/help/balloon.png"
            }
            Image {
                x: 2940
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 70
                source: "images/help/playnow.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: screen.state = "running"
                }
            }
        }
    }

    Image {
        anchors.top: parent.top
        anchors.left: parent.left
        source: "images/help/title.png"
    }

    Button {
        anchors.top: parent.top
        anchors.right: parent.right
        normalImage: "images/buttons/back.png"
        pressedImage: "images/buttons/back2.png"
        onClicked: helpScreen.backClicked();
    }
}
