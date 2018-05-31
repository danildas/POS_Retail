#ifndef TAXMASTER_H
#define TAXMASTER_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QDebug>

class TaxMaster : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString sgst READ sgst WRITE setSgst NOTIFY sgstChanged)
    Q_PROPERTY(QString cgst READ cgst WRITE setCgst NOTIFY cgstChanged)
    Q_PROPERTY(int billNo READ billNo WRITE setBillNo NOTIFY billNoChanged)
public:
    explicit TaxMaster(QObject *parent = 0);

    QString sgst();
    void setSgst(QString sgst);

    QString cgst();
    void setCgst(QString cgst);

    int billNo();
    void setBillNo(int billNo);

signals:

    void sgstChanged();
    void cgstChanged();
    void billNoChanged();

public slots:

    Q_INVOKABLE bool saveTax(int SGST, int CGST);
    Q_INVOKABLE bool deleteTax();
    Q_INVOKABLE bool editTax(int SGST, int CGST);
    Q_INVOKABLE bool getTax();
    Q_INVOKABLE bool getBillNumber();

private:
    QString m_sgst;
    QString m_cgst;
    int m_billNo;
};

#endif // TAXMASTER_H
