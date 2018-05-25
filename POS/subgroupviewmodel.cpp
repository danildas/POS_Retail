#include "subgroupviewmodel.h"
#include <QSqlQuery>
#include <QDebug>

SubGroupViewModel::SubGroupViewModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    connect(this, SIGNAL(groupCodeChanged()), this, SLOT(onGroupCodeChanged()));
}

QHash<int, QByteArray> SubGroupViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "code";
    roles[Qt::UserRole + 2] = "name";
    return roles;
}

QVariant SubGroupViewModel::data(const QModelIndex &index, int role) const
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

void SubGroupViewModel::refresh()
{
    QString query = "SELECT Code, Name FROM SUBGROUP WHERE GroupCode = '" + mGroupCode + "';";
    this->setQuery(query);
    qDebug() << Q_FUNC_INFO << getLastExecutedQuery(this->query());
}

QString SubGroupViewModel::getLastExecutedQuery(const QSqlQuery& query)
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

QString SubGroupViewModel::groupCode()
{
    return mGroupCode;
}

void SubGroupViewModel::setGroupCode(QString code)
{
    if (code != mGroupCode)
    {
        mGroupCode = code;
        emit groupCodeChanged();
    }
}

void SubGroupViewModel::onGroupCodeChanged()
{
    refresh();
}
