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

import "scripts/preferences.js" as Preferences
import "scripts/dictionary.js" as Dictionary
import "scripts/database.js" as Database
import "scripts/MainApp.js" as MainApplication
import "qml-components"

Rectangle {
    id: dictiomania

    property alias soundEnabled : selectLanguageView.soundEnabled
    property alias selectedLanguage: selectLanguageView.selectedLanguage
    property alias sourceLanguage: selectLanguageView.sourceLanguage

    property alias masterLocked : selectLevelView.masterLocked
    property alias selectedLevel : selectLevelView.selectedLevel

    property alias selectedGameMode : selectGameModeView.selectedGameMode

    property alias gameScore : gamePlayView.score
    property alias currentWord : gamePlayView.currentWord
    property alias gamePlayState: gamePlayView.gameState
    property alias questionNumber: gamePlayView.questionNumber

    property alias finalScoreString: finishedView.finalScoreString
    property alias finalState: finishedView.finalState

    property ListModel languages : ListModel {
        ListElement {displayText: "'English'"; value: "en" }
        ListElement {displayText: "'French'"; value: "fr" }
        ListElement {displayText: "'Italian'"; value: "it" }
        ListElement {displayText: "'Spanish'"; value: "es" }
    }
    property ListModel levels : ListModel {
        ListElement {displayText: "Beginner"; value: 0; buttonIcon: "../gfx/noaward.png" }
        ListElement {displayText: "Advanced"; value: 1; buttonIcon: "../gfx/noaward.png"}
        ListElement {displayText: "Challenging"; value: 2; buttonIcon: "../gfx/noaward.png" }
        ListElement {displayText: "Master"; value: 3; buttonIcon: "../gfx/noaward.png" }
    }
    property ListModel gameModes : ListModel {
        ListElement {displayText: "10 questions"; value: 10; buttonIcon: "../gfx/noaward.png"; buttonMessage: "" }
        ListElement {displayText: "25 questions"; value: 25; buttonIcon: "../gfx/noaward.png"; buttonMessage: "" }
        ListElement {displayText: "50 questions"; value: 50; buttonIcon: "../gfx/noaward.png"; buttonMessage: "" }
        ListElement {displayText: "Time Attack"; value: 0; buttonIcon: "../gfx/noaward.png"; buttonMessage: "" }
    }
    property ListModel words : ListModel {
        ListElement {displayText: "'Word 1'"; isGoodAnswer: false }
        ListElement {displayText: "'Word 2'"; isGoodAnswer: false }
        ListElement {displayText: "'Word 3'"; isGoodAnswer: false }
        ListElement {displayText: "'Word 4'"; isGoodAnswer: false }
    }

    width: 800
    height: 480
    color: Qt.rgba(0,0,0,0)
    state: "splash"

    onStateChanged: MainApplication.stateChanged(dictiomania.state)
    Component.onCompleted: dictiomania.soundEnabled = Preferences.getSoundState();

    states: [
        State {
            name: "splash"
            PropertyChanges { target: splashScreenView; visible: true }            
        },
        State {            
            name: "selectLanguage"            
            PropertyChanges { target: selectLanguageView; selectedLanguage: ""; restoreEntryValues: false }
            PropertyChanges { target: selectLanguageView; visible: true }
        },        
        State {
            name: "selectLevel"            
            PropertyChanges { target: selectLevelView; selectedLevel: -1; restoreEntryValues: false }
            PropertyChanges { target: selectLevelView; visible: true }
        },
        State {
            name: "selectGameMode"
            PropertyChanges { target: selectGameModeView; selectedGameMode: -1; restoreEntryValues: false }
            PropertyChanges { target: selectGameModeView; visible: true }
        },
        State {
            name: "gamePlay"
            PropertyChanges { target: gamePlayView; visible: true }
        },
        State {
            name: "finished"
            PropertyChanges { target: finishedView; visible: true }
        },
        State {
            name: "about"
            PropertyChanges { target: aboutView; visible: true }
        }
    ]

    SplashScreenView {
        id: splashScreenView
        softKeysVisible: false
        MouseArea {
            anchors.fill: parent
            onClicked: dictiomania.state = "selectLanguage"
        }
    }

    /*
        In this view the user can select the source language and the language to learn
        Visible in "selectLanguage" state (see dictiomania.states)
    */
    SelectLanguageView {
        id: selectLanguageView
        languages: dictiomania.languages
        rightKeyState: "exit"
        onSelectedLanguageChanged: visible ? MainApplication.languageToLearnSelected() : ''
        onSoundEnabledChanged: visible ? Preferences.saveSoundState(dictiomania.soundEnabled) : ''
        onSourceLanguageChanged: visible ? Preferences.saveSourceLanguage(dictiomania.sourceLanguage) : ''
        onLeftKey: dictiomania.state = "about"
        onRightKey: Qt.quit()
    }   

    /*
        In this view the user can select from 4 available levels (see dictiomania.levels)
        Visible in "selectLevel" state (see dictiomania.states)
    */
    SelectLevelView {
        id: selectLevelView
        levels: dictiomania.levels
        rightKeyState: "back"
        onSelectedLevelChanged: visible ? MainApplication.levelSelected() : ''
        onLeftKey: dictiomania.state = "about"
        onRightKey: dictiomania.state = "selectLanguage"
    }

    /*
        In this view the user can select from 4 available levels (see dictiomania.gameModes)
        Visible in "selectGameMode" state (see dictiomania.states)
    */
    SelectGameModeView {
        id: selectGameModeView
        gameModes: dictiomania.gameModes
        rightKeyState: "back"
        onSelectedGameModeChanged: visible ? dictiomania.state = "gamePlay" : ''
        onLeftKey: dictiomania.state = "about"
        onRightKey: dictiomania.state = "selectLevel"
    }

    /*
        In this view the user plays the game (normal or time attack mode)
        Visible in "gamePlay" state (see dictiomania.states)
    */
    GamePlayView {
        id: gamePlayView
        words: dictiomania.words
        numberOfQuestions: dictiomania.selectedGameMode
        timeLimit: Preferences.timeLimit
        rightKeyState: "quit"
        onAnswerSelected: MainApplication.setCurrentQuestion()
        onGamePlayFinished: dictiomania.state = "finished"
        onLeftKey: { gamePlayView.togglePause(true); dictiomania.state = "about" }
        onRightKey: { gamePlayView.togglePause(true); dictiomania.state = "selectLevel" }
    }

    /*
        In this view the user is presented with the prize won during game play.
        Visible in "finished" state (see dictiomania.states)
    */
    FinishedView {
        id: finishedView
        score: dictiomania.gameScore
        numberOfQuestions: isTimeAttack ? dictiomania.questionNumber : dictiomania.selectedGameMode
        isTimeAttack: dictiomania.selectedGameMode == Preferences.gameMode.timeAttack
        timeLimit: Preferences.timeLimit
        softKeysVisible: false
        onDone: dictiomania.state = "selectLanguage"
    }

    /*
        In this view the user can see information about the creator of the application
        Visible in "about" state (see dictiomania.states)
    */
    AboutView {
        id: aboutView
        rightKeyState: "back"
        leftKeyVisible: false
        onRightKey: {
            dictiomania.state = MainApplication.lastApplicationState
            if(dictiomania.state == "gamePlay") {
                gamePlayView.togglePause(false);
            }
        }
    }
}
