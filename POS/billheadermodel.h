#ifndef BILLHEADERMODEL_H
#define BILLHEADERMODEL_H

#include <QSqlQueryModel>

class BillHeaderModel : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString groupCode READ groupCode WRITE setGroupCode NOTIFY groupCodeChanged)
    Q_PROPERTY(QString subGroupCode READ subGroupCode WRITE setSubGroupCode NOTIFY subGroupCodeChanged)
    Q_PROPERTY(qint32 billNumber READ billNumber WRITE setBillNumber NOTIFY billNumberChanged)

public:
    BillHeaderModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    void refresh();

    QString getLastExecutedQuery(const QSqlQuery& query);

    QString groupCode();
    void setGroupCode(QString code);

    QString subGroupCode();
    void setSubGroupCode(QString code);

    qint32 billNumber();
    void setBillNumber(qint32 billNumber);

    bool createNewBill();
    qint32 getNextBillNumber();

private slots:
    void onGroupCodeChanged();
    void onSubGroupCodeChanged();

protected:
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

private:
    QString mGroupCode;
    QString mSubGroupCode;
    qint32 mBillNumber;

signals:
    void groupCodeChanged();
    void subGroupCodeChanged();
    void billNumberChanged(qint32 billNumber);
};

#endif // BILLHEADERMODEL_H
