/****************************************************************************
** Meta object code from reading C++ file 'lauvideoglwidget.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../lauvideoglwidget.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'lauvideoglwidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_LAUVideoGLWidget_t {
    QByteArrayData data[11];
    char stringdata0[109];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LAUVideoGLWidget_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LAUVideoGLWidget_t qt_meta_stringdata_LAUVideoGLWidget = {
    {
QT_MOC_LITERAL(0, 0, 16), // "LAUVideoGLWidget"
QT_MOC_LITERAL(1, 17, 9), // "emitFrame"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 15), // "LAUMemoryObject"
QT_MOC_LITERAL(4, 44, 8), // "onUpdate"
QT_MOC_LITERAL(5, 53, 8), // "setFrame"
QT_MOC_LITERAL(6, 62, 14), // "unsigned char*"
QT_MOC_LITERAL(7, 77, 6), // "buffer"
QT_MOC_LITERAL(8, 84, 6), // "object"
QT_MOC_LITERAL(9, 91, 11), // "QVideoFrame"
QT_MOC_LITERAL(10, 103, 5) // "frame"

    },
    "LAUVideoGLWidget\0emitFrame\0\0LAUMemoryObject\0"
    "onUpdate\0setFrame\0unsigned char*\0"
    "buffer\0object\0QVideoFrame\0frame"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LAUVideoGLWidget[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   44,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    0,   47,    2, 0x0a /* Public */,
       5,    1,   48,    2, 0x0a /* Public */,
       5,    1,   51,    2, 0x0a /* Public */,
       5,    1,   54,    2, 0x0a /* Public */,
       5,    1,   57,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3,    2,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 6,    7,
    QMetaType::Void, 0x80000000 | 3,    8,
    QMetaType::Void, 0x80000000 | 9,   10,
    QMetaType::Void, QMetaType::QImage,   10,

       0        // eod
};

void LAUVideoGLWidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        LAUVideoGLWidget *_t = static_cast<LAUVideoGLWidget *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->emitFrame((*reinterpret_cast< LAUMemoryObject(*)>(_a[1]))); break;
        case 1: _t->onUpdate(); break;
        case 2: _t->setFrame((*reinterpret_cast< unsigned char*(*)>(_a[1]))); break;
        case 3: _t->setFrame((*reinterpret_cast< LAUMemoryObject(*)>(_a[1]))); break;
        case 4: _t->setFrame((*reinterpret_cast< const QVideoFrame(*)>(_a[1]))); break;
        case 5: _t->setFrame((*reinterpret_cast< QImage(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 0:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< LAUMemoryObject >(); break;
            }
            break;
        case 3:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< LAUMemoryObject >(); break;
            }
            break;
        case 4:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QVideoFrame >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (LAUVideoGLWidget::*)(LAUMemoryObject );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&LAUVideoGLWidget::emitFrame)) {
                *result = 0;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject LAUVideoGLWidget::staticMetaObject = {
    { &QOpenGLWidget::staticMetaObject, qt_meta_stringdata_LAUVideoGLWidget.data,
      qt_meta_data_LAUVideoGLWidget,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *LAUVideoGLWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LAUVideoGLWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_LAUVideoGLWidget.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "QOpenGLFunctions"))
        return static_cast< QOpenGLFunctions*>(this);
    return QOpenGLWidget::qt_metacast(_clname);
}

int LAUVideoGLWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QOpenGLWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void LAUVideoGLWidget::emitFrame(LAUMemoryObject _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
