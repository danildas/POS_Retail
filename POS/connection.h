#ifndef CONNECTION_H
#define CONNECTION_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QDebug>

static bool createConnection()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
//    db.setDatabaseName("C:\\Users\\ECS\\Desktop\\POS.db");

    // for mac path ../ is not correct. SQLite will create if no file is found and so
    // there wont be a corresponding table which you try to access.
#ifdef Q_OS_MAC
    db.setDatabaseName("/Users/abinjoseph/Workspace/Qt/Samples/POS/POS.db");
#else
    db.setDatabaseName("F:/Work/ProjectCode/POS.db"); //"E:/WorkSpace/Study/MyWorks/20170106/POS.db");
#endif

    if (!db.open())
    {
        qDebug() << Q_FUNC_INFO << "connection failed";

        return false;
    }

    qDebug() << Q_FUNC_INFO << "connection success";
    return true;
}

#endif // CONNECTION_H
