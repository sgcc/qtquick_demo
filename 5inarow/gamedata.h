#ifndef GAMEDATA_H
#define GAMEDATA_H

#include <QObject>
#include <QString>
#include <QList>
#include <QStack>
#include <QTime>
#include <QTimer>
#include <QDeclarativeListProperty>
#include "tile.h"

class GameData : public QObject
{
    Q_OBJECT

public:
    GameData(QObject *parent=0);
    ~GameData();

    Q_PROPERTY(int moves READ moves WRITE setMoves NOTIFY movesChanged);
    int moves() const {return m_moves;}
    void setMoves(int moves) {if(moves==m_moves) return; m_moves = moves; emit movesChanged();}

    Q_PROPERTY(QString gameTime READ gameTime WRITE setGameTime NOTIFY gameTimeChanged);
    QString gameTime() const {return m_time;}
    void setGameTime(const QString &time) {if(time==m_time) return; m_time = time; emit gameTimeChanged();}

    Q_PROPERTY(bool player1Turn READ player1Turn WRITE setPlayer1Turn NOTIFY player1TurnChanged);
    bool player1Turn() const {return m_player1Turn;}
    void setPlayer1Turn(bool state) {if(state==m_player1Turn) return; m_player1Turn = state; emit player1TurnChanged();}

    Q_PROPERTY(bool gameOn READ gameOn WRITE setGameOn NOTIFY gameOnChanged);
    bool gameOn() const {return m_gameOn;}
    void setGameOn(bool on) {if(on==m_gameOn) return; m_gameOn = on; emit gameOnChanged();}

    Q_PROPERTY(QDeclarativeListProperty<Tile> tiles READ tiles CONSTANT);
    QDeclarativeListProperty<Tile> tiles() {return QDeclarativeListProperty<Tile>(this, m_tiles);}

public slots:
    void resetGame();
    void pauseGame(bool state);
    void flip(int index);
    void undoTile();
    void updateTime();

signals:
    void movesChanged();
    void gameTimeChanged();
    void player1TurnChanged();
    void gameOnChanged();

private:
    Tile *tile(int index) const {return (index >= 0 && index < m_tiles.count()) ? m_tiles.at(index) : 0;}
    bool checkWin(int index, int dx, int dy, QList<Tile *> &winningTiles);

    QList<Tile *> m_tiles;
    QStack<Tile *> m_selectedTiles;
    bool m_gameOn;
    bool m_player1Turn;
    int m_moves;
    int m_gameTimeSeconds;
    QTime m_gameTime;
    QTimer *m_gameTimer;
    QString m_time;
};

#endif // GAMEDATA_H
