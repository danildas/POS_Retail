#include "paytypeviewmodel.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

PayTypeViewModel::PayTypeViewModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    refresh();
}

QHash<int, QByteArray> PayTypeViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "code";
    roles[Qt::UserRole + 2] = "name";
    return roles;
}


QVariant PayTypeViewModel::data(const QModelIndex &index, int role) const
{
    qDebug() << Q_FUNC_INFO << "Invoked";
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

void PayTypeViewModel::refresh()
{
    this->setQuery("SELECT Code, Name FROM 'PAYMENTTYPEMASTER'");
    qDebug() << Q_FUNC_INFO << getLastExecutedQuery(this->query());
    qDebug() << Q_FUNC_INFO << this->columnCount() << this->rowCount();
}

QString PayTypeViewModel::getLastExecutedQuery(const QSqlQuery& query)
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
