import QtQuick 2.7

/*
Item {
    id: idRoot
    width: 200
    height: 100

    property alias name: idName.text
    property alias quantity: idQuantity.text
    property alias price: idPrice.text
    property alias total: idTotal.text
    property alias color: idBackground.color

    Rectangle {
        id: idBackground
        color: "transparent"
        anchors.fill: parent
        opacity: 0.5
    }

    Row {
        width: parent.width - 10
        height: parent.height
        spacing: parent.width * 0.01
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: idName
            text: "-"
            verticalAlignment: Text.AlignVCenter
            width: parent.width * 0.4
            height: parent.height
        }

        Text {
            id: idQuantity
            text: "-"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width * 0.13
            height: parent.height
        }

        Text {
            id: idPrice
            text: "-"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            width: parent.width * 0.21
            height: parent.height
        }

        Text {
            id: idTotal
            text: "-"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            width: parent.width * 0.23
            height: parent.height
        }
    }
} */

Item {
    id: idBillViewHeader
    width: parent.width//200//
    height: 200 //100//childrenRect.height
    anchors.margins: 5

    //property alias kot: idKot.text
    property alias name: idDescription.text
    property alias quantity: idQuantity.text
    property alias price: idUnitPrice.text
    property alias total: idTotal.text
//    property alias color: idBackground.color

    Rectangle {
        id: idBackground
        anchors.fill: parent
        color: "#f4f4f4f4"
        opacity: 0.2
    }

    Rectangle {
        width: parent.width
        height: 1
        color: "#f6f6f6"
        anchors.bottom: parent.bottom
    }

   /* Text {
        id: idKot
        text: qsTr("-")
        color: "black"
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
        text: qsTr("-")
        color: "black"
        font.family: idFontBold.name
        font.bold: true
        font.pixelSize: 14
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        width: parent.width * 0.34
        elide: Text.ElideRight
        //anchors.left: idKot.right
        anchors.left: parent.left
        clip: true
    }

    Text {
        id: idQuantity
        text: qsTr("-")
        color: "black"
        font.family: idFontBold.name
        font.bold: true
        font.pixelSize: 14
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        width: parent.width * 0.15
        anchors.left: idDescription.right
        rightPadding: 5
    }

    Text {
        id: idUnitPrice
        text: qsTr("-")
        color: "black"
        font.family: idFontBold.name
        font.bold: true
        font.pixelSize: 14
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        width: parent.width * 0.15
        anchors.left: idQuantity.right
        rightPadding: 5
    }

    Text {
        id: idTotal
        text: qsTr("-")
        color: "black"
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
