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
    Q_PROPERTY(QString namefilter READ namefilter WRITE setNamefilter NOTIFY namefilterChanged)
public:
    explicit TaxMaster(QObject *parent = 0);

    QVariant data(const QModelIndex &index, int role) const;

    QString sgst();
    void setSgst(QString sgst);

    QString cgst();
    void setCgst(QString cgst);

    int billNo();
    void setBillNo(int billNo);

    QString namefilter();
    void setNamefilter(QString namefilter);

protected:

    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

signals:

    void sgstChanged();
    void cgstChanged();
    void billNoChanged();
    void namefilterChanged();

public slots:

    Q_INVOKABLE bool saveTax(int SGST, int CGST);
    Q_INVOKABLE bool deleteTax();
    Q_INVOKABLE bool editTax(int SGST, int CGST);
    Q_INVOKABLE bool getTax();
    Q_INVOKABLE bool getBillNumber();
    Q_INVOKABLE void applyfilter(QString name);

private:
    QString m_sgst;
    QString m_cgst;
    int m_billNo;
    QString m_namefilter;
};

#endif // TAXMASTER_H
