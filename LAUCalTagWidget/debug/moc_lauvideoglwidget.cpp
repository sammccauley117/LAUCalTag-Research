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
    QByteArrayData data[8];
    char stringdata0[76];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LAUVideoGLWidget_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LAUVideoGLWidget_t qt_meta_stringdata_LAUVideoGLWidget = {
    {
QT_MOC_LITERAL(0, 0, 16), // "LAUVideoGLWidget"
QT_MOC_LITERAL(1, 17, 8), // "onUpdate"
QT_MOC_LITERAL(2, 26, 0), // ""
QT_MOC_LITERAL(3, 27, 8), // "setFrame"
QT_MOC_LITERAL(4, 36, 14), // "unsigned char*"
QT_MOC_LITERAL(5, 51, 6), // "buffer"
QT_MOC_LITERAL(6, 58, 11), // "QVideoFrame"
QT_MOC_LITERAL(7, 70, 5) // "frame"

    },
    "LAUVideoGLWidget\0onUpdate\0\0setFrame\0"
    "unsigned char*\0buffer\0QVideoFrame\0"
    "frame"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LAUVideoGLWidget[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x0a /* Public */,
       3,    1,   35,    2, 0x0a /* Public */,
       3,    1,   38,    2, 0x0a /* Public */,
       3,    1,   41,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 4,    5,
    QMetaType::Void, 0x80000000 | 6,    7,
    QMetaType::Void, QMetaType::QImage,    7,

       0        // eod
};

void LAUVideoGLWidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        LAUVideoGLWidget *_t = static_cast<LAUVideoGLWidget *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->onUpdate(); break;
        case 1: _t->setFrame((*reinterpret_cast< unsigned char*(*)>(_a[1]))); break;
        case 2: _t->setFrame((*reinterpret_cast< const QVideoFrame(*)>(_a[1]))); break;
        case 3: _t->setFrame((*reinterpret_cast< QImage(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 2:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QVideoFrame >(); break;
            }
            break;
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
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
