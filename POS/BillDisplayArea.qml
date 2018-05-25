import QtQuick 2.7
import QtQuick.Controls 1.4

Item {
    id: idRoot
    width: 500
    height: 600

    state: "Payment"

    property int margin: 5
    property int itemDisplayCount: 10

    Rectangle {
        id: idBillBackground
        radius: 2  // 10
        color: "#e3e8ec"
        anchors.fill: parent
        border.color: "#d2d4d5"
        border.width: 1
    }

    Rectangle {
        anchors.top: idBillViewHeader.top
        anchors.bottom: idHeaderBackground.bottom
        anchors.left: idHeaderBackground.left
        anchors.right: idHeaderBackground.right
        radius: 2 //10
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ffffff" }
            GradientStop { position: 0.5; color: "#f0f3f5" }
            GradientStop { position: 1.0; color: "#e3e8ec" }
        }
    }

    Rectangle {
        id: idHeaderBackground
        anchors.fill: idBillViewHeader
        anchors.topMargin: idBillViewHeader.height/2
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#f0f3f5" }
            GradientStop { position: 1.0; color: "#e3e8ec" }
        }
    }

    Item {
        id: idBillViewHeader
        width: parent.width
        height: parent.height/10
//        anchors.topMargin: 5

        Rectangle {
            width: parent.width
            height: 1
            color: "#c9c9ca"
            anchors.bottom: parent.bottom
        }

     /*   Text {
            id: idKot
            text: qsTr("KOT")
            font.family: idFontBold.name
            font.bold: true
            font.pixelSize: 14
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width * 0.15
            anchors.left: parent.left
        }*/

        Text {
            id: idDescription
            text: qsTr("Description")
            font.family: idFontBold.name
            font.bold: true
            font.pixelSize: 14
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width * 0.34
            //anchors.left: idKot.right
            anchors.left: parent.left
        }

        Text {
            id: idQuantity
            text: qsTr("Quantity")
            font.family: idFontBold.name
            font.bold: true
            font.pixelSize: 14
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            width: parent.width * 0.15
            anchors.left: idDescription.right
        }

        Text {
            id: idUnitPrice
            text: qsTr("Price")
            font.family: idFontBold.name
            font.bold: true
            font.pixelSize: 14
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            width: parent.width * 0.15
            anchors.left: idQuantity.right
        }

        Text {
            id: idTotal
            text: qsTr("Total")
            font.family: idFontBold.name
            font.bold: true
            font.pixelSize: 14
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            width: parent.width * 0.2
            anchors.left: idUnitPrice.right
            rightPadding: 10
        }
    }

    /*
    BillDelegate {
        id: idHeader
        width: idRoot.width - idRoot.margin
        height: idRoot.height / 10
        name: "Name"
        quantity: "Qty"
        price: "Price"
        total: "Total"
        anchors.margins: idRoot.margin
    }*/

    ListView {
        id: idBillListView
        anchors.top: idBillViewHeader.bottom
        anchors.bottom: idBillSummaryDisplay.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        model: billItemsModel
//        anchors.margins: idRoot.margin
        clip: true

        delegate: BillDelegate {
            width: idBillListView.width //- idRoot.margin
            height: 40//idBillListView.height / idRoot.itemDisplayCount
//            color: (index === ListView.currentIndex) ? "#229edf" : "#f4f4f4f4"
            name: model.itemName
            quantity: model.count
            price: model.price / settings.monetaryUnitFraction
            total: model.total / settings.monetaryUnitFraction

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked item")
                    idBillListView.currentIndex = index
                }
            }
        }

        highlight: Rectangle {
            color: "#c7c9cc"
        }
    }

    Item {
        id: idBillSummaryDisplay
        width: parent.width
        height: parent.height/5
        anchors.bottom: parent.bottom


        Rectangle {
            anchors.fill: parent
            color: "yellow"
        }
    }

    Row {
        id: idUserEntryArea
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        width: parent.width
        clip: true

        Text {
            height: idEntryField.height
            text: "Quantity [* Item code]: "
            verticalAlignment: Text.AlignVCenter
        }

        TextField {
            id: idEntryField
            placeholderText: "Enter Quantity"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    ListModel {
        id: idListModel        
    }

    ListElement {
        id: idListElement
        property string name: "-"
        property string quantity: "-"
        property string price: "-"
        property string total: "-"
    }

//    function addItem(name, qty, price, total)
//    {
//        idListElement.name = name
//        idListElement.quantity = qty
//        idListElement.price = price
//        idListElement.total = total
//        idListModel.append(idListElement)
//    }

    /**
      * This function will return the quantity entered by user.
      * Also, clears the field upon returning the value.
      *
      */
    function getQuantity()
    {
        var value = ("" !== idEntryField.text) ? idEntryField.text : 1;
        idEntryField.text = ""
        return value;
    }

    states: [
        State {
            name: "Sales"
            PropertyChanges { target: idUserEntryArea; visible: true }
            PropertyChanges { target: idBillSummaryDisplay; visible: true }
        },
        State {
            name: "Payment"
            PropertyChanges { target: idUserEntryArea; visible: false }
            PropertyChanges { target: idBillSummaryDisplay; visible: false }
        }
    ]
}
