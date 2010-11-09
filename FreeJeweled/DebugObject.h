#ifndef DEBUGOBJECT_H
#define DEBUGOBJECT_H

#include <QTextStream>
#include <QFile>

QTextStream& g_DbgObj()
{
    static QFile* outFile = new QFile("debug.txt");
    Q_CHECK_PTR(outFile);
    outFile->open(QFile::WriteOnly);
    static QTextStream* dbgObject = new QTextStream(outFile);
    return (*dbgObject);
}

#endif // DEBUGOBJECT_H
