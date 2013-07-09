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
    FinishedView QML Component.
    Emits 'done' when the OK button is clicked
    Properties:
        - score: the final score for the game play
        - numberOfQuestions: the total number of questions played
        - isTimeAttack: the game mode played was "Time Attack"
        - timeLimit: the amout of seconds played (if "Time Attack" mode)
        - finalScoreString: the message to display to the user
        - finalState: the state of thegame play (the prize to show depending on score)
                      see finalViewImage.states for available states
*/
View {
    id: finishedView
    property int score
    property int numberOfQuestions
    property bool isTimeAttack
    property int timeLimit
    property string finalScoreString : "You didn't get anything"
    property string finalState : ""

    signal done

    Grid {
        columns: finishedView.landscape ? 2 : 1
        spacing: 10
        width: parent.width

        Column {
            id: finishedHeaderContainer
            spacing: 5
            width: finishedView.landscape ? finishedViewBack.width - parent.spacing * 3 : parent.width

            Image {
                id: finishedViewBack
                source: "../gfx/status_icons.png"
                anchors.horizontalCenter: finishedHeaderContainer.horizontalCenter

                NormalText {
                    id: questionNumberFinalText
                    text: finishedView.numberOfQuestions
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 80
                    font.weight: Font.Bold
                }

                NormalText {
                    id: totalQuestionsFinalText
                    anchors.left: questionNumberFinalText.right
                    anchors.top: questionNumberFinalText.top
                    text: "/" + finishedView.numberOfQuestions
                    font.weight: Font.Bold
                    visible: !gamePlayView.isTimeAttack
                }

                NormalText {
                    id: finalScoreText
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 100
                    text: finishedView.score * 10
                    font.weight: Font.Bold
                }
            }

            Delimiter {
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                id: acceptScoreButton;
                text: "Ok"
                onClicked: finishedView.done()
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Image {
            id: finalViewImage
            source : "../gfx/end_screen_no_award.png"

            TextInfo {                
                id: finalViewMessage
                anchors.verticalCenter: undefined
                anchors.bottom: finalViewImage.bottom
                anchors.bottomMargin: -height / 4
                width: parent.width - 10
                text: finishedView.finalScoreString + ". Try harder, and maybe you get a better trophy next time!"
            }
            state: finishedView.finalState

            states: [
                State {
                    name: "silver"
                    PropertyChanges { target: finalViewImage; source: "../gfx/end_screen_silver.png" }
                    PropertyChanges { target: finalViewMessage; text: finishedView.finalScoreString + ", which entitles you to a silver trophy. You are only one step away from being a grand champion!" }
                },
                State {
                    name: "bronze"
                    PropertyChanges { target: finalViewImage; source: "../gfx/end_screen_bronze.png" }
                    PropertyChanges { target: finalViewMessage; text: finishedView.finalScoreString + ", which entitles you to a nice bronze trophy. Try to get silver next." }
                },
                State {
                    name: "gold"
                    PropertyChanges { target: finalViewImage; source: "../gfx/end_screen_gold.png" }
                    PropertyChanges { target: finalViewMessage; text: finishedView.finalScoreString + ". You surely deserve your golden trophy. Well done! Now try with harder difficulty level." }
                }
            ]
        }
    }
}
