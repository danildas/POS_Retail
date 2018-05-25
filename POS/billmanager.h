#ifndef BILLMANAGER_H
#define BILLMANAGER_H

#include "billheadermodel.h"
#include "billitemmodel.h"

class BillManager : public QObject
{
    Q_OBJECT
    Q_ENUMS(STATE)

    Q_PROPERTY(STATE state READ state WRITE setState NOTIFY stateChanged)
    Q_PROPERTY(qint32 billNumber READ billNumber WRITE setBillNumber NOTIFY billNumberChanged)
    Q_PROPERTY(qint32 total READ total WRITE setTotal NOTIFY totalChanged)

public:
    explicit BillManager(QObject *parent = 0);

    enum STATE {STATE_NEW, STATE_SAVED};

    STATE state();
    qint32 billNumber();
    qint32 total();

    void setState(STATE);
    void setBillNumber(qint32 billNumber);
    void setTotal(qint32 total);

    BillItemModel *getItemModel();

    Q_INVOKABLE bool addItem(QString itemCode, QString itemUnitCode, qint32 count);
    Q_INVOKABLE qint32 addItemToOrder();
    Q_INVOKABLE QVariantMap saveBill();
    Q_INVOKABLE QVariantMap clear();

signals:
    void stateChanged();
    void billNumberChanged(int billNumber);
    void totalChanged(int total);

public slots:
    void onAddToOrderClick();

private:
    BillHeaderModel mBillHeader;
    BillItemModel mBillItemModel;

    STATE mState;
    qint32 mBillNumber;
    qint32 mTotal;

    void clearHeader();
//    void getNewBillNumber();
    bool createNewBill();
};

#endif // BILLMANAGER_H
