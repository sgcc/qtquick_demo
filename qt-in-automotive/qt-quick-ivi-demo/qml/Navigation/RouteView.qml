/** This file is part of QtQuickIVIDemo**

Copyright  2010 Nokia Corporation and/or its subsidiary(-ies).*
All rights reserved.

Contact:  Nokia Corporation qt-info@nokia.com

You may use this file under the terms of the BSD license as follows:

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
  the names of its contributors may be used to endorse or promote
  products derived from this software without specific prior written
  permission.


THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
*/
import Qt 4.7
import "../shared"

// RouteView displays input fields for
// defining route start and end points.
// Column is wrapped inside Item to allow centering
// the column within the view
Item {
     id: routeView

    // Aliases are used access the routeTo/routeFrom
    // information of the view
    property alias routeTo: editRouteTo.text
    property alias routeFrom: editRouteFrom.text

    Column {
        anchors.centerIn: parent
        spacing:15

        // Title for route start location input field
        Text {
            id: routeFromText
            text: "Route from:"
            font.pixelSize: 20
            font.bold: true
            color: "white"
        }

        // Arrange start location icon and input field in row
        Row {
            id: routeFrom
            height: editRouteFrom.height
            spacing: 15

            // 'A' icon
            Image {
                id: iconA
                source: "../images/icons/icon_routepoint.png"

                // 'A' text can not be aligned with anchors.centerIn
                // as the image behind it is not symmetrical
                Text {
                    text: "A"
                    anchors.bottom: iconA.bottom
                    anchors.bottomMargin: 10
                    anchors.left: iconA.left
                    anchors.leftMargin: 25
                    font.pixelSize: 24
                    font.bold: true
                    color: "white"
                }
            }

            // Input field for the start location
            InputBox {
                id: editRouteFrom

                anchors.verticalCenter: parent.verticalCenter
                width:routeView.width - iconB.width - 150
                height:40
                pixelSize: 18
                label: "Route from"
                text: ""
            }
        }

        // Title for route end location input field
        Text {
            id: routeToText
            text: "Route to:"
            font.pixelSize: 20
            font.bold: true
            color: "white"
        }

        // Arrange end location icon and input field in row
        Row {
            id: routeTo
            height: editRouteTo.height
            spacing: 15

            // Icon 'B'
            Image {
                id: iconB
                source: "../images/icons/icon_routepoint.png"

                // 'B' text can not be aligned with anchors.centerIn
                // as the image behind it is not symmetrical
                Text {
                    text: "B"
                    anchors.left: iconB.left
                    anchors.leftMargin: 25
                    anchors.bottom: iconB.bottom
                    anchors.bottomMargin: 9
                    font.pixelSize: 24
                    font.bold: true
                    color: "white"
                }
            }

            // Input field for the end location
            InputBox {
                id: editRouteTo

                anchors.verticalCenter: iconB.verticalCenter
                width:routeView.width - iconB.width -150
                height:40
                pixelSize: 18
                label: "Route to"
                text: ""
            }
        }
    }
}
