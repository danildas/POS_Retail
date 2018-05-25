#ifndef USERMASTER_H
#define USERMASTER_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QDebug>

class UserMaster: public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString UserCode READ UserCode WRITE setUserCode NOTIFY UserCodeChanged)
    Q_PROPERTY(QString UserName READ UserName WRITE setUserName NOTIFY UserNameChanged)
    Q_PROPERTY(QString Role READ Role WRITE setRole NOTIFY RoleChanged)
    Q_PROPERTY(int TotalCount READ TotalCount WRITE setTotalCount NOTIFY TotalCountChanged)
    Q_PROPERTY(int roleValueCount READ roleValueCount WRITE setRoleValueCount NOTIFY roleValueCountChanged)

public:
    int userRowValue=-1;
    explicit UserMaster(QObject *parent = 0);

    QVariant data(const QModelIndex &index, int role ) const Q_DECL_OVERRIDE;

    QString UserCode();
    void setUserCode(QString UserCode);

    QString UserName();
    void setUserName(QString UserName);

    QString Role();
    void setRole(QString Role);

    int TotalCount();
    void setTotalCount(int TotalCount);

    int roleValueCount();
    int setRoleValueCount(int roleValueCount);


protected:
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

signals:
    void UserCodeChanged();
    void UserNameChanged();
    void RoleChanged();
    void TotalCountChanged();
    void roleValueCountChanged();

public slots:
    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool saveUser(QString UserName,QString Role,QString Password);
    Q_INVOKABLE bool next();
    Q_INVOKABLE bool previous();
    Q_INVOKABLE bool deleteUser();
    Q_INVOKABLE bool editUser(QString UserName,QString Role,QString Password);

private:
    QString m_UserCode;
    QString m_UserName;
    QString m_Role;
    int m_totalCount;
    int m_roleValueCount;
};
#endif // USERMASTER_H
