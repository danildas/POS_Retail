#include "itemunitsviewmodel.h"
#include <QSqlQuery>
#include <QSqlRecord>
#include <QDebug>

ItemUnitsViewModel::ItemUnitsViewModel(QObject *parent):
    QSqlQueryModel(parent)
{
    connect(this, SIGNAL(itemCodeChanged()), this, SLOT(refresh()));
}

QHash<int, QByteArray> ItemUnitsViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "code";
    roles[Qt::UserRole + 2] = "name";
    roles[Qt::UserRole + 3] = "price";
    return roles;
}

QVariant ItemUnitsViewModel::data(const QModelIndex &index, int role) const
{
    qDebug() << Q_FUNC_INFO << "Invoked" << index << role;
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
    QString query = "SELECT UnitCode, Name, Price FROM ITEM_UNITS WHERE ItemCode = '" + mItemCode + "';";
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

QString ItemUnitsViewModel::itemCode()
{
    return mItemCode;
}

void ItemUnitsViewModel::setItemCode(QString code)
{
    if (code != mItemCode)
    {
        mItemCode = code;
        emit itemCodeChanged();
    }
}

QString ItemUnitsViewModel::itemUnitCode()
{
    return mItemUnitCode;
}

void ItemUnitsViewModel::setItemUnitCode(QString code)
{
    if (code != mItemUnitCode)
    {
        mItemUnitCode = code;
        emit itemUnitCodeChanged();
    }
}

int ItemUnitsViewModel::price(int row)
{
    return record(row).value("price").toInt();
}

QString ItemUnitsViewModel::unitCode(int row)
{
    qDebug() << Q_FUNC_INFO << "row" << row << "unit code" << record(row).value("UnitCode");
    return record(row).value("UnitCode").toString();
}
