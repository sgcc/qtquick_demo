#include <QDeclarativeItem>
#include <QGLWidget>
#include <QGLFormat>
#include <QUrl>
#include <QTimer>
#include <QApplication>
#include <QDeclarativeEngine>

#if defined(Q_WS_MAEMO_5)
// This is needed for Maemo5 to recognize minimization of the application window
#include <QtDBus>
#endif

#include "mainwidget.h"
#include "tile.h"

QString filename(contentPath + "MainView.qml");

MainWidget::MainWidget(QWidget *parent)
    : QDeclarativeView(parent)
{
    // Switch to fullscreen in device
#if defined(Q_OS_SYMBIAN) || defined(Q_WS_MAEMO_5)
    setWindowState(Qt::WindowFullScreen);
#endif

    setResizeMode(QDeclarativeView::SizeRootObjectToView);

    // Register Tile to be available in QML
    qmlRegisterType<Tile>("gameCore", 1, 0, "Tile");

    // Setup context
    m_context = rootContext();
    m_context->setContextProperty("mainWidget", this);
    m_context->setContextProperty("gameData", &m_gameData);

    // Set view optimizations not already done for QDeclarativeView
    setAttribute(Qt::WA_OpaquePaintEvent);
    setAttribute(Qt::WA_NoSystemBackground);

    // Make QDeclarativeView use OpenGL backend
    QGLWidget *glWidget = new QGLWidget(this);
    setViewport(glWidget);
    setViewportUpdateMode(QGraphicsView::FullViewportUpdate);

    // Open root QML file
    setSource(QUrl(filename));
}

MainWidget::~MainWidget()
{
}

void MainWidget::minimizeWindow()
{
#if defined(Q_WS_MAEMO_5)
    // This is needed for Maemo5 to recognize minimization
    QDBusConnection connection = QDBusConnection::sessionBus();
    QDBusMessage message = QDBusMessage::createSignal("/","com.nokia.hildon_desktop","exit_app_view");
    connection.send(message);
#else
    setWindowState(Qt::WindowMinimized);
#endif
}

void MainWidget::exitApplication()
{
    QApplication::quit();
}
