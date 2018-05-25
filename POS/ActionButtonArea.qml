import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: idRoot
    width: 500
    height: 200

    signal clear()
    signal save()
    signal pay()

    Row {
        anchors.centerIn: parent
        spacing: idRoot.width * 0.01

        POS_FunctionButton {
            text: "New"
            width: idRoot.width / 6.5
            height: idRoot.height
            onClicked: idRoot.clear()
        }

        POS_FunctionButton {
            text: "Clear"
            width: idRoot.width / 6.5
            height: idRoot.height
            onClicked: idRoot.clear()
        }

        POS_FunctionButton {
            text: "Order Lookup"
            width: idRoot.width / 6.5
            height: idRoot.height
        }

        POS_FunctionButton {
            text: "-"
            width: idRoot.width / 6.5
            height: idRoot.height
        }

        POS_FunctionButton {
            text: "Save"
            width: idRoot.width / 6.5
            height: idRoot.height
            onClicked: idRoot.save()
        }

        POS_FunctionButton {
            text: "Print Bill"
            width: idRoot.width / 6.5
            height: idRoot.height
            onClicked: idRoot.pay()  ///printManager.printBill(3)
        }
    }
}
