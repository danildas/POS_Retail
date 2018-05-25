#ifndef PRINTERMASTER_H
#define PRINTERMASTER_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlError>
#include <QDebug>

class PrinterMaster: public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(QString Code READ Code WRITE setCode NOTIFY CodeChanged)
    Q_PROPERTY(QString PrinterType READ PrinterType WRITE setPrinterType NOTIFY PrinterTypeChanged)
    Q_PROPERTY(QString Ip READ Ip WRITE setIp NOTIFY IpChanged)
    Q_PROPERTY(QString Port READ Port WRITE setPort NOTIFY PortChanged)
    Q_PROPERTY(QString BaudRate READ BaudRate WRITE setBaudRate NOTIFY BaudRateChanged)
    Q_PROPERTY(int TotalCount READ TotalCount WRITE setTotalCount NOTIFY TotalCountChanged)
    Q_PROPERTY(QString Role READ Role WRITE setRole NOTIFY RoleChanged)
public:
    int rowValue=-1;
    explicit PrinterMaster(QObject *parent = 0);

    QVariant data(const QModelIndex &index, int role ) const Q_DECL_OVERRIDE;

    QString Code();
    void setCode(QString Code);

    QString PrinterType();
    void setPrinterType(QString PrinterType);

    QString Ip();
    void setIp(QString Ip);

    QString Port();
    void setPort(QString Port);

    QString BaudRate();
    void setBaudRate(QString BaudRate);

    int TotalCount();
    void setTotalCount(int TotalCount);

    QString Role();
    void setRole(QString Role);

protected:

    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

signals:
    void CodeChanged();
    void PrinterTypeChanged();
    void IpChanged();
    void PortChanged();
    void BaudRateChanged();
    void TotalCountChanged();
    void RoleChanged();

public slots:
    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool savePrinter(QString Code,QString PrinterType,QString Ip,QString Port,QString BaudRate);
    Q_INVOKABLE bool deletePrinter();
    Q_INVOKABLE bool edit(QString Ip,QString Port,QString BaudRate);
    Q_INVOKABLE bool next();
    Q_INVOKABLE bool previous();
    Q_INVOKABLE bool getRole();
    Q_INVOKABLE bool getCode();

private:
    QString m_code;
    QString m_printerType;
    QString m_ip;
    QString m_port;
    QString m_baudRate;
    int m_totalCount;
    QString m_role;
};

#endif // PRINTERMASTER_H
