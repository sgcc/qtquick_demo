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

// Lists widget for applications
// Set of widgets is defined in homeWidgets
// component in dummydata.
Item {
    // Reset the home item list to
    // default values from dummydata
    function resetList() {
        model.clear();
        for (var i=0; i < homeWidgets.count; i++)
            model.append(homeWidgets.get(i));
    }

    Component {
        id: itemDrawer

        // List item drawer for status texts
        Item {
            width: widgetList.width
            height: 74

            // Listen for data change events from the related
            // application. If data changed, change the model
            // data, insead of tthe delegate. By changing
            // the model, data is not destroyed with the delegate.
            // (Delegates may get created and deleted during list
            // lifecycle)
            Connections {
                target: appFw
                onAppDataChanged: {
                    if (appName == dataSource) {
                     if (data.description)
                        ListView.view.model.set(index, { descriptionText: data.description });
                     if (data.title)
                        ListView.view.model.set(index, { titleText: data.title });
                     if (data.status)
                        ListView.view.model.set(index, { statusText: data.status });
                     if (data.other)
                        ListView.view.model.set(index, { otherText: data.other });
                    }
                }
            }

            // Background image for the list item
            BorderImage {
                id: background
                border.left: 93
                border.top: 2
                border.right: 25
                border.bottom: 2
                horizontalTileMode: BorderImage.Repeat
                width: widgetList.width
                height:  74
                source: backgroundImage

                // When clicking the item, the handling is
                // done in a concrete component
                MouseArea {
                    anchors.fill: parent
                    onClicked:  {
                        if (launchApp)
                            changeApp(launchApp);
                    }
                }
            }

            // Draw the icon and desctiption info piled up
            // and the title and texts on their side
            Column{
                x:25
                anchors.verticalCenter:background.verticalCenter

                Image {
                    id: icon
                    source: iconSource
                }

                Text {
                    id: descriptionField
                    anchors.horizontalCenter: icon.horizontalCenter
                    text: descriptionText
                    color: "white"
                    font.pixelSize: 12
                }
            }

            Text {
                id: titleField
                x: 100
                anchors.verticalCenter: background.verticalCenter
                text: titleText
                color: "white"
                font.pixelSize: 18
            }

            Text {
                id: statusField
                text:statusText
                color: "white"
                font.pixelSize: 12
                anchors.top: titleField.bottom
                anchors.topMargin: 5
                anchors.left: titleField.left
                anchors.leftMargin: 50
            }

            Text {
                id: otherField
                text: otherText
                color: "white"
                font.pixelSize: 18
                anchors.verticalCenter: parent.verticalCenter
                x: 400
            }
        }
    }

    ListModel {
        id: model
    }

    // The list that draws status texts
    ListView {
        id: widgetList
        width: parent.width - scroller.width
        height: parent.height
        model: model
        delegate: itemDrawer
        spacing: 20
        focus: false
    }

    // Scroll indicator
    ScrollIndicator {
        id: scroller
        anchors.left:widgetList.right
        anchors.top: widgetList.top
        anchors.bottom: widgetList.bottom
        position: widgetList.visibleArea.yPosition
        zoom: widgetList.visibleArea.heightRatio
        shown: widgetList.moving
    }
}
