/****************************************************************************
**
** This file is part of QtFlyingVan
**
** Copyright (c) 2010 Nokia Corporation and/or its subsidiary(-ies).*
** All rights reserved.
** Contact:  Nokia Corporation (qt-info@nokia.com)
**
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions
** are met:
**
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in the
**     documentation and/or other materials provided with the distribution.
**
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
**  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
**  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
**  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
**  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
**  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
**  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
**  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
**  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
**  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
**  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
**  POSSIBILITY OF SUCH DAMAGE."
**
****************************************************************************/

var BONUS_SCORE = 100;

var ENEMY_TYPE = 1;
var BONUS_TYPE = 2;
var BACKGROUND_ITEM_TYPE = 98;
var BACKGROUND_TILE_TYPE = 99;

var levelSpeed = 3.2;
var leftMargin = 120;
var sprites = new Array();
var components = new Array();
var backgroundItems = new Array();

var db = null;
var phase = 0;
var currentLevel = -1;
var levelFiles = ["levels/1.xml", "levels/2.xml", "levels/3.xml"];

/*
  Load the scene according to the level model. When level model changes
  (see Base.qml), it will call this method to reload the scene elements.
*/
function startGame(doRun)
{
    screen.paused = true;

    var info, object;
    var totalWidth = 0;

    reset();

    // read level description
    for (var i = 0; i < levelModel.count; i++) {
        info = levelModel.get(i);

        if (info.type == BACKGROUND_ITEM_TYPE ||
            info.type == BACKGROUND_TILE_TYPE) {
            // create background element
            object = background.createItem(info.image, info.x, info.y);
            object.speed = info.speed;
            object.vspeed = info.vspeed;
            object.tile = (info.type == BACKGROUND_TILE_TYPE);
            backgroundItems.push(object);
        } else {
            // create sprite element (bonus or enemy)
            object = createObject("sprites/" + info.name + ".qml", foreground);

            if (object != null) {
                object.x = info.x;
                object.y = canvas.height - info.y;
                sprites.push(object);
                totalWidth = Math.max(totalWidth, object.x + object.width);
            }
        }
    }

    screen.paused = false;
    canvas.sceneWidth = totalWidth;

    if (doRun)
        screen.state = "running";
}

/*
  Delete all scene sprites and reset scene parameters.
*/
function reset()
{
    player.reset();

    phase = 0;
    canvas.sceneX = 0;
    canvas.sceneWidth = 0;

    var obj;

    for (var i = 0; i < sprites.length; i++) {
        obj = sprites[i];
        if (obj != null) {
            obj.visible = false;
            obj.image = ""; // workaround to avoid leak
            obj.destroy();
        }
    }

    for (var i = 0; i < backgroundItems.length; i++) {
        obj = backgroundItems[i];
        if (obj != null) {
            obj.visible = false;
            obj.source = ""; // workaround to avoid leak
            obj.destroy();
        }
    }

    sprites.splice(0);
    backgroundItems.splice(0);
}

/*
  Creates an object given its QML file name.
*/
function createObject(name, parent)
{
    var component;

    if (name in components)
        component = components[name];
    else {
        component = Qt.createComponent(name);

        if (component == null || component.status != Component.Ready) {
            console.log("error loading '" + name + "' component");
            console.log(component.errorString());
            return null;
        }

        components[name] = component;
    }

    var object = component.createObject(parent);

    if (object == null) {
        console.log("error creating object for: " + name);
        console.log(component.errorString());
        return null;
    }

    return object;
}

/*
  A timer triggers this method (see Base.qml) using a fixed time interval.
  This method will handle all the game logic like scene movement, sprite
  collisions and game state changes.
*/
function tick()
{
    if (!screen.paused) {
        phase = (phase + 1) % 0xfffffff;

        advanceSprites();
        checkCollisions();
        checkGameEnd();
    }
}

/*
  Change sprites positions and advance their states.
*/
function advanceSprites()
{
    player.advance(phase);

    var fx = canvas.sceneX - levelSpeed;
    var limit = Math.min(0, canvas.width - canvas.sceneWidth);
    var moveSprites = (player.x >= leftMargin && fx > limit);

    if (!moveSprites) {
        player.x += levelSpeed;
    } else {
        canvas.sceneX = fx;
    }

    for (var i = 0; i < sprites.length; i++) {
        var obj = sprites[i]

        if (obj == null)
            continue;

        if (obj.x + obj.width < 0) {
            obj.destroy();
            sprites[i] = null;
        } else {
            obj.x -= obj.velocity;

            if (moveSprites)
                obj.x -= levelSpeed;

            if (obj.x <= canvas.width)
                obj.advance(phase);
        }
    }
}

/*
  Handle all player collisions (this includes enemy and bonus item collisions).
*/
function checkCollisions()
{
    var imune = player.imune;
    var obj, collides, damage = 0;

    // check collision with all scene sprites
    for (var i = 0; i < sprites.length; i++) {
        obj = sprites[i];

        // skip damage if player is imune
        if (obj == null || obj.type == ENEMY_TYPE && imune)
            continue;

        // check for simple bounding rect collision
        collides = (player.y + player.height - player.bottomOffset >= obj.y + obj.topOffset
                    && player.y + player.topOffset <= obj.y + obj.height - obj.bottomOffset
                    && player.x + player.width - player.rightOffset >= obj.x + obj.leftOffset
                    && player.x + player.leftOffset <= obj.x + obj.width - obj.rightOffset);

        if (collides) {
            // player has collided with the sprite
            if (obj.type == ENEMY_TYPE) {
                imune = true;
                damage = obj.damage;
            } else if (obj.type == BONUS_TYPE) {
                screen.score += BONUS_SCORE;
                obj.destroy();
                sprites[i] = null;
            }
        }
    }

    // if player has collided, set imunity and update score
    if (damage > 0) {
        player.imune = true;
        player.life = Math.max(player.life - 1, 0);

        if (damage > 1)
            player.explodeAnyBalloon();

        if (player.life == 0) {
            saveScoreToDisk();
            menu.setState("gameover", false);
            screen.state = "";
        }
    }
}

/*
  Check if the level has ended. If the level has ended, it will show a menu to go
  to the next level or it will show the final score if it's already in the last level.
*/
function checkGameEnd()
{
    // check if player finished the level
    if (player.x > canvas.width && !screen.paused) {
        screen.paused = true;
        saveScoreToDisk();

        // check if it's in the final level
        if (currentLevel < levelFiles.length - 1) {
            menu.setState("nextlevel", false);
            screen.state = "";
        } else {
            finalSplash.display();
        }
    }
}

/*
  Change the current level and reload model data.
*/
function loadLevel(level)
{
    if (level >= 0 && level < levelFiles.length) {
        if (currentLevel == level) {
            Engine.startGame(true);
        } else {
            currentLevel = level;
            levelModel.source = levelFiles[level];
        }
    }
}

/*
  Resume level or go to a new level.
*/
function resumeGame()
{
    if (player.life == 0) {
        restartGame();
        return;
    }

    // if it's playing, just resume
    if (!screen.paused) {
        screen.state = "running";
        return;
    }

    // go to next level or restart
    if (currentLevel < levelFiles.length - 1)
        gotoNextLevel();
    else
        restartGame();
}

// Load the first level
function restartGame()
{
    screen.highScore = Math.max(screen.highScore,
                                screen.score)
    screen.score = 0;
    loadLevel(0);
}

// Load the next level
function gotoNextLevel()
{
    loadLevel(currentLevel + 1);
}

// Load score database
function loadDatabase()
{
    if (db)
        return;

    db = openDatabaseSync("QtFlyingVan", "1.0", "QtFlyingVan", 1000000);

    if (!db)
        return;

    var rs;
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS scores(score INT, date DATETIME)');
        rs = tx.executeSql('SELECT * FROM scores ORDER BY score DESC LIMIT 1');
    });

    if (rs.rows.length > 0) {
        var record = rs.rows.item(0);
        screen.highScore = record.score;
    }
}

// Update score database
function saveScoreToDisk()
{
    if (!db) {
        console.log("Warning: Database is not open");
        return;
    }

    db.transaction(function(tx) {
        tx.executeSql("INSERT INTO scores VALUES(?, date('now'))", [screen.score]);
    });
}
