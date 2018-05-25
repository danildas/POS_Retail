#include "usermaster.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlRecord>
#include <QBuffer>
#include <QScreen>
#include <QApplication>
#include <QImage>
#include <QFile>
#include <QPixmap>
#include <QLabel>

UserMaster::UserMaster(QObject *parent): QSqlQueryModel (parent)
{
    this->refresh();
}

QHash<int, QByteArray> UserMaster::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "UserCode";
    roles[Qt::UserRole + 2] = "UserName";
    roles[Qt::UserRole + 3] = "Role";
    return roles;
}

QVariant UserMaster::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
       qDebug()<< value;
    return value;
}

void UserMaster::refresh()
{
    qDebug() << "refresh invoked" ;
    QString query = "SELECT UserCode,UserName,Role FROM 'USER_ACCOUNT'";
    this->setQuery(query);

    QSqlQuery query1;
    query1.exec("SELECT COUNT(*) FROM 'USER_ACCOUNT'");
    query1.next();
    setTotalCount(query1.value(0).toInt());
    qDebug() <<"total row count"<< m_totalCount;
}

bool UserMaster::saveUser(QString UserName,QString Role,QString Password)
{
    qDebug() << "saveUser "<< UserName<<Role<<Password;
    userRowValue=m_totalCount;
    QSqlQuery query;
    query.prepare("INSERT INTO 'USER_ACCOUNT' (UserName,Role,Password,RoleCode) VALUES (:UserName,:Role,:Password,(SELECT Code FROM 'ROLE_MASTER' WHERE Role='"+Role+"'))");
            query.bindValue(":UserName", UserName);
            query.bindValue(":Role", Role);
            query.bindValue(":Password",Password);

    if(!query.exec()){
        qDebug() << "error insert into " ;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool UserMaster::deleteUser()
{
    //userRowValue=0;
    qDebug()<<"code"<<m_UserCode;
    setTotalCount(m_totalCount-1);
    QString query = ("DELETE FROM 'USER_ACCOUNT' WHERE UserCode='" + m_UserCode + "' ");
    this->setQuery(query);
}

bool UserMaster::editUser(QString UserName,QString Role,QString Password)
{
    //userRowValue=0;
    if(Password!="")
    {
    qDebug()<< "Edit Invoked";
    QString query1 =("UPDATE 'USER_ACCOUNT' SET UserName='"+UserName +"',Role='"+Role +"',Password='"+Password +"',RoleCode=(SELECT Code FROM 'ROLE_MASTER' WHERE Role='"+Role+"')  WHERE UserCode='" + m_UserCode + "'");
    this->setQuery(query1);
    }
    else
    {
       qDebug()<< "Password empty";
    }
}

bool UserMaster::next()
{
    if(m_totalCount!=userRowValue)
    {
    userRowValue++;
    setUserCode(record(userRowValue).value("UserCode").toString());
    setUserName(record(userRowValue).value("UserName").toString());
    setRole(record(userRowValue).value("Role").toString());

    m_roleValueCount= userRowValue;
    qDebug()<< "values"<<m_roleValueCount;
    qDebug()<< "total count"<<m_totalCount;
               qDebug()<< "userRowValue"<<userRowValue;
    }
}

bool UserMaster::previous()
{
    if(userRowValue>=1)
    {
    userRowValue--;
    setUserCode(record(userRowValue).value("UserCode").toString());
    setUserName(record(userRowValue).value("UserName").toString());
    setRole(record(userRowValue).value("Role").toString());
    }
}

QString UserMaster:: UserCode()
{
    return m_UserCode;
}
void UserMaster::setUserCode(QString UserCode)
{
    if(UserCode != m_UserCode)
    {
        m_UserCode = UserCode;
        emit UserCodeChanged();
    }
}

QString UserMaster:: UserName()
{
    return m_UserName;
}
void UserMaster::setUserName(QString UserName)
{
    if(UserName != m_UserName)
    {
        m_UserName =UserName;
        emit UserNameChanged();
    }
}

QString UserMaster::Role()
{
    return m_Role;
}
void UserMaster::setRole(QString Role)
{
    if(Role != m_Role)
    {
        m_Role = Role;
        emit RoleChanged();
    }
}

int UserMaster::TotalCount()
{
    return m_totalCount;
}
void UserMaster::setTotalCount(int TotalCount)
{
    if(TotalCount !=m_totalCount)
    {
        m_totalCount=TotalCount-1;
        emit TotalCountChanged();
    }
}
int UserMaster::roleValueCount()
{
    return m_roleValueCount;
}
int UserMaster::setRoleValueCount(int roleValueCount)
{
    if(roleValueCount != m_roleValueCount)
    {
        m_roleValueCount=roleValueCount;
        emit roleValueCountChanged();
    }

}
