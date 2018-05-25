#include "billitem.h"
#include <QSqlQuery>

BillItem::BillItem(QObject *parent) : QObject(parent)
{
    setStatus(0);
}

//BillItem::BillItem(QString itemCode, QString itemUnitCode, qint32 count, QObject *parent)
//{
////    QSqlQuery query;
////    QString query1 = "SELECT ITEM.Name FROM ITEM JOIN ITEM_UNITS ON ITEM.Code = ITEM_UNITS.UnitCode"
////                    "WHERE ITEM.Code = '" + itemCode + "' AND ITEM_UNITS.UnitCode = '"+ itemUnitCode+"';";

////    QString queryStr = "SELECT UnitCode, Name, Price FROM ITEM_UNITS WHERE ItemCode = '" + mItemCode + "';";
////    query.prepare("SELECT ifnull(MAX(BILLHEADER.billNumber), 0) FROM BILLHEADER;");

////    if (query.exec())
////    {
////        if (query.next())
////        {
////            bool ok = false;
//////            int billNumber; //= query.value(1).toInt(&ok);

////            if (!ok)
////            {
//////                billNumber = -1;
////            }
////            else
////            {
//////                billNumber++; //get next bill no
////            }
////        }
////    }
//}

QString BillItem::itemCode() const
{
    return mItemCode;
}

QString BillItem::unitCode() const
{
    return mUnitCode;
}

QString BillItem::itemName() const
{
    return mItemName;
}

qint32 BillItem::count() const
{
    return mCount;
}

qint32 BillItem::price() const
{
    return mPrice;
}

qint32 BillItem::total() const
{
    return mTotal;
}

bool BillItem::isParentItem() const
{
    return mIsParentItem;
}

int BillItem::lineNumber() const
{
    return mLineNumber;
}

int BillItem::parentLineNumber() const
{
    return mParentLineNumber;
}

int BillItem::status() const
{
    return mStatus;
}


void BillItem::setItemCode(QString itemCode)
{
    if (itemCode != mItemCode)
    {
        mItemCode = itemCode;
        emit itemCodeChanged(mItemCode);
    }
}

void BillItem::setUnitCode(QString unitCode)
{
    if (unitCode != mUnitCode)
    {
        mUnitCode = unitCode;
        emit unitCodeChanged(mUnitCode);
    }
}

void BillItem::setItemName(QString itemName)
{
    if (itemName != mItemName)
    {
        mItemName = itemName;
        emit itemNameChanged(mItemName);
    }
}

void BillItem::setCount(qint32 count)
{
    if (count != mCount)
    {
        mCount = count;
        emit countChanged(mCount);
    }
}

void BillItem::setPrice(qint32 price)
{
    if (price != mPrice)
    {
        mPrice = price;
        emit priceChanged(mPrice);
    }
}

void BillItem::setTotal(qint32 total)
{
    if (total != mTotal)
    {
        mTotal = total;
        emit totalChanged(mTotal);
    }
}

void BillItem::setIsParentItem(bool parent)
{
    if (parent != mIsParentItem)
    {
        mIsParentItem = parent;
        emit parentStatusChanged(mIsParentItem);
    }
}

void BillItem::setLineNumber(int lineNumber)
{
    if (lineNumber != mLineNumber)
    {
        mLineNumber = lineNumber;
        emit lineNumberChanged(mLineNumber);
    }
}

void BillItem::setParentLineNumber(int parentLineNumber)
{
    if (parentLineNumber != mParentLineNumber)
    {
        mParentLineNumber = parentLineNumber;
        emit parentLineNumberChanged(mParentLineNumber);
    }
}

void BillItem::setStatus(int status)
{
    if (status != mStatus)
    {
        mStatus = status;
        emit statusChanged(mStatus);
    }
}

