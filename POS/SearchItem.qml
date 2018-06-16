import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: idBillArea
    width: 500
    height: 100

    Rectangle {
        id: idSearchItem
        width: idBillArea.width
        height: 50
        anchors.left: idBillArea.left
        anchors.right: idBillArea.right
        anchors.bottom: idBillArea.bottom

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

       /* TextField {
            id: idTxtFieldCode
            width: idBillArea.width / 3
            height: idSearchItem.height / 2
            anchors.left: idTxtCode.right
            anchors.leftMargin: 5
            anchors.top: idSearchItem.top
            anchors.topMargin: 10
            onTextChanged: {
                taxMaster.applyfilter(text);
                console.log(taxMaster.namefilter)
                idTxtFieldCode.text = taxMaster.namefilter
            }
        }*/

        ComboBox {
            id: idTxtFieldCode
            width: idBillArea.width / 3
            height: idSearchItem.height / 2
            anchors.left: idTxtCode.right
            anchors.leftMargin: 5
            anchors.top: idSearchItem.top
            anchors.topMargin: 10
            editable: true
            model: taxMaster
            textRole: "Name"
            z:2
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
            onClicked: idTxtFieldCode.text ="";
        }
    }
}
