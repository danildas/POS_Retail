#include "itemunitsviewmodel.h"
#include <QSqlQuery>
#include <QDebug>

ItemUnitsViewModel::ItemUnitsViewModel(QObject *parent):
    QSqlQueryModel(parent)
{
    connect(this, SIGNAL(groupCodeChanged()), this, SLOT(onGroupCodeChanged()));
    connect(this, SIGNAL(subGroupCodeChanged()), this, SLOT(onSubGroupCodeChanged()));
}

QHash<int, QByteArray> ItemUnitsViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "code";
    roles[Qt::UserRole + 2] = "name";
    return roles;
}

QVariant ItemUnitsViewModel::data(const QModelIndex &index, int role) const
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

void ItemUnitsViewModel::refresh()
{
//    QString query = "SELECT Code, Name FROM ITEM WHERE SubGroupCode = '" + mSubGroupCode
//            + "' AND GroupCode = '" + mGroupCode + "';";
    // if (isSubgroupVisible)
    QString query = "SELECT Code, Name FROM ITEM WHERE GroupCode = '" + mGroupCode + "';";
    this->setQuery(query);
    qDebug() << Q_FUNC_INFO << getLastExecutedQuery(this->query());
}

QString ItemUnitsViewModel::getLastExecutedQuery(const QSqlQuery& query)
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

QString ItemUnitsViewModel::groupCode()
{
    return mGroupCode;
}

QString ItemUnitsViewModel::subGroupCode()
{
    return mSubGroupCode;
}

void ItemUnitsViewModel::setGroupCode(QString code)
{
    if (code != mGroupCode)
    {
        mGroupCode = code;
        emit groupCodeChanged();
    }
}

void ItemUnitsViewModel::setSubGroupCode(QString code)
{
    if (code != mSubGroupCode)
    {
        mSubGroupCode = code;
        emit subGroupCodeChanged();
    }
}

void ItemUnitsViewModel::onGroupCodeChanged()
{
    // needn't perform any action as subgroupcode is unique
    //refresh();
    //if (isSubgroupVisible)
    refresh();
}

void ItemUnitsViewModel::onSubGroupCodeChanged()
{
    refresh();
}
