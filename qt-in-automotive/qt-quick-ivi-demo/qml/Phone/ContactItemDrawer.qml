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

// Contact list item drawer is a basic list item drawer, but
// it has ContactDetails view included in it.
// This allows expanding the list easily when clicking on a
// contact item. Other list items are automatically slided
// away, and details view animations are executed. Similarly,
// When closing the details view, the animations are
// in reverse order
Component {
   Item {
        id: drawer

        // A simple rounded rectangle for the background
        BorderImage {
            id: background
            anchors.fill: parent
            border.left: 20; border.top: 20
            border.right: 20; border.bottom: 20
            source: "../images/bars/listbar_phone.png"
        }

        // Contact name with a rounded rectangle behind it
        Text {
            id: contactNameText
            x: 35
            y: 20
            text: contactname
            font.bold: true
            font.pixelSize: mainContainer.maintextsize
            color: "#FFFFFF"

            Rectangle {
                id: contactNameTextBG

                // Move the backround behind the text
                z: -1
                width: contactNameText.width + 2*textMarginX
                height: mainContainer.rowheight
                anchors.centerIn: parent
                radius: 10
                color: "#424242"
                border.color: "#d5d5d5"
                border.width: 1
                // The backround is visible only when
                // the details view is visible, or the
                // details view is being animated
                opacity: detailsView.opacity
            }
        }

        // When clicking on the contact, a details view
        // is opened. Contact related information is set
        // to the ContactsDetails view
         MouseArea {
            anchors.fill: parent
            onClicked: {
                itemDrawer.state = "details";
                detailsView.contactImage = contactImageSource;
                detailsView.attributes = attributes;
                changeView("book");
            }
         }

        // Place a call icon at the right end of the
        // a contact list item. When the dial button
        // is clicked, the Dialpad view is activated
       Image {
           id: directCallIcon
           source: "../images/icons/icon_phone_green.png"
           anchors.verticalCenter: parent.verticalCenter
           anchors.right: parent.right
           anchors.rightMargin: 20

           MouseArea {
               anchors.fill: parent
               onClicked: {
                   // Set phone number to Dialpad
                   dial.dialnumber = primaryNumber;
                   changeView("dial", true);
               }
           }
        }

        ContactDetails {
           id: detailsView
           width: mainContainer.width - scroller.width
           height: mainContainer.height
           // By default, ContactDetails is not visible
           opacity: 0
        }

        states:
           State {
               name: "details"
               // Make details visible and hide the direct call icon
               PropertyChanges { target: detailsView; opacity: 1 }
               PropertyChanges { target: directCallIcon; opacity: 0 }
               // Move the list so that this item is at the top.
               // The list can not be scrolled while details view is visible
               // (interactive == false)
               PropertyChanges { target: contactList; contentY: itemDrawer.y; interactive: false }
               // Expand the list item height to accommodate ContactDetails
               PropertyChanges { target: itemDrawer; height: detailsView.height - 5 }
               // Slide the contact name to the position used in ContactDetails
               PropertyChanges {target: contactNameText; x: columnXOffset+textMarginX }
           }

        transitions:
           Transition {
               NumberAnimation {
                   properties: "contentY, x, height, opacity"
                   easing.type: "InOutQuad"; duration: 500
               }
           }
    }
}
