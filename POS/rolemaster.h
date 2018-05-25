#ifndef ROLEMASTER_H
#define ROLEMASTER_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QDebug>

class RoleMaster: public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString Code READ Code WRITE setCode NOTIFY CodeChanged)
    Q_PROPERTY(QString Role READ Role WRITE setRole NOTIFY RoleChanged)
    Q_PROPERTY(int sales READ sales WRITE setSales NOTIFY salesChanged)
    Q_PROPERTY(int payments READ payments WRITE setPayments NOTIFY paymentsChanged)
    Q_PROPERTY(int settings READ settings WRITE setSettings NOTIFY settingsChanged)
    Q_PROPERTY(int report READ report WRITE setReport NOTIFY reportChanged)
    Q_PROPERTY(int TotalCount READ TotalCount WRITE setTotalCount NOTIFY TotalCountChanged)

public:
    int roleRowValue =-1;
    explicit RoleMaster(QObject *parent = 0);

    QVariant data(const QModelIndex &index, int role ) const Q_DECL_OVERRIDE;

    QString Code();
    void setCode(QString Code);

    QString Role();
    void setRole(QString Role);

    int sales();
    int setSales(int sales);

    int payments();
    int setPayments(int payments);

    int settings();
    int setSettings(int settings);

    int report();
    int setReport(int report);

    int TotalCount();
    int setTotalCount(int TotalCount);

protected:
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

signals:
    void CodeChanged();
    void RoleChanged();
    void salesChanged();
    void paymentsChanged();
    void settingsChanged();
    void reportChanged();
    void TotalCountChanged();

public slots:
    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool getRole();
    Q_INVOKABLE bool saveRole(QString Role, int Sales, int Payment, int Settings, int Reports);
    Q_INVOKABLE bool next();
    Q_INVOKABLE bool previous();
    Q_INVOKABLE bool edit(QString Role, int Sales, int Payment, int Settings, int Reports);
    Q_INVOKABLE bool deleteRole();
    Q_INVOKABLE bool editUserRole(QString newRole);

private:
    QString m_Code;
    QString m_Role;
    int m_sales;
    int m_payments;
    int m_settings;
    int m_report;
    int m_totalCount;

};

#endif // ROLEMASTER_H
