#include "itemviewmodel.h"
#include <QSqlQuery>
#include <QDebug>

ItemViewModel::ItemViewModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    connect(this, SIGNAL(groupCodeChanged()), this, SLOT(onGroupCodeChanged()));
    connect(this, SIGNAL(subGroupCodeChanged()), this, SLOT(onSubGroupCodeChanged()));
}

QHash<int, QByteArray> ItemViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "code";
    roles[Qt::UserRole + 2] = "name";
    roles[Qt::UserRole + 3] = "price";
    return roles;
}

QVariant ItemViewModel::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);

    if(role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }

    return value;
}

void ItemViewModel::refresh()
{
//    QString query = "SELECT Code, Name FROM ITEM WHERE SubGroupCode = '" + mSubGroupCode
//            + "' AND GroupCode = '" + mGroupCode + "';";
    // if (isSubgroupVisible)
//    QString query = "SELECT Code, Name FROM ITEM WHERE GroupCode = '" + mGroupCode + "';";

    QString query = "SELECT Code, Name, (select MAX(Price) from ITEM_UNITS where ItemCode = Code) As Price "
                    "FROM ITEM WHERE GroupCode = '" + mGroupCode + "';";
    this->setQuery(query);
    qDebug() << Q_FUNC_INFO << getLastExecutedQuery(this->query());
}

QString ItemViewModel::getLastExecutedQuery(const QSqlQuery& query)
{
    QString str = query.lastQuery();
    QMapIterator<QString, QVariant> it(query.boundValues());

    while (it.hasNext())
    {
        it.next();
        str.replace(it.key(),it.value().toString());
    }

    return str;
}

QString ItemViewModel::groupCode()
{
    return mGroupCode;
}

QString ItemViewModel::subGroupCode()
{
    return mSubGroupCode;
}

QString ItemViewModel::itemCode()
{
    return mItemCode;
}

void ItemViewModel::setGroupCode(QString code)
{
    if (code != mGroupCode)
    {
        mGroupCode = code;
        emit groupCodeChanged();
    }
}

void ItemViewModel::setSubGroupCode(QString code)
{
    if (code != mSubGroupCode)
    {
        mSubGroupCode = code;
        emit subGroupCodeChanged();
    }
}

void ItemViewModel::setItemCode(QString code)
{
    if (code != mItemCode)
    {
        mItemCode = code;
        emit itemCodeChanged();
    }
}

void ItemViewModel::onGroupCodeChanged()
{
    // needn't perform any action as subgroupcode is unique
    //refresh();
    //if (isSubgroupVisible)
    refresh();
}

void ItemViewModel::onSubGroupCodeChanged()
{
    refresh();
}
