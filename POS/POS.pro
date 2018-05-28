TEMPLATE = app

QT += qml quick sql widgets printsupport
CONFIG += c++11

SOURCES += main.cpp \
    itemviewmodel.cpp \
    groupviewmodel.cpp \
    subgroupviewmodel.cpp \
    billmanager.cpp \
    billheadermodel.cpp \
    itemunitsviewmodel.cpp \
    billitemmodel.cpp \
    billitem.cpp \
    displaymodelmanager.cpp \
    settingsmodel.cpp \
    printmanager.cpp \
    paytypeviewmodel.cpp \
    printermaster.cpp \
    usermaster.cpp \
    rolemaster.cpp \
    taxmaster.cpp

RESOURCES += qml.qrc \
    images.qrc \
    fonts.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    connection.h \
    itemviewmodel.h \
    groupviewmodel.h \
    subgroupviewmodel.h \
    billmanager.h \
    billheadermodel.h \
    itemunitsviewmodel.h \
    billitemmodel.h \
    billitem.h \
    displaymodelmanager.h \
    settingsmodel.h \
    printmanager.h \
    paytypeviewmodel.h \
    printermaster.h \
    usermaster.h \
    rolemaster.h \
    taxmaster.h
