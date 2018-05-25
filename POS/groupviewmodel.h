#ifndef GROUPVIEWMODEL_H
#define GROUPVIEWMODEL_H

#include <QSqlQueryModel>

class GroupViewModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    GroupViewModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    void refresh();

    QString getLastExecutedQuery(const QSqlQuery& query);
protected:
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
};

#endif // GROUPVIEWMODEL_H
