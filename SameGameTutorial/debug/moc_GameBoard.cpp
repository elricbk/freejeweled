/****************************************************************************
** Meta object code from reading C++ file 'GameBoard.h'
**
** Created: Sun 3. Oct 17:13:54 2010
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
      16,   14, // methods
       5,   94, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
      11,   10,   10,   10, 0x05,
      26,   10,   10,   10, 0x05,
      41,   10,   10,   10, 0x05,
      60,   10,   10,   10, 0x05,
      82,   10,   10,   10, 0x05,

 // slots: signature, parameters, type, tag, flags
     103,   10,   10,   10, 0x08,

 // methods: signature, parameters, type, tag, flags
     123,   10,   10,   10, 0x02,
     141,   10,  136,   10, 0x02,
     154,   10,   10,   10, 0x02,
     169,   10,   10,   10, 0x02,
     183,   10,   10,   10, 0x02,
     195,   10,   10,   10, 0x02,
     217,  207,   10,   10, 0x02,
     240,   10,   10,   10, 0x02,
     260,  256,   10,   10, 0x02,
     281,   10,   10,   10, 0x02,

 // properties: name, type, flags
     308,  304, 0x02495103,
     314,  304, 0x02495103,
     320,  304, 0x02495103,
     330,  304, 0x02495103,
     343,  136, 0x01495103,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,

       0        // eod
};

static const char qt_meta_stringdata_GameBoard[] = {
    "GameBoard\0\0levelChanged()\0scoreChanged()\0"
    "selGemRowChanged()\0selGemColumnChanged()\0"
    "gemSelectedChanged()\0checkGemPositions()\0"
    "resetBoard()\0bool\0markCombos()\0"
    "removeCombos()\0shuffleDown()\0fillBoard()\0"
    "removeAll()\0boardData\0loadTestBoard(QString)\0"
    "loadTestBoard()\0x,y\0handleClick(int,int)\0"
    "dbgPrintGemPositions()\0int\0level\0score\0"
    "selGemRow\0selGemColumn\0gemSelected\0"
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
        case 2: selGemRowChanged(); break;
        case 3: selGemColumnChanged(); break;
        case 4: gemSelectedChanged(); break;
        case 5: checkGemPositions(); break;
        case 6: resetBoard(); break;
        case 7: { bool _r = markCombos();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 8: removeCombos(); break;
        case 9: shuffleDown(); break;
        case 10: fillBoard(); break;
        case 11: removeAll(); break;
        case 12: loadTestBoard((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 13: loadTestBoard(); break;
        case 14: handleClick((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 15: dbgPrintGemPositions(); break;
        default: ;
        }
        _id -= 16;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = level(); break;
        case 1: *reinterpret_cast< int*>(_v) = score(); break;
        case 2: *reinterpret_cast< int*>(_v) = selGemRow(); break;
        case 3: *reinterpret_cast< int*>(_v) = selGemColumn(); break;
        case 4: *reinterpret_cast< bool*>(_v) = gemSelected(); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setLevel(*reinterpret_cast< int*>(_v)); break;
        case 1: setScore(*reinterpret_cast< int*>(_v)); break;
        case 2: setSelGemRow(*reinterpret_cast< int*>(_v)); break;
        case 3: setSelGemColumn(*reinterpret_cast< int*>(_v)); break;
        case 4: setGemSelected(*reinterpret_cast< bool*>(_v)); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
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

// SIGNAL 2
void GameBoard::selGemRowChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void GameBoard::selGemColumnChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void GameBoard::gemSelectedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}
QT_END_MOC_NAMESPACE
