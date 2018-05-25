#ifndef ITEMVIEWMODEL_H
#define ITEMVIEWMODEL_H

#include <QSqlQueryModel>

class ItemViewModel : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString groupCode READ groupCode WRITE setGroupCode NOTIFY groupCodeChanged)
    Q_PROPERTY(QString subGroupCode READ subGroupCode WRITE setSubGroupCode NOTIFY subGroupCodeChanged)
    Q_PROPERTY(QString itemCode READ itemCode WRITE setItemCode NOTIFY itemCodeChanged)

public:
    ItemViewModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    void refresh();

//    Q_INVOKABLE void setGroupCode(QString code);
    QString getLastExecutedQuery(const QSqlQuery& query);

    QString groupCode();
    void setGroupCode(QString code);

    QString subGroupCode();
    void setSubGroupCode(QString code);

    QString itemCode();
    void setItemCode(QString code);

private slots:
    void onGroupCodeChanged();
    void onSubGroupCodeChanged();

protected:
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

private:
    QString mGroupCode;
    QString mSubGroupCode;
    QString mItemCode;

signals:
    void groupCodeChanged();
    void subGroupCodeChanged();
    void itemCodeChanged();
};

#endif // ITEMVIEWMODEL_H
