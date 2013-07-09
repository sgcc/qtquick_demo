TEMPLATE = app

QT += qml quick
SOURCES += main.cpp
RESOURCES += stocqt.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quick/demos/stocqt
INSTALLS += target

OTHER_FILES += \
    stocqt.qml \
    content/StockView.qml \
    content/StockSettings.qml \
    content/StockModel.qml \
    content/StockListView.qml \
    content/StockListModel.qml \
    content/StockChart.qml \
    content/DatePicker.qml \
    content/CheckBox.qml \
    content/Button.qml
