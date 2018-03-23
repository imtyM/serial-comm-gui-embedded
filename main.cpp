#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlEngine>
#include <QQmlContext>
#include "serial.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);


    QQuickStyle::setStyle("Material");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject *rootObject = engine.rootObjects().first();

    QScopedPointer<Serial> serial(new Serial(rootObject));
    engine.rootContext()->setContextProperty("Serial", serial.data());

    int returnCode = app.exec();

    return returnCode;
}
