#ifndef ITEMUNITSVIEWMODEL_H
#define ITEMUNITSVIEWMODEL_H

#include <QSqlQueryModel>

class ItemUnitsViewModel : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString itemCode READ itemCode WRITE setItemCode NOTIFY itemCodeChanged)
    Q_PROPERTY(QString itemUnitCode READ itemUnitCode WRITE setItemUnitCode NOTIFY itemUnitCodeChanged)

public:
    ItemUnitsViewModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;

    QString getLastExecutedQuery(const QSqlQuery& query);

    QString itemCode();
    void setItemCode(QString code);

    QString itemUnitCode();
    void setItemUnitCode(QString code);

    Q_INVOKABLE int price(int row);
    Q_INVOKABLE QString unitCode(int row);

public slots:
    void refresh();

protected:
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

private:
    QString mItemCode;
    QString mItemUnitCode;

signals:
    void itemCodeChanged();
    void itemUnitCodeChanged();
};

#endif // ITEMUNITSVIEWMODEL_H
