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

// A component displaying two alternative
// choice values. By default, the selectable
// values are 'Work trip' and 'Freetime'
Rectangle {
    id: container

    property int textsize: 18
    property string textcolor: "white"
    property string currType: type1
    property alias type1: state1Text.text
    property alias type2: state2Text.text

    width: state1Text.width+state2Text.width+40
    height: state2Text.height
    radius: 8
    border.color: "#d5d5d5"
    color: "#323232"

    // A highlight that slides left to right when
    // selecting a value
    Rectangle {
        id: highlight
        height: state1Text.height+10
        width: state1Text.width+20
        radius: 8
        border.color: "#d5d5d5"
        color: "#424242"
        anchors.verticalCenter: state2Text.verticalCenter
    }

    Text {
        id: state1Text
        text: "Work trip"
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pixelSize: container.textsize
        color: container.textcolor
    }

    Text {
        id: state2Text
        text: "Freetime"
        anchors.left: state1Text.right
        anchors.leftMargin: 20
        font.pixelSize: container.textsize
        color: container.textcolor
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (container.state == "")
                container.state = "state2";
            else
                container.state = "";
        }
    }

    states:
        State {
            name: "state2"
            PropertyChanges {
                target: highlight
                x: state2Text.x-10
                width: state2Text.width+20
            }
            PropertyChanges {
                target: container
                currType: state2Text.text
            }
        }

    transitions:
        Transition {
            NumberAnimation {properties: "x,width"; easing.type: "InOutQuad"; duration: 200}
        }
}
