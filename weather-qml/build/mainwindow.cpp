#include "mainwindow.h"

#include <QApplication>
#include <QDeclarativeEngine>

#if defined(Q_OS_SYMBIAN)
#include <QTimer>
#include <eikenv.h>
#include <coemain.h>
#include <aknappui.h>
#endif

MainWindow::MainWindow()
    : QDeclarativeView()
{
#if defined(Q_OS_SYMBIAN)
    QUrl mainqml("qrc:main_s60.qml");
#else
    QUrl mainqml("qrc:main_n900.qml");
#endif
    setSource(mainqml);

    setWindowTitle("Weather QML");

    connect(engine(), SIGNAL(quit()), qApp, SLOT(quit()));

    m_isPortrait = true;

#if defined(Q_OS_SYMBIAN)
    QTimer::singleShot(0, this, SLOT(lockViewMode()));
#elif defined(Q_WS_MAEMO_5)
    setAttribute(Qt::WA_Maemo5PortraitOrientation, true);
#endif
}

#if defined(Q_OS_SYMBIAN)
void MainWindow::lockViewMode()
{
    CAknAppUi *aknAppUi = dynamic_cast<CAknAppUi *>(CEikonEnv::Static()->AppUi());

    if (!aknAppUi)
      return;

    if (m_isPortrait)
        aknAppUi->SetOrientationL(CAknAppUi::EAppUiOrientationPortrait);
    else
        aknAppUi->SetOrientationL(CAknAppUi::EAppUiOrientationLandscape);
}
#endif
