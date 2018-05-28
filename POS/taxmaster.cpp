#include "taxmaster.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>
#include <QSqlQueryModel>

TaxMaster::TaxMaster(QObject *parent) : QSqlQueryModel (parent)
{

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
   // QString query =("UPDATE 'TAX' SET SGST = '"+ SGST +"', CGST = '"+ CGST +"' ");
  //  this->setQuery(query);
}
