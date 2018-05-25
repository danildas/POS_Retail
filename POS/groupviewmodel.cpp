#include "groupviewmodel.h"
#include <QSqlQuery>
#include <QDebug>
#include <QSqlError>

GroupViewModel::GroupViewModel(QObject *parent) :
    QSqlQueryModel(parent)
{
}

QHash<int, QByteArray> GroupViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "code";
    roles[Qt::UserRole + 2] = "name";
    return roles;
}


QVariant GroupViewModel::data(const QModelIndex &index, int role) const
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

void GroupViewModel::refresh()
{
    this->setQuery("SELECT Code, Name FROM 'GROUP'");
    qDebug() << Q_FUNC_INFO << getLastExecutedQuery(this->query());
    qDebug() << Q_FUNC_INFO << this->columnCount() << this->rowCount();
}

QString GroupViewModel::getLastExecutedQuery(const QSqlQuery& query)
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
