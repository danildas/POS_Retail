#ifndef PRINTMANAGER_H
#define PRINTMANAGER_H

#include <QObject>
#include "settingsmodel.h"
#include <QVariantMap>

class PrintManager : public QObject
{
    Q_OBJECT
public:
    explicit PrintManager(QObject *parent = 0);

    Q_INVOKABLE QVariantMap printBill(qint32 billNumber);

signals:

public slots:

private:
//    SettingsModel mSettings;

    void appendSpace(QString &data, int count);
    QString appendName(QString name);
    void appendQuantity(QString &itemData, QString quantity);
    void appendPrice(QString &itemData, QString price);
    void appendAmount(QString &itemData, QString amount);
    QString addItem(QString name, QString quantity, QString price, QString total);

};

#endif // PRINTMANAGER_H
