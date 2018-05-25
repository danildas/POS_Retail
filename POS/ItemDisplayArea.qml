import QtQuick 2.7

Item {
    id: idRoot
    width: 200
    height: 100

    property alias groupNameDisplay: idGroupNameText.text

    signal itemClicked()
    signal error(string message)

    /*BorderImage {
        id: idItemBackground
        source: "qrc:/images/theme1/containerBg.png"
        border.left: 10; border.top: 10
        border.right: 10; border.bottom: 10
        anchors.fill: parent

        Rectangle {
            color: "black"
            opacity: 0.1
            anchors.fill: idGroupNameText
            anchors.topMargin: -8
            radius: 5
        }

        Text {
            id: idGroupNameText
            text: qsTr("")
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.topMargin: 10
        }
    }*/

    Rectangle {
        id: idItemBackground
        anchors.fill: parent
        radius: 2 // 10
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ebebec" }
            GradientStop { position: 1.0; color: "#e3e8ec" }
        }

        border.color: "#d2d4d5"
        border.width: 1


        Rectangle {
            color: "#bebfc0"
            anchors.fill: idGroupNameText
            anchors.topMargin: 5
        }

        Rectangle {
            color: "#bebfc0"
            anchors.top: idItemBackground.top
            anchors.bottom: idGroupNameText.bottom
            anchors.left: idGroupNameText.left
            anchors.right: idGroupNameText.right
            radius: 2 //10
        }

        Text {
            id: idGroupNameText
            text: qsTr("")
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.topMargin: 5
            bottomPadding: 5
            font.family: idFontBold.name
            font.pixelSize: 14
        }
    }

/*    GridView {
        id: idItemListView
        anchors.fill: idItemBackground
        anchors.topMargin: 30
        anchors.margins: 5
        cellWidth: 100
        cellHeight: 100
//        highlight: Rectangle { color: "#115d8b"}
        focus: true
        clip: true
        model: itemModel

        delegate: POS_Button {
            property variant modelData: model
            width: idItemListView.cellWidth - 5
            height: idItemListView.cellHeight - 5
            groupButton: false
            name: model.name
            price: model.price / settings.monetaryUnitFraction

            onClicked: {
                GridView.view.currentIndex = index
            }
        }

        onCurrentIndexChanged: {
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
        }
    }*/

   ListView {
        id: idItemListView
        anchors.fill: idItemBackground
        anchors.topMargin: 30
        anchors.margins: 5
        highlight: Rectangle { color: "#115d8b"}
        focus: true
        clip: true
        model: itemModel
        spacing: 5

        delegate: idDelegate
        /* POS_Button {
            property variant modelData: model
            width: idItemListView.cellWidth - 5
            height: idItemListView.cellHeight - 5
            groupButton: false
            name: model.name
            price: model.price / settings.monetaryUnitFraction

            onClicked: {
                ListView.view.currentIndex = index
            }
        }*/

        onCurrentIndexChanged: {
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
        }
    }

    Component {
        id: idDelegate

        Rectangle {
            id: idRectangleText
            width: idItemBackground.width
            height: idItemBackground.height / 15
            property variant modelData: model
            Text {
                text: model.name
                font.family: idFontBold.name
                anchors{
                    top: idRectangleText.top
                    left: idRectangleText.left
                    leftMargin: idItemBackground.width / 20
                    topMargin: idItemBackground.height / 60
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: idItemListView.currentIndex = index
            }
        }
    }
}
