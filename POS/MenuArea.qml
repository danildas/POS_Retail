import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: idRoot
    width: 500
    height: 600

    property int horizontalItemCount: 4
    property int verticalItemCount: 2
    property int margin: 3
    property color lightFontColor: "#222"
    property color darkFontColor: "white"

//    signal itemClicked(string name, string quantity, string price, string total)
    signal itemClicked()
    signal error(string message)

    Rectangle {
        id: idBackground
        anchors.fill: parent
        color: "#c7c9cc"
    }

    GridView {
        id: idGroupListView
        width: parent.width
        height: parent.height / 3
        cellWidth: (width / horizontalItemCount)
        cellHeight: (height/ verticalItemCount)

        model: groupModel
        focus: true
        highlight: Rectangle { color: "#c7c9cc"}
        anchors.margins: idRoot.margin
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true

        delegate: Button {
            id: idGroupListButton
            property variant modelData: model
            width: (idGroupListView.width / horizontalItemCount) - idRoot.margin
            height: (idGroupListView.height / verticalItemCount) - idRoot.margin
            text: model.name

            onClicked: {
                console.log("clicked handler")
                GridView.view.currentIndex = index
            }

            Component.onCompleted: console.log("completed")
        }

        onCurrentIndexChanged: {
            console.log("group index changed handler")
            itemModel.groupCode = currentItem.modelData.code
            subGroupModel.groupCode = currentItem.modelData.code
//            idSubGroupListView.currentIndex = 0
        }
    }

    ListView {
        id: idSubGroupListView
        visible: false//isSubGroupVisible
//        anchors.fill: idSubGroupBackground
        model: subGroupModel
        focus: true
        highlight: Rectangle { color: "#c7c9cc"}

        header: Item {
            id: idSubGroupHeaderItem
            width: idSubGroupListView.width
            height: idSubGroupListView.height * 0.1
            baselineOffset: idSubGroupHeadertext.y + idSubGroupHeadertext.baselineOffset

            Text {
                id: idSubGroupHeadertext
                text: "SUB CATEGORY"
                color: "lightgrey"
                font.pixelSize: idSubGroupHeaderItem.height * 0.25
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }

        delegate: Button {
            id: idSubGroupListButton
            property variant modelData: model
            width: idGroupListView.width
            height: idGroupListView.height * 0.1
            text: name

            onClicked: {
                console.log("clicked handler")
                ListView.view.currentIndex = index
            }
        }

        onCurrentIndexChanged: {
            console.log("subgroup index changed handler")
            itemModel.subGroupCode = currentItem.modelData.code
            idItemListView.currentIndex = 0
        }
    }


    GridView {
        id: idItemListView
        width: parent.width
        height: parent.height / 3
        cellWidth: (width / horizontalItemCount)
        cellHeight: (height/ verticalItemCount)

        model: itemModel
        focus: true
        highlight: Rectangle { color: "#c7c9cc"}
        anchors.margins: idRoot.margin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: idGroupListView.bottom
        clip: true

        delegate: Button {
            id: idItemListButton
            property variant modelData: model
            width: (idItemListView.width / horizontalItemCount) - idRoot.margin
            height: (idItemListView.height / verticalItemCount) - idRoot.margin
            text: name

            onClicked: {
                console.log("clicked handler")
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
            itemUnitsModel.itemUnitCode = "1"
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

    /* Below connection is needed, as on group index change, subgroup current index
        does not change, it  remains 0, so explicitly call the function to update model*/
    Component.onCompleted: {
        subGroupModel.onGroupCodeChanged.connect(idSubGroupListView.onCurrentIndexChanged)
    }

    ListModel {
        id: idlistmodel
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
        ListElement {
            name: "Bill as"
            number: "555 3264"
        }
        ListElement {
            name: "John dd"
            number: "555 8426"
        }
        ListElement {
            name: "Sam dds"
            number: "555 0473"
        }
        ListElement {
            name: "Bill Smith"
            number: "555 3264"
        }
        ListElement {
            name: "John Brown"
            number: "555 8426"
        }
        ListElement {
            name: "Sam Wise"
            number: "555 0473"
        }
    }
}
