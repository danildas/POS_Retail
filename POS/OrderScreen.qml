import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: idRootRect

    property color lightFontColor: "#222"
    property color darkFontColor: "white"
    property bool isSubGroupVisible: false
    property double appMenuWidthPercent: 0.08
    property double groupWidthPercent: 0.125
    property double itemWidthPercent: 0.37
    property double optionWidthPercent: 0.16875

    anchors.fill: parent


    Gradient {
        id: idSimpleGradient
        GradientStop { position: 1.0; color: "black"}
        GradientStop { position: 1.0; color: "black"}
    }

    Gradient {
        id: idOrderGradient
        GradientStop { position: 0.0; color: "#27acbb"}
        GradientStop { position: 0.5; color: "#27acbb"}
        GradientStop { position: 1.0; color: "#1fcba6"}
    }

    gradient: idSimpleGradient


    Rectangle {
        id: idMenuBackground
        color: "#464541"
        width: parent.width * appMenuWidthPercent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    DropShadow {
        anchors.fill: idMenuBackground
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: idMenuBackground
    }

    ListView {
        id: idMenuListView
        anchors.fill: idMenuBackground

        model: ListModel {
            ListElement { name: "Home" }
            ListElement { name: "Order" }
            ListElement { name: "Report" }
            ListElement { name: "Settings" }
            ListElement { name: "Exit" }
        }

        highlight: Rectangle { color: "#24b4b2"}
        delegate: Button {
            id: idMenuButton
            property variant modelData: model
            width: idMenuListView.width
            height: idMenuListView.height * 0.08
            text: name

            style: GroupButtonStyle {
                fontColor: idRootRect.darkFontColor
            }

            onClicked: {
                console.log("clicked handler")
                ListView.view.currentIndex = index
            }
        }

        onCurrentIndexChanged: {
            if (1 === currentIndex) {
                idRootRect.gradient = idOrderGradient
            }
            else {
                idRootRect.gradient = idSimpleGradient
            }
        }
    }

    Rectangle {
        id: idGroupBackground
        width: parent.width * groupWidthPercent
        //color: "#9aa1a1"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#47494c" }
            GradientStop { position: 0.0; color: "#c7c9cc" }
        }

        //opacity: 0.2
        anchors.top: parent.top
        anchors.left: idMenuListView.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: parent.width * 0.01
        anchors.topMargin: 50
        anchors.bottomMargin: 10
    }

    DropShadow {
        anchors.fill: idGroupBackground
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: idGroupBackground
    }

    ListView {
        id: idGroupListView
        anchors.fill: idGroupBackground
        model: groupModel
        focus: true
        highlight: Rectangle { color: "#c7c9cc"}
        header: Item {
            id: idGroupHeaderItem
            width: idGroupListView.width
            height: idGroupListView.height * 0.1
            baselineOffset: idGroupHeadertext.y + idGroupHeadertext.baselineOffset

            Text {
                id: idGroupHeadertext
                text: "CATEGORY"
                color: "lightgrey"
                font.pixelSize: idGroupHeaderItem.height * 0.25
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }

        delegate: Button {
            id: idGroupListButton
            property variant modelData: model
            width: idGroupListView.width
            height: idGroupListView.height * 0.1
            text: name

            style: GroupButtonStyle {
                fontColor: idRootRect.darkFontColor
                pressed: idGroupListButton.ListView.isCurrentItem ? true : false
            }            

            onClicked: {
                console.log("clicked handler")
                ListView.view.currentIndex = index
            }            
        }

        onCurrentIndexChanged: {
            console.log("group index changed handler")
            itemModel.groupCode = currentItem.modelData.code
            subGroupModel.groupCode = currentItem.modelData.code
            idSubGroupListView.currentIndex = 0
        }
    }

    Rectangle {
        id: idSubGroupBackground
        visible: isSubGroupVisible
        width: parent.width/4
        color: "#9aa1a1"
        opacity: 0.4
        anchors.top: parent.top
        anchors.left: idGroupListView.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: parent.width * 0.01
        anchors.topMargin: 50
        anchors.bottomMargin: 10
    }

    ListView {
        id: idSubGroupListView
        visible: isSubGroupVisible
        anchors.fill: idSubGroupBackground
        model: subGroupModel
        focus: true
        highlight: Rectangle { color: "#c7c9cc" } //  #115d8b"

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

            style: GroupButtonStyle {
                fontColor: idRootRect.darkFontColor
                pressed: idSubGroupListButton.ListView.isCurrentItem ? true : false
            }

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

    Rectangle {
        id: idItemBackground
        width: parent.width * itemWidthPercent
        color: "#9aa1a1"
        opacity: 0.5
        anchors.top: parent.top
        anchors.left: isSubGroupVisible ? idSubGroupListView.right : idGroupListView.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: parent.width * 0.01
        anchors.topMargin: 50
        anchors.bottomMargin: 10
    }

    ListView {
        id: idItemListView
        anchors.fill: idItemBackground
        model: itemModel
        focus: true
        highlight: Rectangle { color: "#c7c9cc"} //#115d8b

        header: Item {
            id: idItemHeaderItem
            width: idItemListView.width
            height: idItemListView.height * 0.1
            baselineOffset: idItemHeadertext.y + idItemHeadertext.baselineOffset

            Text {
                id: idItemHeadertext
                text: "ITEMS"
                color: "lightgrey"
                font.pixelSize: idItemHeaderItem.height * 0.25
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }

        delegate: Button {
            id: idItemListButton
            property variant modelData: model
            width: idItemListView.width
            height: idItemListView.height * 0.1
            text: name

            style: GroupButtonStyle {
                fontColor: idRootRect.darkFontColor
                //pressed: idSubGroupListButton.ListView.isCurrentItem ? true : false
            }

            onClicked: {
                console.log("clicked handler")
                ListView.view.currentIndex = index
            }
        }

        onCurrentIndexChanged: {
            console.log("index changed handler")
            //itemModel.subGroupCode = currentItem.modelData.code
            itemModel.itemCode = currentItem.modelData.code
            itemUnitsModel.itemCode = currentItem.modelData.code
            itemUnitsModel.itemUnitCode = ""
        }
    }

    /* Below connection is needed, as on group index change, subgroup current index
        does not change, it  remains 0, so explicitly call the function to update model*/
    Component.onCompleted: {
        subGroupModel.onGroupCodeChanged.connect(idSubGroupListView.onCurrentIndexChanged)
    }

    Rectangle {
        id: idOptionBackground
        width: parent.width * optionWidthPercent
        color: "#9aa1a1"
        opacity: 0.5
        anchors.top: parent.top
        anchors.left: idItemListView.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: parent.width * 0.01
        anchors.topMargin: 50
        anchors.bottomMargin: 10

        ListView {
            id: idItemUnitsListView
            anchors.fill: idOptionBackground
            model: itemUnitsModel
            focus: true
            highlight: Rectangle { color: "#115d8b"}

            header: Item {
                id: idItemUnitHeaderItem
                width: idItemUnitsListView.width
                height: idItemUnitsListView.height * 0.1
                baselineOffset: idItemUnitHeadertext.y + idItemUnitHeadertext.baselineOffset

                Text {
                    id: idItemUnitHeadertext
                    text: "ITEM UNITS"
                    color: "lightgrey"
                    font.pixelSize: idItemUnitHeaderItem.height * 0.25
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
            }

            delegate: CheckBox {
                id: idItemUnitListCheckBox
                property variant modelData: model
                width: idItemUnitsListView.width
                height: idItemUnitsListView.height * 0.1
                text: name

//                style: GroupButtonStyle {
//                    fontColor: idRootRect.darkFontColor
//                    //pressed: idSubGroupListButton.ListView.isCurrentItem ? true : false
//                }

                onClicked: {
                    console.log("clicked handler")
                    ListView.view.currentIndex = index
                }
            }

            onCurrentIndexChanged: {
                console.log("index changed handler")
                //itemModel.subGroupCode = currentItem.modelData.code
                itemUnitsModel.itemUnitCode = currentItem.modelData.code
            }
        }
    }

    Button {
        id: idAddToOrderButton
        anchors.horizontalCenter: idOptionBackground.horizontalCenter
        anchors.bottom: idOptionBackground.bottom
        anchors.bottomMargin: idOptionBackground.height * 0.01
        width: idOptionBackground.width - idOptionBackground.width *0.1
        height: idOptionBackground.height * 0.1

        style: ButtonStyle {
            property bool pressed: idAddToOrderButton.pressed
            background: Rectangle {
                color: pressed? "#11518b" :"#115d8b"
                radius: idAddToOrderButton.width/2
            }

            label: Item {
                implicitWidth: row.implicitWidth
                implicitHeight: row.implicitHeight
                baselineOffset: row.y + idAddToOrderText.y + idAddToOrderText.baselineOffset

                Row {
                    id: row
                    anchors.left: control.text.length === 0 ? undefined : parent.left
                    anchors.leftMargin: control.text.length === 0 ? 0 : textSingleton.implicitHeight - 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: control.text.length === 0 ? parent.horizontalCenter : undefined

                    Text {
                        id: idAddToOrderText
                        text: "Add to Order"
                        color: "white"
                        font.pixelSize: control.height * 0.25
                        //font.family:
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        onClicked: billManager.addItemToOrder()
    }

    DropShadow {
        anchors.fill: idAddToOrderButton
        horizontalOffset: 1
        verticalOffset: 1
        radius: 5.0
        samples: 10
        color: "#80000000"
        source: idAddToOrderButton
    }

    Rectangle {
        id: idBillBackground
        color: "white"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: idOptionBackground.right
        anchors.right: parent.right
        anchors.leftMargin: parent.width * 0.01
        anchors.rightMargin: parent.width * 0.01
        anchors.topMargin: 50
        anchors.bottomMargin: 10
    }

    DropShadow {
        anchors.fill: idBillBackground
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: idBillBackground
    }

    Button {
        id: idPlaceOrderButton
        anchors.horizontalCenter: idBillBackground.horizontalCenter
        anchors.bottom: idBillBackground.bottom
        anchors.bottomMargin: idBillBackground.height * 0.01
        width: idBillBackground.width - idBillBackground.width *0.1
        height: idBillBackground.height * 0.1

        style: ButtonStyle {
            property bool pressed: idPlaceOrderButton.pressed
            background: Rectangle {
                color: pressed? "#11518b" :"#115d8b"
                radius: idPlaceOrderButton.width/2
            }

            label: Item {
                implicitWidth: row.implicitWidth
                implicitHeight: row.implicitHeight
                baselineOffset: row.y + idPlaceOrderText.y + idPlaceOrderText.baselineOffset

                Row {
                    id: row
                    anchors.left: control.text.length === 0 ? undefined : parent.left
                    anchors.leftMargin: control.text.length === 0 ? 0 : textSingleton.implicitHeight - 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: control.text.length === 0 ? parent.horizontalCenter : undefined

                    Text {
                        id: idPlaceOrderText
                        text: "Place Order"
                        color: "white"
                        font.pixelSize: control.height * 0.25
                        //font.family:
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: idPlaceOrderButton
        horizontalOffset: 1
        verticalOffset: 1
        radius: 5.0
        samples: 10
        color: "#80000000"
        source: idPlaceOrderButton
    }

}
