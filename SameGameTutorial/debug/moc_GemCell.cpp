/****************************************************************************
** Meta object code from reading C++ file 'GemCell.h'
**
** Created: Sun 3. Oct 03:21:41 2010
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../GemCell.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'GemCell.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_GemCell[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       6,   44, // properties
       1,   68, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
       9,    8,    8,    8, 0x05,
      34,    8,    8,    8, 0x05,
      53,    8,    8,    8, 0x05,
      78,    8,    8,    8, 0x05,
     100,    8,    8,    8, 0x05,

 // methods: signature, parameters, type, tag, flags
     118,    8,    8,    8, 0x02,

 // properties: name, type, flags
     147,  142, 0x01495103,
     163,  142, 0x01495103,
     173,  142, 0x01495103,
     189,  142, 0x01495103,
     202,  142, 0x01095103,
     222,  213, 0x0049510b,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       0,
       4,

 // enums: name, flags, count, data
     213, 0x0,    4,   72,

 // enum data: key, value
     231, uint(GemCell::Normal),
     238, uint(GemCell::Explosive),
     248, uint(GemCell::HyperCube),
     258, uint(GemCell::RowColumnRemove),

       0        // eod
};

static const char qt_meta_stringdata_GemCell[] = {
    "GemCell\0\0behaviorEnabledChanged()\0"
    "timeToDieChanged()\0shouldBeRemovedChanged()\0"
    "explodedOnceChanged()\0modifierChanged()\0"
    "playAnimationEndSound()\0bool\0"
    "behaviorEnabled\0timeToDie\0shouldBeRemoved\0"
    "explodedOnce\0invincible\0Modifier\0"
    "modifier\0Normal\0Explosive\0HyperCube\0"
    "RowColumnRemove\0"
};

const QMetaObject GemCell::staticMetaObject = {
    { &QDeclarativeItem::staticMetaObject, qt_meta_stringdata_GemCell,
      qt_meta_data_GemCell, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &GemCell::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *GemCell::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *GemCell::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_GemCell))
        return static_cast<void*>(const_cast< GemCell*>(this));
    return QDeclarativeItem::qt_metacast(_clname);
}

int GemCell::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDeclarativeItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: behaviorEnabledChanged(); break;
        case 1: timeToDieChanged(); break;
        case 2: shouldBeRemovedChanged(); break;
        case 3: explodedOnceChanged(); break;
        case 4: modifierChanged(); break;
        case 5: playAnimationEndSound(); break;
        default: ;
        }
        _id -= 6;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = behaviorEnabled(); break;
        case 1: *reinterpret_cast< bool*>(_v) = timeToDie(); break;
        case 2: *reinterpret_cast< bool*>(_v) = shouldBeRemoved(); break;
        case 3: *reinterpret_cast< bool*>(_v) = explodedOnce(); break;
        case 4: *reinterpret_cast< bool*>(_v) = invincible(); break;
        case 5: *reinterpret_cast< Modifier*>(_v) = modifier(); break;
        }
        _id -= 6;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setBehaviorEnabled(*reinterpret_cast< bool*>(_v)); break;
        case 1: setTimeToDie(*reinterpret_cast< bool*>(_v)); break;
        case 2: setShouldBeRemoved(*reinterpret_cast< bool*>(_v)); break;
        case 3: setExplodedOnce(*reinterpret_cast< bool*>(_v)); break;
        case 4: setInvincible(*reinterpret_cast< bool*>(_v)); break;
        case 5: setModifier(*reinterpret_cast< Modifier*>(_v)); break;
        }
        _id -= 6;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 6;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void GemCell::behaviorEnabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void GemCell::timeToDieChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void GemCell::shouldBeRemovedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void GemCell::explodedOnceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void GemCell::modifierChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}
QT_END_MOC_NAMESPACE
