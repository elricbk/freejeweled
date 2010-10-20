#include <QtGui/QApplication>
#include <QDeclarativeView>
#include "GemCell.h"
#include "GameBoard.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    qmlRegisterType<GemCell>("com.mycompany.gemcell", 1, 0, "GemCell");
    qmlRegisterType<GameBoard>("com.mycompany.gemcell", 1, 0, "GameBoard");

    QDeclarativeView view;
    view.setSource(QUrl::fromLocalFile("MainForm.qml"));
    view.setMinimumSize(320, 480);
    view.setMaximumSize(320, 480);
    view.show();

    return a.exec();
}
