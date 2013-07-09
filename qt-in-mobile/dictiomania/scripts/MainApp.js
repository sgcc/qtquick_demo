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

var lastApplicationState = undefined;
var inAbout = false;

function stateChanged(currentState) {
    if(false == inAbout) {
        switch(currentState) {
            case "splash":
                initSelectLangView();
                break;
            case "selectLanguage":
                break;
            case "selectLevel":
                initSelectLevelView();
                break;
            case "selectGameMode":
                initGameModeView();
                break;
            case "gamePlay":
                initGamePlayView();
                break;
            case "finished":
                initFinishedView();
                break;
            case "reset":
            case "about":
                inAbout = true;
                break;
            default:
                console.log("WARNING: untreatead state " + currentState);
                break;
        }
    } else {
        inAbout = false;
    }

    if (currentState != "about") lastApplicationState = currentState;
}

//setup of the Select Language view
function initSelectLangView()
{
    var allLanguages = Preferences.languages;    

    //add supported languages to the UI
    var index = 1;
    var languageToUse = Preferences.getSelectedLanguage();
    for(var langId in allLanguages) {
        var currentLang = allLanguages[langId];
        var i = (langId == languageToUse) ? 0 : index;

        dictiomania.languages.set(i, {displayText: currentLang.text, value: currentLang.id});
        if(langId != languageToUse) index++;
    }    
}

//a language to practice was selected
function languageToLearnSelected() {    
    dictiomania.state = "selectLevel";
}

//calculate the level score for the currently selected language
function getLevelScore(level) {
    var levelScore = 100;
    for (var gameMode in Preferences.gameMode) {
        var score = Preferences.getScore(dictiomania.selectedLanguage, Preferences.level[level], Preferences.gameMode[gameMode]);
        if (!score) {
            levelScore = 0;
            continue;
        }
        if (Preferences.gameMode[gameMode] == Preferences.gameMode.timeAttack) {
            if (score > 40) {
                score = 100;
            }
            else
                if (score > 30) {
                    score = 80;
                }
                else
                    if (score > 20) {
                        score = 70;
                    }
        }
        levelScore = Math.min(levelScore, score);
    }

    return levelScore;
}

function getImageForLevelScore(levelScore) {
    var image = "../gfx/noaward.png";
    if (levelScore >= 95) {
        image = "../gfx/level_icon_gold.png";
    } else {
        if (levelScore >= 75) {
            image = "../gfx/level_icon_silver.png";
        }
        else {
            if (levelScore >= 60) {
                image = "../gfx/level_icon_bronze.png";
            }
        }
    }
    return image;
}

//show the select level view and update the phone menu acordingly
function initSelectLevelView() {
    //add award icons coresponding to each level
    var masterLevelLocked = false;
    for (var level in Preferences.level) {
        var levelScore = getLevelScore(level);
        var levelButton = dictiomania.levels.get(Preferences.level[level]);
        levelButton.buttonIcon = getImageForLevelScore(levelScore);
        dictiomania.levels.set(Preferences.level[level], levelButton);
        if((Preferences.level[level] != Preferences.level.Master) && (levelScore < 75)) {
            masterLevelLocked = true;
        }
    }

    dictiomania.masterLocked = masterLevelLocked;
}

//The user selected the level to use
function levelSelected () {
    if(dictiomania.selectedLevel == Preferences.level.Master && masterLevelLocked) {
        return;
    }
    Dictionary.load(dictiomania.sourceLanguage, dictiomania.selectedLanguage, dictiomania.selectedLevel);
    dictiomania.state = "selectGameMode";
}

function getImageForGameModeScore(levelScore, isTimeAttack) {
    var image = "../gfx/noaward.png";
    if((isTimeAttack && levelScore > 40) || levelScore >= 95) {
        image = "../gfx/level_icon_gold.png";
    } else if ((isTimeAttack && levelScore > 30) || levelScore >= 75) {
        image = "../gfx/level_icon_silver.png";
    } else if ((isTimeAttack && levelScore > 20) || levelScore >= 60) {
        image = "../gfx/level_icon_bronze.png";
    }

    return image;
}

//Show the select Number of questions view (game mode)
function initGameModeView() {
    //add award icons coresponding to each game mode
    var index = 0;
    for(var gameMode in Preferences.gameMode) {
        var currentGameModeButton = dictiomania.gameModes.get(index);
        var score = Preferences.getScore(dictiomania.selectedLanguage, dictiomania.selectedLevel, Preferences.gameMode[gameMode]);

        if (score !== undefined) {
            var isTimeAttack = Preferences.gameMode[gameMode] == Preferences.gameMode.timeAttack;
            currentGameModeButton.buttonMessage = "Best:" + parseInt(score) + (isTimeAttack ? "" : "%");
            currentGameModeButton.buttonIcon = getImageForGameModeScore(score, isTimeAttack);
        } else {
            currentGameModeButton.buttonIcon = "../gfx/noaward.png";
            currentGameModeButton.buttonMessage = "";
        }

        dictiomania.gameModes.set(index, currentGameModeButton);
        index++
    }
}

//Show the game play view
function initGamePlayView() {
    setCurrentQuestion();    
    dictiomania.gamePlayState = "start";
}

//Set the current word to guess and the translation options
function setCurrentQuestion() {
    var currentWords = Dictionary.getRandomWords();
    dictiomania.currentWord = currentWords.word;

    for(var i = 0; i < currentWords.options.length; i++) {
        var listElem = dictiomania.words.get(i);
        listElem.displayText = currentWords.options[i].word;
        listElem.isGoodAnswer = currentWords.options[i].good;
        dictiomania.words.set(i, listElem);
    }
}

//Show the finished view with the award image coresponding to the score
function initFinishedView() {
    var isTimeAttack = dictiomania.selectedGameMode == Preferences.gameMode.timeAttack;

    var finalText;
    if (isTimeAttack) {
        finalText = "You got <b>" + dictiomania.gameScore + "</b> correct answers in " + (dictiomania.timeLimit / 60) + " minutes";
        Preferences.saveScore(dictiomania.selectedLanguage, dictiomania.selectedLevel, dictiomania.selectedGameMode, dictiomania.gameScore);
    } else {
        var ratio = Math.ceil(dictiomania.gameScore * 100 / dictiomania.selectedGameMode);
        finalText = "You got <b>" + dictiomania.gameScore + "</b> out of <b>" + dictiomania.selectedGameMode + "</b> (" + ratio + "%)"
        Preferences.saveScore(dictiomania.selectedLanguage, dictiomania.selectedLevel, dictiomania.selectedGameMode, ratio);
    }

    dictiomania.finalScoreString = finalText;

    var finalState = "";
    if((isTimeAttack && dictiomania.gameScore > 40) || ratio >= 95) {
        finalState = "gold";
    } else if ((isTimeAttack && dictiomania.gameScore > 30) || ratio >= 75) {
        finalState = "silver";
    } else if ((isTimeAttack && dictiomania.gameScore > 20) || ratio >= 60) {
        finalState = "bronze";
    }

    dictiomania.finalState = finalState;
}
