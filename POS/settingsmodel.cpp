#include "settingsmodel.h"
#include <QDebug>

SettingsModel::SettingsModel(QObject *parent) : QObject(parent)
{
    setMonetaryUnitFraction(100); // temporary, need to read&set from settings.
}

SettingsModel &SettingsModel::getInstance()
{
    static SettingsModel mInstance;
    return mInstance;
}

float SettingsModel::monetaryUnitFraction()
{
    qDebug() << Q_FUNC_INFO << "Invoked" << mMonetaryUnitFraction;
    return mMonetaryUnitFraction;
}

void SettingsModel::setMonetaryUnitFraction(float fraction)
{
    qDebug() << Q_FUNC_INFO << "Invoked" << fraction;

    if (fraction != mMonetaryUnitFraction)
    {
        mMonetaryUnitFraction = fraction;
        emit monetaryUnitFractionChanged();
    }

    qDebug() << Q_FUNC_INFO << "Exits";
}
