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

Item {
    id: root
    width: window.width

    property string currentMessage;

    signal gotoCity(string cityId);

    MouseArea {
        id: overlay
        anchors.fill: parent
        visible: false
        onClicked: root.state = ""
    }

    Image {
        id: backPanel
        opacity: 0.0
        y: frontPanel.y
        source: folder + "city_panel_bg.png"
    }

    Rectangle {
        id: cityRect
        x: 0
        y: 36
        width: 360
        color: "#071217"
        opacity: 0.0
        anchors.topMargin: -1
        anchors.top: backPanel.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        height: (100 * Math.min(cityModel.count, 5) + 23) * scaleFactorY

        Component {
            id: cityDelegate
            Item {
                id: cityItem
                width: background.width
                height: background.height

                ListView.onRemove: SequentialAnimation {
                    PropertyAction { target: cityItem; property: "ListView.delayRemove"; value: true }
                    NumberAnimation { target: cityItem; property: "opacity"; to: 0 }
                    NumberAnimation { target: cityItem; property: "height"; to: 0; duration: 9000; }
                    PropertyAction { target: cityItem; property: "ListView.delayRemove"; value: false }
                }

                ListView.onAdd: SequentialAnimation {
                    PropertyAction { target: cityItem; property: "opacity"; value: 0 }
                    NumberAnimation { target: cityItem; property: "height"; from: 0; to: background.height; duration: 9000;}
                    NumberAnimation { target: cityItem; property: "opacity"; from: 0; to: 1 }
                }

                Image {
                    id: background;
                    source: folder + "list_item_bg.png"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: { root.gotoCity(cityId); }
                    }
                }

                Text {
                    text: cityName
                    color: "white"
                    font.family: "Nokia Sans"
                    font.pixelSize: 38
                    anchors.fill: parent
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30
                    verticalAlignment: "AlignVCenter"
                }
            }
        }

        ListView {
            id: cityListView;
            clip: true;
            model: cityModel
            opacity: 0.0
            delegate: cityDelegate
            anchors.fill: cityRect
            anchors.topMargin: -17
            anchors.bottomMargin: 50 * scaleFactorY

            ScrollBar {
                id: scroll
                pageSize: cityListView.height / cityListView.contentHeight
                position: cityListView.contentY / cityListView.contentHeight
                anchors.top: cityListView.top
                anchors.bottom: cityListView.bottom
                anchors.right: cityListView.right
                anchors.rightMargin: 10
                anchors.bottomMargin: 15
                width: 8
            }
        }
    }

    Image {
        id: frontPanel
        source: folder + "city_name_background_bigger.png"
        anchors.bottom: root.bottom
        MouseArea {
            anchors.fill: frontPanel
            onClicked: { root.state = "final"; }
        }
    }

    states : State {
        name: "final"
        PropertyChanges { target: frontPanel; opacity: 0.0; visible: false; }
        PropertyChanges { target: backPanel; opacity: 1.0; }
        PropertyChanges { target: cityRect; opacity: 1.0; }
        PropertyChanges { target: backPanel; y: root.height - cityRect.height; }
        PropertyChanges { target: overlay; visible: true; }
        PropertyChanges { target: cityListView; opacity: 1.0; }
    }

    transitions: [Transition {
        from: ""; to: "final"
        SequentialAnimation {
            ParallelAnimation {
                NumberAnimation { target: backPanel; properties: "opacity"; duration: 300 }
                NumberAnimation { target: cityRect; properties: "opacity"; duration: 300 }
            }
            NumberAnimation { target: frontPanel; properties: "opacity"; duration: 300 }
            NumberAnimation { target: frontPanel; properties: "visible"; duration: 0 }
            NumberAnimation { target: backPanel; properties: "y"; duration: 250 }
            NumberAnimation { target: cityListView; properties: "opacity"; duration: 200 }
        }
    },

    Transition {
        from: "final"; to: ""
        SequentialAnimation {
            NumberAnimation { target: cityListView; properties: "opacity"; duration: 200 }
            NumberAnimation { target: backPanel; properties: "y"; duration: 250 }
            NumberAnimation { target: frontPanel; properties: "opacity"; duration: 300 }
            NumberAnimation { target: frontPanel; properties: "visible"; duration: 0 }
            ParallelAnimation {
                NumberAnimation { target: backPanel; properties: "opacity"; duration: 300 }
                NumberAnimation { target: cityRect; properties: "opacity"; duration: 300 }
            }
        }
   }]
}
