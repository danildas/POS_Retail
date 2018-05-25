#include "billheadermodel.h"
#include <QSqlQuery>
#include <QDebug>

BillHeaderModel::BillHeaderModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    mBillNumber = 0;
    connect(this, SIGNAL(groupCodeChanged()), this, SLOT(onGroupCodeChanged()));
    connect(this, SIGNAL(subGroupCodeChanged()), this, SLOT(onSubGroupCodeChanged()));
}

QHash<int, QByteArray> BillHeaderModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "code";
    roles[Qt::UserRole + 2] = "name";
    return roles;
}

QVariant BillHeaderModel::data(const QModelIndex &index, int role) const
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

void BillHeaderModel::refresh()
{
    //QString query = "SELECT Code, Name FROM ITEM WHERE GroupCode = '" + mGroupCode + "';";
    QString query = "SELECT * FROM BILLHEADER WHERE BillNumber = '"+ QString::number(mBillNumber) + "';";
    this->setQuery(query);
    qDebug() << Q_FUNC_INFO << getLastExecutedQuery(this->query());
}

QString BillHeaderModel::getLastExecutedQuery(const QSqlQuery& query)
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

QString BillHeaderModel::groupCode()
{
    return mGroupCode;
}

QString BillHeaderModel::subGroupCode()
{
    return mSubGroupCode;
}

void BillHeaderModel::setGroupCode(QString code)
{
    if (code != mGroupCode)
    {
        mGroupCode = code;
        emit groupCodeChanged();
    }
}

void BillHeaderModel::setSubGroupCode(QString code)
{
    if (code != mSubGroupCode)
    {
        mSubGroupCode = code;
        emit subGroupCodeChanged();
    }
}

void BillHeaderModel::onGroupCodeChanged()
{
    refresh();
}

void BillHeaderModel::onSubGroupCodeChanged()
{
    refresh();
}

qint32 BillHeaderModel::billNumber()
{
    return mBillNumber;
}

void BillHeaderModel::setBillNumber(qint32 billNumber)
{
    if (billNumber != mBillNumber)
    {
        mBillNumber = billNumber;
        billNumberChanged(mBillNumber);
    }
}

qint32 BillHeaderModel::getNextBillNumber()
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    qint32 billNumber = -1;
    QSqlQuery query;
    query.prepare("SELECT ifnull(MAX(BILLHEADER.billNumber), 0) FROM BILLHEADER;");

    if (query.exec())
    {
        if (query.next())
        {
            bool ok = false;
            billNumber = query.value(1).toInt(&ok);

            if (!ok)
            {
                billNumber = -1;
            }
            else
            {
                billNumber++; //get next bill no
            }
        }
    }

    qDebug() << Q_FUNC_INFO << "Exit" << billNumber;
    return billNumber;
}

bool BillHeaderModel::createNewBill()
{
    qDebug() << Q_FUNC_INFO << "Invoked";
    bool status = false;
    qint32 billNumber = getNextBillNumber();

    if (-1 != billNumber)
    {
        setBillNumber(billNumber);
        status = true;
    }

    qDebug() << Q_FUNC_INFO << "Exits" << billNumber << status;
    return status;
}
