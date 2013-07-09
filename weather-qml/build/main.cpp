#include <QApplication>

#include "mainwindow.h"


int main(int argc, char **argv)
{
    QApplication app(argc, argv);

    MainWindow view;

#if defined(Q_OS_SYMBIAN) || defined(Q_WS_MAEMO_5)
    view.showFullScreen();
#else
    view.show();
#endif

    return app.exec();
}
