#ifndef SETTINGSMODEL_H
#define SETTINGSMODEL_H

#include <QObject>

class SettingsModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float monetaryUnitFraction READ monetaryUnitFraction WRITE setMonetaryUnitFraction NOTIFY monetaryUnitFractionChanged)


public:
    explicit SettingsModel(QObject *parent = 0);
    static SettingsModel &getInstance();

    float monetaryUnitFraction();
    void setMonetaryUnitFraction(float fraction);

signals:
    void monetaryUnitFractionChanged();

public slots:

private:
    float mMonetaryUnitFraction;
};

#endif // SETTINGSMODEL_H
