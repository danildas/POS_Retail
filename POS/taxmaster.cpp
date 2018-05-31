#include "taxmaster.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>
#include <QSqlQueryModel>

TaxMaster::TaxMaster(QObject *parent) : QSqlQueryModel (parent)
{

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
