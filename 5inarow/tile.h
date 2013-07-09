#ifndef TILE_H
#define TILE_H

#include <QObject>

class Tile : public QObject
{
    Q_OBJECT

public:
    Tile(QObject *parent = 0) : QObject(parent),
    m_hasButton1(false), m_hasButton2(false), m_highlighted(false) {}

    Q_PROPERTY(bool hasButton1 READ hasButton1 WRITE setHasButton1 NOTIFY hasButton1Changed);
    bool hasButton1() const { return m_hasButton1; }

    Q_PROPERTY(bool hasButton2 READ hasButton2 WRITE setHasButton2 NOTIFY hasButton2Changed);
    bool hasButton2() const { return m_hasButton2; }

    Q_PROPERTY(bool highlighted READ highlighted WRITE setHighlighted NOTIFY highlightedChanged);
    bool highlighted() const { return m_highlighted; }

    void setHasButton1(bool state) { if(state==m_hasButton1) return; m_hasButton1 = state; emit hasButton1Changed(); }
    void setHasButton2(bool state) { if(state==m_hasButton2) return; m_hasButton2 = state; emit hasButton2Changed(); }
    void setHighlighted(bool state) { if(state==m_highlighted) return; m_highlighted = state; emit highlightedChanged(); }

signals:
    void hasButton1Changed();
    void hasButton2Changed();
    void highlightedChanged();

private:
    bool m_hasButton1;
    bool m_hasButton2;
    bool m_highlighted;

};

#endif // TILE_H
