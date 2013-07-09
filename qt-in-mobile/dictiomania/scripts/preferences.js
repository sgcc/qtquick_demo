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
//list of supported languages
var languages = {
    en: {        
        id : "en",
        text: "English",
    },
    fr: {        
        id : "fr",
        text: "French",
    },
    it: {        
        id : "it",
        text: "Italian",
    },
    es: {        
        id : "es",
        text: "Spanish",
    },
};

/*
    @return int The code of the previously selected language or default to English
*/
function getSelectedLanguage() {
    var lang = Database.preferenceForKey('languageToUse');

    if (lang && languages[lang]) {
        return lang;
    } else {
        return Preferences.languages.en.id;
    }
}

//list of supported levels
var level = {
    Beginner: 0,
    Advanced : 1,
    Challenging: 2,
    Master : 3
}

//list of supported game modes
var gameMode = {
    questions10 : 10,
    questions25 : 25,
    questions50: 50,
    timeAttack : 0,
}

//save the score coresponding to language, level and gameMode to persistent storage
function saveScore (language, level, gameMode, hitRatio) {
    var prefName = "lang[" + language + "]level[" + level + "]gameMode[" + gameMode + "]";

    var existingHitRatio = Database.preferenceForKey(prefName);
    if(!existingHitRatio || parseInt(existingHitRatio) < hitRatio) {
        Database.setPreferenceForKey(Math.round(hitRatio), prefName);
    }
}

//save sound state (on or off), not used
function saveSoundState (state){    
    var prefName = "soundEnabled";
    Database.setPreferenceForKey(state ? 1 : 0, prefName);
}

//load the score coresponding to language, level and gameMode from persistent storage
function getScore (language, level, gameMode) {
    var prefName = "lang[" + language + "]level[" + level + "]gameMode[" + gameMode + "]";
    return Database.preferenceForKey(prefName);
}

//load sound state (on or off), not used
function getSoundState (){
    var prefName = "soundEnabled";
    var value = Database.preferenceForKey(prefName);
    if(value === undefined) {
        value = "1";
    }
    return parseInt(value);
}

function saveSourceLanguage(language) {
    Database.setPreferenceForKey(language, 'languageToUse');
}

//the time limit for "Time Attack" game mode
var timeLimit = 180;
