#ifndef DISPLAYMODELMANAGER_H
#define DISPLAYMODELMANAGER_H

#include <QObject>
#include "groupviewmodel.h"
#include "subgroupviewmodel.h"
#include "itemviewmodel.h"
#include "itemunitsviewmodel.h"

class DisplayModelManager : public QObject
{
    Q_OBJECT
public:
    explicit DisplayModelManager(QObject *parent = 0);

    GroupViewModel      *getGroupViewModel();
    SubGroupViewModel   *getSubGroupViewModel();
    ItemViewModel       *getItemViewModel();
    ItemUnitsViewModel  *getItemUnitsViewModel();

signals:

public slots:

private:

    GroupViewModel      mGroupModel;
    SubGroupViewModel   mSubGroupModel;
    ItemViewModel       mItemModel;
    ItemUnitsViewModel  mItemUnitsModel;
};

#endif // DISPLAYMODELMANAGER_H
