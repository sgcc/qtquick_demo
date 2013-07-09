#include <QtGui/QApplication>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QDeclarativeView>
#include <QtPlugin>
#include "QtPlugins/svgimage.h"
#include "qmlapplicationviewer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    const char* uri ="SmartHomeEx";
    qmlRegisterType<SvgImage>(uri, 1, 0, "SvgImage");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer.setMainQmlFile(QLatin1String("qml/smarthome/smarthome.qml"));
    viewer.show();

    return app.exec();
}
