#ifndef BILLITEMMODEL_H
#define BILLITEMMODEL_H

#include <QObject>
#include <QAbstractListModel>

#include "billitem.h"

class BillItemModel : public QAbstractListModel
{
    Q_OBJECT
    Q_ENUMS(ROLENAME)
public:
    explicit BillItemModel(QObject *parent = 0);

    enum ROLENAME {ITEMCODEROLE = Qt::UserRole + 1,
                   UNITCODEROLE,
                   ITEMNAMEROLE,
                   COUNTROLE,
                   PRICEROLE,
                   TOTALROLE,
                   ISPARENTROLE,
                   LINENUMBERROLE,
                   PARENTLINENUMBERROLE};

    int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;

    void addItem(const BillItem &billItem);
    bool addItem(QString itemCode, QString itemUnitCode, qint32 count, qint32 &total, QString &errorMessage);
    bool clear(QString &errorMessage);

    QVariantMap saveBillItems(qint32 billNumber);

signals:

public slots:

private:
    QList<BillItem*> mBillItems;

    bool fillItemDetails(BillItem *item, QString &errorMessage);
};

#endif // BILLITEMMODEL_H
