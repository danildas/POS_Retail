#ifndef PAYTYPEVIEWMODEL_H
#define PAYTYPEVIEWMODEL_H

#include <QSqlQueryModel>

class PayTypeViewModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    PayTypeViewModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    void refresh();

    QString getLastExecutedQuery(const QSqlQuery& query);
protected:
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
};

#endif // PAYTYPEVIEWMODEL_H
