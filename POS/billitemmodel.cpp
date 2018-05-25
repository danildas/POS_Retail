#include "billitemmodel.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

BillItemModel::BillItemModel(QObject *parent) : QAbstractListModel(parent)
{

}

int BillItemModel::rowCount(const QModelIndex &parent) const
{
    return mBillItems.count();
}

QHash<int, QByteArray> BillItemModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ITEMCODEROLE] = "itemCode";
    roles[UNITCODEROLE] = "unitCode";
    roles[ITEMNAMEROLE] = "itemName";
    roles[COUNTROLE] = "count";
    roles[PRICEROLE] = "price";
    roles[TOTALROLE] = "total";
    roles[ISPARENTROLE] = "isParent";
    roles[LINENUMBERROLE] = "lineNumber";
    roles[PARENTLINENUMBERROLE] = "parentLineNumber";
    return roles;
}

QVariant BillItemModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= mBillItems.count())
    {
        return QVariant();
    }

    BillItem *billItem1= mBillItems[index.row()];

    if (role == ITEMCODEROLE)
    {
        QString itemCode = billItem1->itemCode();
        return QVariant::fromValue(itemCode);
    }
    else if (role == UNITCODEROLE)
    {
        return QVariant::fromValue(billItem1->unitCode());
    }
    else if (role == ITEMNAMEROLE)
    {
        return QVariant::fromValue(billItem1->itemName());
    }
    else if (role == COUNTROLE)
    {
        return QVariant::fromValue(billItem1->count());
    }
    else if (role == PRICEROLE)
    {
        return QVariant::fromValue(billItem1->price());
    }
    else if (role == TOTALROLE)
    {
        return QVariant::fromValue(billItem1->total());
    }
    else if (role == ISPARENTROLE)
    {
        return QVariant::fromValue(billItem1->isParentItem());
    }
    else if (role == LINENUMBERROLE)
    {
        return QVariant::fromValue(billItem1->lineNumber());
    }
    else if (role == PARENTLINENUMBERROLE)
    {
        return QVariant::fromValue(billItem1->parentLineNumber());
    }
    else
    {
        return QVariant();
    }
}

void BillItemModel::addItem(const BillItem &billItem)
{
    beginInsertRows(QModelIndex(), rowCount(),rowCount());
//    mBillItems << billItem;
    endInsertRows();
}

bool BillItemModel::addItem(QString itemCode, QString itemUnitCode, qint32 count, qint32 &total, QString &errorMessage)
{
    qDebug() << Q_FUNC_INFO << "Invoked" << itemCode << itemUnitCode << count << mBillItems.count();
    bool status = false;

    if (mBillItems.count() > 0)
    {
        qDebug() << Q_FUNC_INFO << "has items" << mBillItems.count();
        BillItem *item = mBillItems.last();

        if (NULL != item)
        {
            if (item->itemCode() == itemCode && item->unitCode() == itemUnitCode && 0 == item->status())
            {
                qDebug() << Q_FUNC_INFO << "same last item";
                item->setCount(item->count() + count);
                item->setTotal(item->count() * item->price());
                total = item->price() * count;
                status = true;
                qDebug() << Q_FUNC_INFO << "emit data changed of" << mBillItems.count()-1;
                emit QAbstractItemModel::dataChanged(index(mBillItems.count()-1, 0), index(mBillItems.count()-1, 0));
            }
        }
    }

    if (!status)
    {
        beginInsertRows(QModelIndex(), rowCount(),rowCount());

        BillItem *item = new BillItem(this);

        if (NULL != item)
        {
            qDebug() << Q_FUNC_INFO << "set data";
            item->setItemCode(itemCode);
            item->setUnitCode(itemUnitCode);
            item->setCount(count);
            item->setLineNumber(mBillItems.count() + 1);
            //TODO : BEGIN: to be corrected once side item is implemented.
            item->setIsParentItem(true);
            item->setParentLineNumber(item->lineNumber());
            //TODO : END: to be corrected once side item is implemented.
            status = fillItemDetails(item, errorMessage);
            mBillItems.append(item);
            total = item->total();
        }

        endInsertRows();
    }

    qDebug() << Q_FUNC_INFO << "Exits" << status;
    return status;
}

bool BillItemModel::clear(QString &errorMessage)
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    bool status = false;
    // should check if unsaved items exists - may b will implement in UI itself.
    beginResetModel();
    mBillItems.clear();
    endResetModel();
    status = true;
    qDebug() << Q_FUNC_INFO << "Exits" << status;
    return status;
}

bool BillItemModel::fillItemDetails(BillItem *item, QString &errorMessage)
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    bool status = false;

    if (NULL != item)
    {
        QString queryString = "SELECT ITEM.Name, ITEM_UNITS.Name As UnitName, ITEM_UNITS.Price FROM ITEM, ITEM_UNITS "
                              "WHERE ITEM_UNITS.ItemCode = ITEM.Code AND ITEM.Code = '" + item->itemCode() + "' "
                              "AND ITEM_UNITS.UnitCode = '" + item->unitCode() + "';";
        QSqlQuery query;

        if (query.exec(queryString))
        {
            while (query.next())
            {
                QString itemName    = query.value(0).toString();
                QString unitName    = query.value(1).toString();
                qint32 price        = query.value(2).toInt();
                QString name        = unitName.isEmpty() ? itemName : itemName + " (" + unitName + ")";
                item->setItemName(name);
                item->setPrice(price);
                item->setTotal(item->count() * item->price());
                status = true;
                qDebug() << Q_FUNC_INFO << "name" << item->itemName() << item->price();
            }
        }
        else
        {
            errorMessage = query.lastError().text();
            qDebug() << Q_FUNC_INFO << "Failed to add item:" << errorMessage;
        }
    }
    else
    {
        qDebug() << Q_FUNC_INFO << "Null item";
    }

    qDebug() << Q_FUNC_INFO << "Exits" << status;
    return status;
}

QVariantMap BillItemModel::saveBillItems(qint32 billNumber)
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    QVariantMap result;
    bool status = true;
    QString errorMessage;
    QString queryString;
    QSqlQuery query;

    if (!mBillItems.count())
    {
        errorMessage = "No items to save.";
        status = false;
    }

    foreach (BillItem *item, mBillItems)
    {
        if (NULL != item)
        {
            if (0 == item->status())
            {
                queryString = "INSERT INTO BILLITEMS (Bill, ItemCode, UnitCode, Name, Quantity, Price, "
                              "IsParentItem, LineNumber, ParentLineNumber) "
                              "VALUES("+ QString::number(billNumber) + ", '" + item->itemCode() + "', '" +
                              item->unitCode() + "', '" + item->itemName() + "', " + QString::number(item->count())
                               + ", " + QString::number(item->price()) + ", " + QString::number(item->isParentItem())
                               + ", " + QString::number(item->lineNumber()) + ", " +
                              QString::number(item->parentLineNumber()) + ");";
                qDebug() << Q_FUNC_INFO << "queryString" << queryString;

                if (!query.exec(queryString))
                {
                    status = false;
                    errorMessage = query.lastError().text();
                }

                item->setStatus(1); // to be done after commit
            }
        }
    }

    result.insert("status", status);
    result.insert("message", errorMessage);

    qDebug() << Q_FUNC_INFO << "Exits" << status << billNumber << errorMessage;
    return result;
}
