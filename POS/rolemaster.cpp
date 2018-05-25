#include "rolemaster.h"
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

RoleMaster::RoleMaster(QObject *parent): QSqlQueryModel (parent)
{
 this->refresh();
}

QHash<int, QByteArray> RoleMaster::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "Code";
    roles[Qt::UserRole + 2] = "Role";
    roles[Qt::UserRole + 3] = "Sales";
    roles[Qt::UserRole + 4] = "Payments";
    roles[Qt::UserRole + 5] = "Settings";
    roles[Qt::UserRole + 6] = "Reports";
    return roles;
}

QVariant RoleMaster::data(const QModelIndex &index, int role) const
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

void RoleMaster::refresh()
{
    qDebug() << "refresh invoked" ;
    QString query = "SELECT Code,Role,Sales,Payments,Settings,Reports FROM 'ROLE_MASTER'";
    this->setQuery(query);

    QSqlQuery query1;
    query1.exec("SELECT COUNT(*) FROM 'ROLE_MASTER'");
    query1.next();
    setTotalCount(query1.value(0).toInt());
    qDebug() <<"total row count"<< m_totalCount;
}

bool RoleMaster::getRole()
{
    setRole(record(roleRowValue).value("Role").toString());
}

bool RoleMaster::saveRole(QString Role, int Sales, int Payment, int Settings, int Reports)
{
    qDebug() << "saveRole "<<Role<<Sales<<Payment<<Settings<<Reports;
    roleRowValue=m_totalCount;
    QSqlQuery query;
    query.prepare("INSERT INTO 'ROLE_MASTER' (Role,Sales,Payments,Settings,Reports) VALUES (:Role,:Sales,:Payment,:Settings,:Reports)");
            query.bindValue(":Role", Role);
            query.bindValue(":Sales", Sales);
            query.bindValue(":Payment",Payment);
            query.bindValue(":Settings",Settings);
            query.bindValue(":Reports",Reports);

    if(!query.exec()){
        qDebug() << "error insert into " ;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool RoleMaster::next()
{
    if(m_totalCount!=roleRowValue)
    {
     roleRowValue++;
     setCode(record(roleRowValue).value("Code").toString());
     setRole(record(roleRowValue).value("Role").toString());
     setSales(record(roleRowValue).value("Sales").toInt());
     setPayments(record(roleRowValue).value("Payments").toInt());
     setSettings(record(roleRowValue).value("Settings").toInt());
     setReport(record(roleRowValue).value("Reports").toInt());
    }
}

bool RoleMaster::previous()
{
    if(roleRowValue>=1)
    {
    roleRowValue--;
    setCode(record(roleRowValue).value("Code").toString());
    setRole(record(roleRowValue).value("Role").toString());
    setSales(record(roleRowValue).value("Sales").toInt());
    setPayments(record(roleRowValue).value("Payments").toInt());
    setSettings(record(roleRowValue).value("Settings").toInt());
    setReport(record(roleRowValue).value("Reports").toInt());
    }
}

bool RoleMaster::edit(QString Role, int Sales, int Payment, int Settings, int Reports)
{
    qDebug()<<"code"<<m_Code<<Role <<Sales <<Payment <<Settings <<Reports;

    QSqlQuery query;
    query.prepare(" UPDATE 'ROLE_MASTER' SET Role=:Role, Sales=:Sales, Payments=:Payment, Settings=:Settings,Reports=:Reports WHERE Code='"+ m_Code +"' ");
    query.bindValue(":Role", Role);
    query.bindValue(":Sales", Sales);
    query.bindValue(":Payment",Payment);
    query.bindValue(":Settings",Settings);
    query.bindValue(":Reports",Reports);

    if(!query.exec()){
        qDebug() << "error upadte " ;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool RoleMaster::editUserRole(QString newRole)
{
    qDebug()<< "Edit Invoked"<<"role"<<newRole;
    qDebug()<< "code"<<m_Code;
    QString query =("UPDATE 'USER_ACCOUNT' SET Role='"+ newRole +"'  WHERE RoleCode='" + m_Code + "' ");
    this->setQuery(query);
}

bool RoleMaster::deleteRole()
{
    qDebug()<<"code"<<m_Code;
    setTotalCount(m_totalCount-1);
    QString query = ("DELETE FROM 'ROLE_MASTER' WHERE Code='" + m_Code + "' ");
    this->setQuery(query);
}

QString RoleMaster:: Code()
{
    return m_Code;
}
void RoleMaster::setCode(QString Code)
{
    if(Code != m_Code)
    {
        m_Code =Code;
        emit CodeChanged();
    }
}

QString RoleMaster:: Role()
{
    return m_Role;
}
void RoleMaster:: setRole(QString Role)
{
    if(Role != m_Role)
    {
        m_Role = Role;
        emit RoleChanged();
    }
}

int RoleMaster::sales()
{
    return m_sales;
}
int RoleMaster::setSales(int sales)
{
    if(sales != m_sales)
    {
        m_sales = sales;
        emit salesChanged();
    }
}

int RoleMaster::payments()
{
    return m_payments;
}
int RoleMaster::setPayments(int payments)
{
    if(payments != m_payments)
    {
        m_payments = payments;
        emit paymentsChanged();
    }
}

int RoleMaster::settings()
{
    return m_settings;
}
int RoleMaster::setSettings(int settings)
{
    if(settings != m_settings)
    {
        m_settings = settings;
        emit settingsChanged();
    }
}

int RoleMaster::report()
{
    return m_report;
}
int RoleMaster::setReport(int report)
{
    if(report != m_report)
    {
        m_report = report;
        emit reportChanged();
    }
}

int RoleMaster::TotalCount()
{
    return m_totalCount;
}
int RoleMaster::setTotalCount(int TotalCount)
{
    if(TotalCount !=m_totalCount)
    {
        m_totalCount=TotalCount-1;
        emit TotalCountChanged();
    }
}
