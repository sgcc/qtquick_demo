TEMPLATE = app
TARGET = radiotuner

QT += declarative

symbian {
    LIBS += -lesock -lconnmon -lcone -lavkon

    TARGET.UID3 = 0xe3431593
    TARGET.EPOCHEAPSIZE = 0x20000 0x2000000

    DEPLOYMENT.installer_header = 0xA000D7CE
}

SOURCES += main.cpp

RESOURCES += resource.qrc
