#include "taxmaster.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>
#include <QSqlQueryModel>

TaxMaster::TaxMaster(QObject *parent) : QSqlQueryModel (parent)
{
    QString query = ("SELECT Code,Name FROM 'ITEM'");
    this->setQuery(query);
}

QHash<int, QByteArray>TaxMaster::roleNames() const
{
    QHash<int ,QByteArray> roles;
    roles[Qt::UserRole + 1] = "Code";
    roles[Qt::UserRole + 2] = "Name";
    return roles;
}

QVariant TaxMaster::data(const QModelIndex &index, int role) const
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
    return value;
}

bool TaxMaster:: getTax()
{
    QSqlQuery query;
    query.exec("SELECT SGST,CGST FROM 'TAX'");
    query.next();
    setSgst(query.value(0).toString());
    setCgst(query.value(1).toString());
}

bool TaxMaster:: saveTax(int SGST, int CGST)
{
    QSqlQuery query;
    query.prepare("INSERT INTO 'TAX' ('SGST','CGST') VALUES (:SGST,:CGST)");
            query.bindValue(":SGST", SGST);
            query.bindValue(":CGST", CGST);

    if(!query.exec()){
        qDebug() << "error insert into " ;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool TaxMaster:: deleteTax()
{
    QString query = ("DELETE FROM 'TAX' ");
    this->setQuery(query);
}

bool TaxMaster:: editTax(int SGST, int CGST)
{
    qDebug()<< "Edit Invoked";
    QString query =("UPDATE 'TAX' SET SGST = '"+ QString::number(SGST) +"', CGST = '"+ QString::number(CGST) +"' ");
    this->setQuery(query);
}

bool TaxMaster:: getBillNumber()
{
    QSqlQuery query;
    query.exec("SELECT billNumber FROM 'BILLHEADER' WHERE billNumber=(SELECT max(billNumber) FROM 'BILLHEADER')");
    query.next();
    setBillNo(query.value(0).toInt());
}

void TaxMaster:: applyfilter(QString name)
{
    QSqlQuery query;
    query.exec("SELECT name FROM 'ITEM' WHERE name like '%"+name+"%'");
    query.next();
    setNamefilter(query.value(0).toString());
    qDebug()<< m_namefilter;
    return ;
}

QString TaxMaster::namefilter()
{
    return m_namefilter;
}
void TaxMaster::setNamefilter(QString namefilter)
{
    if(namefilter != m_namefilter)
    {
        m_namefilter = namefilter;
        emit namefilterChanged();
    }
}

int TaxMaster:: billNo()
{
    return m_billNo;
}

void TaxMaster:: setBillNo(int billNo)
{
    if(billNo != m_billNo)
    {
        m_billNo = billNo + 1;
        emit billNoChanged();
    }
}

QString TaxMaster:: sgst()
{
    return m_sgst;
}

void TaxMaster:: setSgst(QString sgst)
{
    if(sgst != m_sgst)
    {
        m_sgst = sgst;
        emit sgstChanged();
    }
}

QString TaxMaster:: cgst()
{
    return m_cgst;
}

void TaxMaster:: setCgst(QString cgst)
{
    if(cgst != m_cgst)
    {
        m_cgst = cgst;
        emit cgstChanged();
    }

}
