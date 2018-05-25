import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: idRoot
    width: 200
    height: 100

    color: "#e3e8ec"
    border.color: "#d2d4d5"
    border.width: 1
    radius: 2 //10

//    Rectangle {
//        anchors.fill: parent
//        color: "red"
//    }

    GridView {
        id: idPayTypeListView
        anchors.fill: parent
        anchors.margins: 5
        cellWidth: parent.width//2 - 10
        cellHeight: parent.height/payTypeViewModel.rowCount() //50
        focus: true
        clip: true
        model: payTypeViewModel

        delegate: POS_FunctionButton {
            property variant modelData: model
            width: idPayTypeListView.cellWidth - 5
            height: idPayTypeListView.cellHeight - 5
            text: model.name

            onClicked: {
                GridView.view.currentIndex = index
            }
        }

        /*onCurrentIndexChanged: {
            console.log("index changed handler")

            if (-1 == currentIndex)
            {
                return;
            }

            //itemModel.subGroupCode = currentItem.modelData.code
            itemModel.itemCode = currentItem.modelData.code
            itemUnitsModel.itemCode = currentItem.modelData.code
            console.log("units count", itemUnitsModel.rowCount())
            itemUnitsModel.itemUnitCode = itemUnitsModel.unitCode(0);
//            idRoot.itemClicked(currentItem.modelData.name, 1, currentItem.modelData.price, currentItem.modelData.price)

            if (1 === itemUnitsModel.rowCount())
            {
                var priceValue = itemUnitsModel.price(0);
                console.log("price", priceValue)
//                idRoot.itemClicked(currentItem.modelData.name, 1,
//                        priceValue, priceValue)
                idRoot.itemClicked();
                currentIndex = -1;
            }
            else if (0 === itemUnitsModel.rowCount())
            {
                // show error message popup
                idRoot.error("Sorry, the selected item does not have valid credentials. Please contact data administrator.")
                currentIndex = -1;

            }
            else
            {
                // show item units popup
            }
        }*/
    }
}
