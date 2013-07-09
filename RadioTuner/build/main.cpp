#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeEngine>

#ifdef Q_OS_SYMBIAN
#include <eikenv.h>
#include <aknappui.h>
#endif


int main(int argc, char **argv)
{
    QApplication app(argc, argv);

#ifdef Q_OS_SYMBIAN
    // lock portrait mode for symbian
    CAknAppUi *akn = dynamic_cast<CAknAppUi*>(CEikonEnv::Static()->AppUi());
    TRAPD(error, if (akn) akn->SetOrientationL(CAknAppUi::EAppUiOrientationLandscape); );
#endif

    QDeclarativeView view;
#ifdef Q_OS_SYMBIAN
    view.setSource(QUrl("qrc:main_s60.qml"));
#else
    view.setSource(QUrl("qrc:main_n900.qml"));
#endif
    QObject::connect(view.engine(), SIGNAL(quit()), qApp, SLOT(quit()));

#if defined(Q_OS_SYMBIAN) || defined(Q_WS_MAEMO_5)
    view.showFullScreen();
#else
    view.show();
#endif

    return app.exec();
}
