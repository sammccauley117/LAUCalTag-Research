/****************************************************************************
** Meta object code from reading C++ file 'laucaltagglobject.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../laucaltagglobject.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'laucaltagglobject.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_LAUCalTagFilterWidget_t {
    QByteArrayData data[1];
    char stringdata0[22];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LAUCalTagFilterWidget_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LAUCalTagFilterWidget_t qt_meta_stringdata_LAUCalTagFilterWidget = {
    {
QT_MOC_LITERAL(0, 0, 21) // "LAUCalTagFilterWidget"

    },
    "LAUCalTagFilterWidget"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LAUCalTagFilterWidget[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

       0        // eod
};

void LAUCalTagFilterWidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    Q_UNUSED(_o);
    Q_UNUSED(_id);
    Q_UNUSED(_c);
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject LAUCalTagFilterWidget::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_LAUCalTagFilterWidget.data,
      qt_meta_data_LAUCalTagFilterWidget,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *LAUCalTagFilterWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LAUCalTagFilterWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_LAUCalTagFilterWidget.stringdata0))
        return static_cast<void*>(this);
    return QWidget::qt_metacast(_clname);
}

int LAUCalTagFilterWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    return _id;
}
struct qt_meta_stringdata_LAUCalTagGLObject_t {
    QByteArrayData data[12];
    char stringdata0[172];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LAUCalTagGLObject_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LAUCalTagGLObject_t qt_meta_stringdata_LAUCalTagGLObject = {
    {
QT_MOC_LITERAL(0, 0, 17), // "LAUCalTagGLObject"
QT_MOC_LITERAL(1, 18, 6), // "update"
QT_MOC_LITERAL(2, 25, 0), // ""
QT_MOC_LITERAL(3, 26, 11), // "onSetOffset"
QT_MOC_LITERAL(4, 38, 3), // "val"
QT_MOC_LITERAL(5, 42, 17), // "onSetMedianRadius"
QT_MOC_LITERAL(6, 60, 19), // "onSetGaussianRadius"
QT_MOC_LITERAL(7, 80, 15), // "onSetIterations"
QT_MOC_LITERAL(8, 96, 18), // "onSetMinRegionArea"
QT_MOC_LITERAL(9, 115, 18), // "onSetMaxRegionArea"
QT_MOC_LITERAL(10, 134, 16), // "onSetMinBoxCount"
QT_MOC_LITERAL(11, 151, 20) // "onSetFlipCalTagsFlag"

    },
    "LAUCalTagGLObject\0update\0\0onSetOffset\0"
    "val\0onSetMedianRadius\0onSetGaussianRadius\0"
    "onSetIterations\0onSetMinRegionArea\0"
    "onSetMaxRegionArea\0onSetMinBoxCount\0"
    "onSetFlipCalTagsFlag"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LAUCalTagGLObject[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   59,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       3,    1,   60,    2, 0x0a /* Public */,
       5,    1,   63,    2, 0x0a /* Public */,
       6,    1,   66,    2, 0x0a /* Public */,
       7,    1,   69,    2, 0x0a /* Public */,
       8,    1,   72,    2, 0x0a /* Public */,
       9,    1,   75,    2, 0x0a /* Public */,
      10,    1,   78,    2, 0x0a /* Public */,
      11,    1,   81,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::Double,    4,
    QMetaType::Void, QMetaType::Int,    4,
    QMetaType::Void, QMetaType::Int,    4,
    QMetaType::Void, QMetaType::Int,    4,
    QMetaType::Void, QMetaType::Int,    4,
    QMetaType::Void, QMetaType::Int,    4,
    QMetaType::Void, QMetaType::Int,    4,
    QMetaType::Void, QMetaType::Bool,    4,

       0        // eod
};

void LAUCalTagGLObject::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        LAUCalTagGLObject *_t = static_cast<LAUCalTagGLObject *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->update(); break;
        case 1: _t->onSetOffset((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 2: _t->onSetMedianRadius((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: _t->onSetGaussianRadius((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: _t->onSetIterations((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: _t->onSetMinRegionArea((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: _t->onSetMaxRegionArea((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 7: _t->onSetMinBoxCount((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: _t->onSetFlipCalTagsFlag((*reinterpret_cast< bool(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (LAUCalTagGLObject::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&LAUCalTagGLObject::update)) {
                *result = 0;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject LAUCalTagGLObject::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_LAUCalTagGLObject.data,
      qt_meta_data_LAUCalTagGLObject,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *LAUCalTagGLObject::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LAUCalTagGLObject::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_LAUCalTagGLObject.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "QOpenGLFunctions"))
        return static_cast< QOpenGLFunctions*>(this);
    return QObject::qt_metacast(_clname);
}

int LAUCalTagGLObject::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 9)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 9;
    }
    return _id;
}

// SIGNAL 0
void LAUCalTagGLObject::update()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
