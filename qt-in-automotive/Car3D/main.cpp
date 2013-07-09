#include <QtGui/QApplication>
#include <QDebug>
#include <QDeclarativeView>
#include <QGLWidget>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QDeclarativeView viewer;
    viewer.setViewport(new QGLWidget);
    viewer.setViewportUpdateMode(QGraphicsView::FullViewportUpdate);
    viewer.setSource(QUrl("./Car3DMain.qml"));
    viewer.show();

    return app.exec();
}
