#ifndef SUBGROUPVIEWMODEL_H
#define SUBGROUPVIEWMODEL_H

#include <QSqlQueryModel>

class SubGroupViewModel : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString groupCode READ groupCode WRITE setGroupCode NOTIFY groupCodeChanged)

public:
    SubGroupViewModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    void refresh();

    //Q_INVOKABLE void setGroupCode(QString code);
    QString getLastExecutedQuery(const QSqlQuery& query);

    QString groupCode();
    void setGroupCode(QString code);

private slots:
    void onGroupCodeChanged();

protected:
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

private:
    QString mGroupCode;

signals:
    void groupCodeChanged();
};

#endif // SUBGROUPVIEWMODEL_H
