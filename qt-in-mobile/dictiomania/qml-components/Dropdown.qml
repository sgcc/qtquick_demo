/*
 This file is part of Dictiomania

 Copyright (c) 2010 Movial Creative Technologies Inc. and Nokia Corporation
 and/or its subsidiary(-ies).

 All rights reserved.

 Contact: Movial Creative Technologies Inc. (info@movial.com) or
 Qt Development Frameworks Information (qt-info@nokia.com)

 You may use this file under the terms of the BSD license as follows:

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
     * Neither the name of the Movial Creative Technologies Inc. nor Nokia
       Corporation and its Subsidiary(-ies) or the names of its contributors
       may be used to endorse or promote products derived from this software
       without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import Qt 4.7

/*
    Dropdown QML Component.
    Use the 'onSelectedValueChanged' signal to be notified when the selected value has changed
    Properties:
        - options: the ListModel to be used for te options available in the dropdown
                   the ListElement in the model have the following properties: ListElement { displayText: "Display Text"; value: "option-value" }
        - selectedValue: the value of the item selected in the dropdown
        - centerIndex: the index of the option that should be the selected one (should be in the following interval: 0-(options.count-1))
*/
Rectangle {    
    property ListModel options
    property int centerIndex: 0
    property int oldIndex: 0
    property string selectedValue: mainButton.buttonValue

    id: dropDown
    width: parent.width
    height: mainButton.height
    color: Qt.rgba(0,0,0,0)
    clip: true
    radius: 14    
    state: "closed"

    onCenterIndexChanged:  { options.move(oldIndex, centerIndex, 1); oldIndex = centerIndex }

    states: [
        State {
            name: "closed"
            PropertyChanges { target: dropDown; clip: true }
            PropertyChanges { target: mainButton; z: 1 }
            PropertyChanges { target: parent; z: 0 }
            PropertyChanges { target: dropBackground; color: Qt.rgba(0,0,0,0) }
        },
        State {
            name: "open"
            PropertyChanges { target: dropDown; clip: false }
            PropertyChanges { target: mainButton; z: 0 }
            PropertyChanges { target: parent; z: 1 }
            PropertyChanges { target: dropBackground; color: Qt.rgba(0,0,0,0.8) }
        }
    ]    

    ValueButton {
        id: mainButton
        text: optionsContainer.children[0].text
        buttonValue: optionsContainer.children[0].buttonValue
        onClicked: dropDown.state = "open"
        icon: "../gfx/icon_dropdown.png"
        iconRightMargin: 24
    }

    Component {
        id: optionDelegate
        ValueButton {
            text: displayText
            buttonValue: value
            onClicked: { dropDown.state = "closed"; options.move(index, dropDown.centerIndex, 1); mainButton.text = text; mainButton.buttonValue = value; }
            icon: index == dropDown.centerIndex ? "../gfx/icon_dropdown.png" : ""
            iconRightMargin: 24
        }
    }

    Rectangle {
        id: dropBackground
        width: optionsContainer.childrenRect.width - optionsContainer.spacing * 4
        height: optionsContainer.childrenRect.height
        anchors.horizontalCenter: parent.horizontalCenter
        transform: Translate { y: - (childrenRect.height + optionsContainer.spacing) * dropDown.centerIndex/options.count  }
        radius: 14

        MouseArea {
            anchors.fill: parent
            onClicked: ;
        }
    }

    Column {
        id: optionsContainer
        spacing: 5
        anchors.fill: parent
        transform: Translate { y: - (childrenRect.height + optionsContainer.spacing) * dropDown.centerIndex/options.count  }

        Repeater {
            id: optionsRepeater
            model: options
            delegate: optionDelegate
        }
    }
}
