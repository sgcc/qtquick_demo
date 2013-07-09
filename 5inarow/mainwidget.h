#ifndef MAINWIDGET_H
#define MAINWIDGET_H

#include <QWidget>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include "gamedata.h"

#if defined(Q_OS_SYMBIAN) || defined(Q_WS_MAEMO_5)
const QString contentPath = "/opt/five-in-a-row/content/";
#else
const QString contentPath = "content/";
#endif

class MainWidget : public QDeclarativeView
{
    Q_OBJECT

public:
    MainWidget(QWidget *parent=0);
    ~MainWidget();

public slots:
    void minimizeWindow();
    void exitApplication();

private:
    QDeclarativeContext *m_context;
    GameData m_gameData;
};

#endif // MAINWIDGET_H
