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
    SelectLanguageView QML Component.
    Use the 'onSelectedLanguageChanged', 'onSoundEnabledChanged' and  'onSourceLanguageChanged' signals to be notified about changes in the view's state
    Properties:
        - soundEnabled: true if sound is enabled, false otherwise
        - languages: the available languages
        - selectedLanguage: the language to learn
        - sourceLanguage: the source language
*/
View {
    id: selectLanguageView    

    property bool soundEnabled
    property ListModel languages
    property string selectedLanguage
    property string sourceLanguage : sourceLanguageDropdown.selectedValue

    Grid {
        columns: selectLanguageView.landscape ? 2 : 1
        spacing: 10
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: selectLanguageView.landscape ? 0 : -5

        Column {
            id: selectLangHeaderContainer

            Image { source: "../gfx/logo.png" }
            Header { text: "My language is:" }
            Dropdown {
                id: sourceLanguageDropdown
                centerIndex: selectLanguageView.landscape ? 3 : 0
                options: languages                
            }
        }

        Column {
            id: languageToLearnContainer
            spacing: 10
            width: selectLanguageView.landscape ? parent.width - selectLangHeaderContainer.width : parent.width

            Header { text: "Practice language:" }
            Repeater {
                model: languages
                ValueButton {
                    text: displayText
                    buttonValue: value
                    onClicked:  selectLanguageView.selectedLanguage = value
                    visible: index != sourceLanguageDropdown.centerIndex
                }
            }
            Checkbox {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Sound";
                checked: selectLanguageView.soundEnabled
                onCheckedChanged: selectLanguageView.soundEnabled = checked
            }
        }
    }
}
