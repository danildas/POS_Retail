#include "displaymodelmanager.h"

DisplayModelManager::DisplayModelManager(QObject *parent) : QObject(parent)
{
    mGroupModel.refresh();
}

GroupViewModel *DisplayModelManager::getGroupViewModel()
{
    return &mGroupModel;
}

SubGroupViewModel *DisplayModelManager::getSubGroupViewModel()
{
    return &mSubGroupModel;
}

ItemViewModel *DisplayModelManager::getItemViewModel()
{
    return &mItemModel;
}

ItemUnitsViewModel *DisplayModelManager::getItemUnitsViewModel()
{
    return &mItemUnitsModel;
}
