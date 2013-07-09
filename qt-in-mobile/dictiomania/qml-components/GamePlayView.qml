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
    GamePlayView QML Component.
    Emits 'answerSelected' when the user selected a word and 'gamePlayFinished' when the current game is done
    (time finished in 'Time Attack' mode or the user answered the last question)
    Properties:
        - words: the current word options to display (see dictiomania.words)
        - timeLimit: the time limit in seconds (if 'Time Attack' game mode)
        - currentWord: the word to be guessed
        - numberOfQuestions: the total number of questions to be guessed (0 for 'Time Attack' mode)
    Methods:
        - togglePause(value): pause or unpause the game play

*/
View {
    id: gamePlayView

    property ListModel words
    property string currentWord
    property alias gameState: localStatesWrapper.state

    property int score
    property int questionNumber : 1
    property int numberOfQuestions : 0
    property int timeLimit
    property bool questionAnswered : false
    property bool selectedRightAnswer : false
    property int selectedAnswer : -1
    property bool isTimeAttack: gamePlayView.numberOfQuestions == 0
    property bool cardFlipped: gamePlayView.questionNumber % 2 == 0

    signal answerSelected
    signal gamePlayFinished

    function togglePause(value) {
        if(gamePlayView.isTimeAttack) {
            if(value) progressBarAnimation.pause();
            else progressBarAnimation.resume();
        }
    }

    onCurrentWordChanged: cardFlipped ? (wordToGuessTextBack.text = currentWord) : (wordToGuessTextFront.text = currentWord)

    Item {
        id: localStatesWrapper
        state: gamePlayView.gameState
        states: [
            State {
                name: "start"
                PropertyChanges { target: gamePlayView; questionNumber: 1; score: 0; selectedAnswer: -1; restoreEntryValues: false}
                PropertyChanges { target: timeAttackProgressBar; value: 0; restoreEntryValues: false}
                PropertyChanges { target: progressBarAnimation; running: gamePlayView.isTimeAttack; restoreEntryValues: false}
                PropertyChanges { target: wordToGuessTextFront; text: gamePlayView.currentWord; restoreEntryValues: false; explicit: true}                
            },
            State {
                name: "answered"
                PropertyChanges { target: gamePlayView; questionAnswered: true }
            },
            State {
                name: "next"
                PropertyChanges { target: gamePlayView; selectedAnswer: -1 }
                PropertyChanges { target: flipableCardDeck; flipped: gamePlayView.cardFlipped; restoreEntryValues: false }
                StateChangeScript {
                    script: {
                        togglePause(false);
                        gamePlayView.answerSelected();
                    }
                }
            },
            State {
                name: "finished"
                StateChangeScript { script: gamePlayView.gamePlayFinished() }
            }
        ]
    }

    Timer {
        running: questionAnswered;
        interval: selectedRightAnswer ? 1000 : 3000
        onTriggered: {
            questionNumber++;
            gamePlayView.gameState = (numberOfQuestions > 0) && (questionNumber > numberOfQuestions) ? "finished" : "next";
        }
    }

    NumberAnimation {
        id: progressBarAnimation        
        target: timeAttackProgressBar
        property: "value"
        duration: 1000 * timeAttackProgressBar.limit
        from: 0
        to: timeAttackProgressBar.limit
        onCompleted: { if(gamePlayView.gameState != "start") gamePlayView.gamePlayFinished() }
    }

    Grid {
        columns: gamePlayView.landscape ? 2 : 1
        spacing: 10
        width: parent.width        

        Column {
            id: answerQuestionsFirstContainer
            spacing: 10
            width: gamePlayView.landscape ? parent.width / 2 : parent.width

            Image {
                id: answerQuestionViewBack
                source: "../gfx/status_icons.png"
                anchors.horizontalCenter: parent.horizontalCenter

                NormalText {
                    id: questionNumberText
                    text: gamePlayView.questionNumber
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 80
                    font.weight: Font.Bold
                }

                NormalText {
                    id: totalQuestionsText
                    anchors.left: questionNumberText.right
                    anchors.top: questionNumberText.top
                    text: "/" + gamePlayView.numberOfQuestions
                    font.weight: Font.Bold
                    visible: gamePlayView.numberOfQuestions != 0
                }

                NormalText {
                    id: currentScoreText
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 100
                    text: gamePlayView.score * 10
                    font.weight: Font.Bold
                }
            }

            Delimiter {
                ProgressBar {                    
                    id: timeAttackProgressBar
                    width: parent.width
                    height: 3
                    visible: gamePlayView.numberOfQuestions == 0
                    limit: gamePlayView.timeLimit
                }
            }

            VerticalFlipable {
                id: flipableCardDeck
                duration: 500

                front: Image {
                        id: cardDeckImageFront
                        source: "../gfx/card_deck.png"
                        smooth: true

                        NormalText {
                            id: wordToGuessTextFront
                            anchors.centerIn: parent
                            color: "#000"
                            font.weight: Font.Bold
//                            text: gamePlayView.currentWord
                        }
                    }
                back: Image {
                        id: cardDeckImageBack
                        source: "../gfx/card_deck.png"
                        smooth: true

                        NormalText {
                            id: wordToGuessTextBack
                            anchors.centerIn: parent
                            color: "#000"
                            font.weight: Font.Bold
//                            text: gamePlayView.currentWord
                        }
                    }
            }
        }

        Column {
            id: wordOptionsContainer
            spacing: 10
            width: gamePlayView.landscape ? parent.width - answerQuestionsFirstContainer.width : parent.width

            Repeater {
                model: gamePlayView.words
                Button {
                    text: displayText
                    disabled: gamePlayView.questionAnswered
                    blinking: isGoodAnswer && gamePlayView.questionAnswered && (index != gamePlayView.selectedAnswer)
                    active: index == gamePlayView.selectedAnswer
                    onClicked: {
                        togglePause(true);
                        gamePlayView.gameState = "answered";
                        gamePlayView.selectedAnswer = index;
                        gamePlayView.selectedRightAnswer = isGoodAnswer;
                        if(isGoodAnswer) { gamePlayView.score ++; }

                        statusAnswerImage.anchors.top = top;
                        statusAnswerImage.anchors.right = right;
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            SpringImage {
                id: statusAnswerImage;
                source: ""
                visible: gamePlayView.questionAnswered

                states: [
                    State { name: "wrong"; when: !selectedRightAnswer; PropertyChanges { target: statusAnswerImage; source: "../gfx/wrongAnswer.png" } },
                    State { name: "right"; when: selectedRightAnswer ; PropertyChanges { target: statusAnswerImage; source: "../gfx/rightAnswer.png" } }
                ]
            }
        }
    }
}
