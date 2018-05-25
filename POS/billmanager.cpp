#include "billmanager.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

BillManager::BillManager(QObject *parent) : QObject(parent)
{

    setState(STATE_NEW);
    setTotal(0);
    setBillNumber(-1);

//    connect(&mBillHeader, SIGNAL(billNumberChanged()), &mBillItems, SLOT(handleBillChange()));
//    connect(&mBillHeader, SIGNAL(billNumberChanged()), &mBillPayment, SLOT(handleBillChange()));
}

BillManager::STATE BillManager::state()
{
    qDebug() << Q_FUNC_INFO << "Invoked" << mState;
    return mState;
}

void BillManager::setState(STATE state)
{
    qDebug() << Q_FUNC_INFO << "Invoked" << state << mState;

    if (state != mState)
    {
        mState = state;
        emit stateChanged();
    }

    qDebug() << Q_FUNC_INFO << "Exits";
}

qint32  BillManager::billNumber()
{
    qDebug() << Q_FUNC_INFO << "Invoked" << mBillNumber;
    return mBillNumber;
}

void BillManager::setBillNumber(qint32 billNumber)
{
    qDebug() << Q_FUNC_INFO << "Invoked" << billNumber << mBillNumber;

    if (billNumber != mBillNumber)
    {
        mBillNumber = billNumber;
        emit billNumberChanged(mBillNumber);
    }

    qDebug() << Q_FUNC_INFO << "Exits";
}

qint32  BillManager::total()
{
    qDebug() << Q_FUNC_INFO << "Invoked" << mTotal;
    return mTotal;
}

void BillManager::setTotal(qint32 total)
{
    qDebug() << Q_FUNC_INFO << "Invoked" << total << mTotal;

    if (total != mTotal)
    {
        mTotal = total;
        emit totalChanged(mTotal);
    }

    qDebug() << Q_FUNC_INFO << "Exits";
}

BillItemModel *BillManager::getItemModel()
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    return &mBillItemModel;
}

bool BillManager::createNewBill()
{
    bool status = false;

    if (mBillHeader.createNewBill())
    {
        status = true;
    }

    return status;
}

bool BillManager::addItem(QString itemCode, QString itemUnitCode, qint32 count)
{
    qDebug() << Q_FUNC_INFO << "Invoked" << itemCode << itemUnitCode << count;
    bool status = false;
    QString errorMessage;
    qint32 itemTotal = 0;
    status = mBillItemModel.addItem(itemCode, itemUnitCode, count, itemTotal, errorMessage);
    setTotal(mTotal + itemTotal);
    qDebug() << Q_FUNC_INFO << "Exits" << status;
    return status;
}

QVariantMap BillManager::saveBill()
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    QVariantMap result;
    qint32 billNum = -1;
    bool status = false;
    QString errorMessage;

    // start transaction
    // generate next bill number
    // save bill header to db
    // save all items to db
    // end transaction
    if (QSqlDatabase::database().transaction())
    {
        QSqlQuery query;
        QString queryString;

        if (-1 == billNumber())
        {
            queryString = "INSERT INTO BILLHEADER (total) VALUES ("+ QString::number(total()) +");";

            if (query.exec(queryString))
            {
                queryString = "SELECT last_insert_rowid();";

                if (query.exec(queryString))
                {
                    while (query.next())
                    {
                        billNum = query.value(0).toInt();
                        setBillNumber(billNum);
                        qDebug() << Q_FUNC_INFO << "bill number" << billNum;
                        result = mBillItemModel.saveBillItems(billNum);
                    }
                }
                else
                {
                    errorMessage = query.lastError().text();
                }
            }
            else
            {
                errorMessage = query.lastError().text();
            }
        }
        else
        {
            qDebug() << Q_FUNC_INFO << "bill number" << billNumber();
            result = mBillItemModel.saveBillItems(billNumber());
        }

        if (result.value("status", false).toBool())
        {
            if (QSqlDatabase::database().commit())
            {
                status = true;
            }
            else
            {
                errorMessage = QSqlDatabase::database().lastError().text();
            }
        }
        else
        {
            if (result.contains("status"))
            {
                errorMessage = result.value("message").toString();
            }
        }
    }
    else
    {
        errorMessage = QSqlDatabase::database().lastError().text();
    }

    if (!status)
    {
        if (!QSqlDatabase::database().rollback())
        {
            qDebug() << Q_FUNC_INFO << "requries application restart, to kill active select query";
        }
    }

    result.insert("status", status);
    result.insert("billNumber", billNumber());
    result.insert("message", errorMessage);

    qDebug() << Q_FUNC_INFO << "Exits" << status << billNum << errorMessage;
    return result;
}


void BillManager::clearHeader()
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    setBillNumber(-1);
    setTotal(0);
    qDebug() << Q_FUNC_INFO << "Exits";
}

QVariantMap BillManager::clear()
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    bool status = false;
    QString errorMessage;
    QVariantMap result;

    if (mBillItemModel.clear(errorMessage))
    {
        clearHeader();
    }

    result.insert("status", status);
    result.insert("message", errorMessage);
    qDebug() << Q_FUNC_INFO << "Exits" << status;
    return result;
}

qint32 BillManager::addItemToOrder()
{
    qint32 status = -1; // unknown error
//    qDebug() << Q_FUNC_INFO << mItemModel.itemCode() << "unit code" << mItemUnitsModel.itemUnitCode();

//    if (STATE_NEW == state())
//    {
//        if (createNewBill())
//        {
//            addItem(mItemModel.itemCode(), mItemUnitsModel.itemUnitCode(), 1);
//        }
//        else
//        {
//            status = 1;
//        }
//    }

    return status;
}


//addBillItem(item)
//{
//    if (!isLastItem(item))
//    {

//    }
//}

void BillManager::onAddToOrderClick()
{
    if (0 == mBillHeader.billNumber())
    {
        //createNewBill();
    }

    //addBillItem(item);
}
