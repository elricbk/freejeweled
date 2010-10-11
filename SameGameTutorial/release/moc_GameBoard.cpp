/****************************************************************************
** Meta object code from reading C++ file 'GameBoard.h'
**
** Created: Thu 30. Sep 16:06:27 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../GameBoard.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'GameBoard.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_GameBoard[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       2,   74, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      11,   10,   10,   10, 0x05,
      26,   10,   10,   10, 0x05,

 // slots: signature, parameters, type, tag, flags
      41,   10,   10,   10, 0x08,

 // methods: signature, parameters, type, tag, flags
      61,   10,   10,   10, 0x02,
      79,   10,   74,   10, 0x02,
      92,   10,   10,   10, 0x02,
     107,   10,   10,   10, 0x02,
     121,   10,   10,   10, 0x02,
     133,   10,   10,   10, 0x02,
     155,  145,   10,   10, 0x02,
     182,  178,   10,   10, 0x02,
     203,   10,   10,   10, 0x02,

 // properties: name, type, flags
     230,  226, 0x02495103,
     236,  226, 0x02495103,

 // properties: notify_signal_id
       0,
       1,

       0        // eod
};

static const char qt_meta_stringdata_GameBoard[] = {
    "GameBoard\0\0levelChanged()\0scoreChanged()\0"
    "checkGemPositions()\0resetBoard()\0bool\0"
    "markCombos()\0removeCombos()\0shuffleDown()\0"
    "fillBoard()\0removeAll()\0boardData\0"
    "loadTestBoard(QString)\0x,y\0"
    "handleClick(int,int)\0dbgPrintGemPositions()\0"
    "int\0level\0score\0"
};

const QMetaObject GameBoard::staticMetaObject = {
    { &QDeclarativeItem::staticMetaObject, qt_meta_stringdata_GameBoard,
      qt_meta_data_GameBoard, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &GameBoard::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *GameBoard::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *GameBoard::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_GameBoard))
        return static_cast<void*>(const_cast< GameBoard*>(this));
    return QDeclarativeItem::qt_metacast(_clname);
}

int GameBoard::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDeclarativeItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: levelChanged(); break;
        case 1: scoreChanged(); break;
        case 2: checkGemPositions(); break;
        case 3: resetBoard(); break;
        case 4: { bool _r = markCombos();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 5: removeCombos(); break;
        case 6: shuffleDown(); break;
        case 7: fillBoard(); break;
        case 8: removeAll(); break;
        case 9: loadTestBoard((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 10: handleClick((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 11: dbgPrintGemPositions(); break;
        default: ;
        }
        _id -= 12;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = level(); break;
        case 1: *reinterpret_cast< int*>(_v) = score(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setLevel(*reinterpret_cast< int*>(_v)); break;
        case 1: setScore(*reinterpret_cast< int*>(_v)); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void GameBoard::levelChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void GameBoard::scoreChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
QT_END_MOC_NAMESPACE
