/****************************************************************************
** Meta object code from reading C++ file 'lauwebcamerawidget.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../lauwebcamerawidget.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'lauwebcamerawidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_LAUWebCameraWidget_t {
    QByteArrayData data[10];
    char stringdata0[98];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LAUWebCameraWidget_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LAUWebCameraWidget_t qt_meta_stringdata_LAUWebCameraWidget = {
    {
QT_MOC_LITERAL(0, 0, 18), // "LAUWebCameraWidget"
QT_MOC_LITERAL(1, 19, 9), // "emitFrame"
QT_MOC_LITERAL(2, 29, 0), // ""
QT_MOC_LITERAL(3, 30, 15), // "LAUMemoryObject"
QT_MOC_LITERAL(4, 46, 9), // "onCapture"
QT_MOC_LITERAL(5, 56, 16), // "onImageAvailable"
QT_MOC_LITERAL(6, 73, 2), // "id"
QT_MOC_LITERAL(7, 76, 5), // "image"
QT_MOC_LITERAL(8, 82, 8), // "setFrame"
QT_MOC_LITERAL(9, 91, 6) // "object"

    },
    "LAUWebCameraWidget\0emitFrame\0\0"
    "LAUMemoryObject\0onCapture\0onImageAvailable\0"
    "id\0image\0setFrame\0object"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LAUWebCameraWidget[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   34,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    0,   37,    2, 0x0a /* Public */,
       5,    2,   38,    2, 0x0a /* Public */,
       8,    1,   43,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3,    2,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::QImage,    6,    7,
    QMetaType::Void, 0x80000000 | 3,    9,

       0        // eod
};

void LAUWebCameraWidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        LAUWebCameraWidget *_t = static_cast<LAUWebCameraWidget *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->emitFrame((*reinterpret_cast< LAUMemoryObject(*)>(_a[1]))); break;
        case 1: _t->onCapture(); break;
        case 2: _t->onImageAvailable((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QImage(*)>(_a[2]))); break;
        case 3: _t->setFrame((*reinterpret_cast< LAUMemoryObject(*)>(_a[1]))); break;
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
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (LAUWebCameraWidget::*)(LAUMemoryObject );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&LAUWebCameraWidget::emitFrame)) {
                *result = 0;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject LAUWebCameraWidget::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_LAUWebCameraWidget.data,
      qt_meta_data_LAUWebCameraWidget,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *LAUWebCameraWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LAUWebCameraWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_LAUWebCameraWidget.stringdata0))
        return static_cast<void*>(this);
    return QWidget::qt_metacast(_clname);
}

int LAUWebCameraWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
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

// SIGNAL 0
void LAUWebCameraWidget::emitFrame(LAUMemoryObject _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
struct qt_meta_stringdata_LAUWebCameraDialog_t {
    QByteArrayData data[1];
    char stringdata0[19];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LAUWebCameraDialog_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LAUWebCameraDialog_t qt_meta_stringdata_LAUWebCameraDialog = {
    {
QT_MOC_LITERAL(0, 0, 18) // "LAUWebCameraDialog"

    },
    "LAUWebCameraDialog"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LAUWebCameraDialog[] = {

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

void LAUWebCameraDialog::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    Q_UNUSED(_o);
    Q_UNUSED(_id);
    Q_UNUSED(_c);
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject LAUWebCameraDialog::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_LAUWebCameraDialog.data,
      qt_meta_data_LAUWebCameraDialog,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *LAUWebCameraDialog::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LAUWebCameraDialog::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_LAUWebCameraDialog.stringdata0))
        return static_cast<void*>(this);
    return QDialog::qt_metacast(_clname);
}

int LAUWebCameraDialog::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
