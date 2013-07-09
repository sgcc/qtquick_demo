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

Item {
    id: detailsHolder

    property variant attributes
    property alias contactImage: contactImage.source

    // Stack contact details (attributes found in phoneData)
    // into a column
    Column {
        id: contactDetails

        anchors.left: parent.left
        anchors.leftMargin: columnXOffset
        anchors.top: parent.top
        anchors.topMargin: columnYOffset
        anchors.right: parent.right
        spacing: 5

        // Use Repeater to create a single attribute line
        // for each attibute found in phoneModel
        Repeater {
            model: attributes

            Rectangle {
                id: tab
                width: contactDetails.width - textMarginX
                height: mainContainer.rowheight
                radius: 10
                color: "#424242"
                border.color: "#d5d5d5"
                border.width: 1

                // For each attribute list title,
                // textual data, and an icon
                Text {
                    id: title
                    font.bold: true
                    font.pixelSize: 18
                    text: description + " : "
                    color: 'white'
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: textdata
                    text: value
                    color: 'white'
                    font.pixelSize: 18
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: title.right
                }

                Image {
                    id: actionImage
                    source: actionIcon
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                }

                // If the attribute line has a green phone icon
                // it means the attribute lists a phone number,
                // so by clicking on the item the dial pad is opened
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (actionIcon == "../images/icons/icon_phone_green.png") {
                            dial.dialnumber = value;
                            changeView("dial", true);
                        }
                    }
                }
            }
        }
    }

    // Contact image is placed on the left
    // of the attribute column
    Image {
        id: contactImage

        anchors.left: detailsHolder.left
        anchors.top: detailsHolder.top
        anchors.leftMargin: 40
        anchors.topMargin: 30
        width: 80; height: 70
        fillMode: "PreserveAspectFit"
    }

    // A button to close the detailed view, i.e. set the state back to default ('').
    // Make the button height equal the height of the picture, plus margin.
    Button {
        id: closeButton

        anchors.bottom: detailsHolder.bottom
        anchors.bottomMargin: 20
        anchors.left: detailsHolder.left
        anchors.leftMargin: 40
        buttontext: "Close"
        width: 80
        height: 25
        onClicked: {
            drawer.state = "";
            changeView("book");
        }
    }
}
