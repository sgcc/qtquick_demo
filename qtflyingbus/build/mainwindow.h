#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QDeclarativeView>

class MainWindow : public QDeclarativeView
{
    Q_OBJECT

public:
    MainWindow();

protected slots:
#ifdef Q_OS_SYMBIAN
    void lockViewMode();
#endif

private:
    bool m_isPortrait;
};

#endif
