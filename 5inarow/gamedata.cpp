#include "gamedata.h"

const int TILE_ROWS = 19;
const int TILE_COLS = 19;

GameData::GameData(QObject *parent)
    : QObject(parent)
    , m_gameOn(false)
    , m_player1Turn(true)
    , m_moves(0)
    , m_gameTimeSeconds(0)
    , m_gameTime(0,0)
    , m_time("0:00")
{
    // Create tiles
    for(int i = 0; i < TILE_ROWS * TILE_COLS; ++i) {
        m_tiles << new Tile;
    }

    // Timer to update the game time
    m_gameTimer = new QTimer(this);
    connect(m_gameTimer, SIGNAL(timeout()), this, SLOT(updateTime()));
    m_gameTimer->setInterval(1000);
}

GameData::~GameData()
{
}

void GameData::resetGame()
{
    setMoves(0);
    foreach(Tile *t, m_tiles) {
        t->setHasButton1(false);
        t->setHasButton2(false);
        t->setHighlighted(false);
    }
    m_selectedTiles.clear();
    m_gameTimeSeconds = 0;
    setGameTime("0:00");
    setPlayer1Turn(true);
    setGameOn(true);
}

void GameData::pauseGame(bool state)
{
    if (state)
        m_gameTimer->stop();
    else
        m_gameTimer->start();
}



void GameData::flip(int index)
{
    if (!m_gameOn)
        return;

    Tile *t = tile(index);
    if (!t || t->hasButton1() || t->hasButton2())
        return;

    setMoves(m_moves + 1);

    if (player1Turn()) {
        t->setHasButton1(true);
    } else {
        t->setHasButton2(true);
    }

    // Check for winning
    QList<Tile *> winningTiles;
    if (checkWin(index, 1, 0, winningTiles) || checkWin(index, 0, 1, winningTiles) ||
        checkWin(index, 1, 1, winningTiles) || checkWin(index, 1, -1, winningTiles)) {
        // Player whose turn it was won

        // Highlight the winning tiles
        m_selectedTiles.last()->setHighlighted(false);
        for(int i=0 ; i<winningTiles.count() ; ++i) {
            winningTiles.at(i)->setHighlighted(true);
        }

        setGameOn(false);
        return;
    }

    // Set only last tile highlighted
    if (!m_selectedTiles.empty()) m_selectedTiles.last()->setHighlighted(false);
    t->setHighlighted(true);

    // Add tile into selected list, for undo
    m_selectedTiles << t;

    setPlayer1Turn(!player1Turn());
}

void GameData::undoTile()
{
    if (!m_selectedTiles.empty())
    {
        // Clear button and unset highlight
        m_selectedTiles.last()->setHasButton1(false);
        m_selectedTiles.last()->setHasButton2(false);
        m_selectedTiles.last()->setHighlighted(false);
        m_selectedTiles.pop();

        // Set new last tile highlighted
        if (!m_selectedTiles.empty()) m_selectedTiles.last()->setHighlighted(true);

        setMoves(m_moves-1);
        setPlayer1Turn(!player1Turn());
    }
}

void GameData::updateTime()
{
    if (m_gameOn) m_gameTimeSeconds++;
    setGameTime(m_gameTime.addSecs(m_gameTimeSeconds).toString("m:ss"));
}

bool GameData::checkWin(int index, int dx, int dy, QList<Tile*> &winningTiles)
{
    int count = 0;
    for (int i=-4; i<5; ++i) {
        Tile *t = tile(index + TILE_COLS*i*dx + i*dy);
        if (t && ((player1Turn()&&t->hasButton1()) || (!player1Turn()&&t->hasButton2()))) {
            count++;
            winningTiles.append(t);
        } else {
            count = 0;
            winningTiles.clear();
        }
        if (count==5) return true;
    }
    return false;
}
