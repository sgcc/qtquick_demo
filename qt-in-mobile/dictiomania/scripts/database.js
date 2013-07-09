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

var database = null;

/*
    Open the database in which we save games scores and preferences
*/
function openDatabase() {
    if(null == database) {        
        database = openDatabaseSync("Dictiomania", "1.0", "Dictiomania Settings!", 100);
         database.transaction(
             function(tx) {
                 // Create the database if it doesn't already exist
                 tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(name TEXT, value TEXT)');
             });
     }
}

/*
  Save application preferences: 'name' has value 'value'
*/
function setPreferenceForKey(value, name) {    
    openDatabase();
    database.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT * FROM Settings WHERE name=?', [name]);
            if(rs.rows.length == 0) {                
                tx.executeSql('INSERT INTO Settings VALUES(?, ?)', [ name, value ]);
            } else {                
                tx.executeSql('UPDATE Settings SET value=? WHERE name=?', [ value, name ]);
            }
        }
    );
}

/*
  Load application preferences, get value saved for 'name'
*/
function preferenceForKey(name) {
    var value = undefined;
    openDatabase();
    database.transaction(
        function(tx) {            
            var rs = tx.executeSql('SELECT * FROM Settings WHERE name=?', [name]);
            if(rs.rows.length != 0) {
                value = rs.rows.item(0).value;
            }
        }
    );

    return value;
}
