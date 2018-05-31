import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Item {
    id: idRoot
    width: 500; height: 500
    state: "Sales"

//    signal payClicked()

    Text {
        id: idTotal
        text: billManager.total / settings.monetaryUnitFraction
        color: "white"
        font.bold: true
        font.pixelSize: 20
    }

    BillDisplayArea {
        id: idBillArea
        width: (parent.width/2 < 500) ? parent.width/2 : 500

        anchors {
            left: parent.left
            top: parent.top
            bottom: idActionButtonArea.top
            margins: 10
        }

        Rectangle {
            id: idSearchItem
            width: idBillArea.width
            height: 50
            anchors.left: idBillArea.left
            anchors.right: idBillArea.right
            anchors.bottom: idBillArea.bottom
            //color: "#c7c9cc"

            Text {
                id: idTxtCode
                width: idBillArea.width/3
                text: qsTr("Enter Item Code")
                font.family: idFontBold.name
                font.bold: true
                font.pixelSize: 14
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.left: idSearchItem.left
                anchors.leftMargin: 5
            }

            TextField {
                id: idTxtFieldCode
                width: idBillArea.width/3
                height: idSearchItem.height / 2
                anchors.left: idTxtCode.right
                anchors.leftMargin: 5
                anchors.top: idSearchItem.top
                anchors.topMargin: 10
            }

            POS_FunctionButton {
                id: idSerachButton
                text: "Add to Bill"
                width: idSearchItem.width / 4
                height: idSearchItem.height / 2
                anchors.left: idTxtFieldCode.right
                anchors.right: idSearchItem.right
                anchors.leftMargin: 5
                anchors.top: idSearchItem.top
                anchors.topMargin: 10
            }
        }
    }

    GroupDisplayArea {
        id: idGroupDisplayArea
       // anchors.bottom: idActionButtonArea.top
        anchors.top: parent.top
        anchors.left: idBillArea.right
        anchors.right: parent.right
        anchors.margins: 10
        height: parent.height * 0.25
        onGroupChanged: {
            console.log("group is", groupName)
            idItemDisplayArea.groupNameDisplay = groupName
        }
    }

    ItemDisplayArea {
        id: idItemDisplayArea
        anchors.bottom: idActionButtonArea.top
        anchors.top: idGroupDisplayArea.bottom
        anchors.left: idBillArea.right
        anchors.right: parent.right
        //anchors.top: parent.top
        anchors.margins: 10

        onItemClicked: {
            var quantity = idBillArea.getQuantity()
            billManager.addItem(itemModel.itemCode, itemUnitsModel.itemUnitCode, quantity);
        }

        onError: {
            idPopup.text = message
            idPopup.open()
        }
    }

    ActionButtonArea {
        id: idActionButtonArea
        height: parent.height * 0.11
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        //anchors.margins: 5
        anchors.bottomMargin: 5

        onSave: {
            var resultMap = billManager.saveBill();
            console.log(resultMap.status, resultMap.billNumber, resultMap.message)

            if (resultMap.status)
            {
                var printResultMap = printManager.printBill(resultMap.billNumber);
            }
        }

        onClear: {
            settings.subtotal = 0.0;
            settings.sgst = 0.0;
            settings.cgst = 0.0;
            settings.total = 0.0;
            settings.billNo = 0;

            var resultMap = billManager.clear();
            console.log(resultMap.status, resultMap.message)
        }

        onPay: {
//            idRoot.payClicked();
//            idRoot.state = "Payment"
            printManager.printBill(3)
        }
    }

    Popup {
        id: idPopup
        width: parent.width/2
        height: parent.height/2
        x: 200; y: 200
        focus: true
        modal: true

        property alias text: idPopupMessage.text

        ColumnLayout {
            anchors.fill: parent

            Text {
                id: idPopupMessage
                text: qsTr("text")
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
            }

            MouseArea {
                anchors.fill: parent
                onClicked: idPopup.close()
            }
        }

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }


    PayModesDisplayArea {
        id: idPayModesDisplayArea
        anchors.fill: idItemDisplayArea
    }

    states: [
        State {
            name: "Sales"
            PropertyChanges { target: idPayModesDisplayArea; visible: false }
            PropertyChanges { target: idItemDisplayArea; visible: true }
            PropertyChanges { target: idGroupDisplayArea; visible: true }
//            PropertyChanges { target: idBillArea; state: "Sales" }
        },
        State {
            name: "Payment"
            PropertyChanges { target: idPayModesDisplayArea; visible: true }
            PropertyChanges { target: idItemDisplayArea; visible: false }
            PropertyChanges { target: idGroupDisplayArea; visible: false }
            PropertyChanges { target: idBillArea; state: "Payment" }
        }
    ]

}
