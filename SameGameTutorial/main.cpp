#include <QtGui/QApplication>
#include <QDeclarativeView>
#include <QGraphicsDropShadowEffect>
#include "GemCell.h"
#include "GameBoard.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    qmlRegisterType<GemCell>("com.mycompany.gemcell", 1, 0, "GemCell");
    qmlRegisterType<GameBoard>("com.mycompany.gemcell", 1, 0, "GameBoard");
    qmlRegisterType<QGraphicsDropShadowEffect>("Effects",1,0,"DropShadow");

    QDeclarativeView view;
    view.setSource(QUrl::fromLocalFile("SameGameTutorial_simple.qml"));
    view.show();

//    MainWindow w;
//    w.show();

    return a.exec();
}
