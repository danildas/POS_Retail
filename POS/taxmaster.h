#ifndef TAXMASTER_H
#define TAXMASTER_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QDebug>

class TaxMaster : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit TaxMaster(QObject *parent = 0);

public slots:

    Q_INVOKABLE bool saveTax(int SGST, int CGST);
    Q_INVOKABLE bool deleteTax();
    Q_INVOKABLE bool editTax(int SGST, int CGST);
};

#endif // TAXMASTER_H
