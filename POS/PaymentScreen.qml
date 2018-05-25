import QtQuick 2.7
import QtQuick.Controls 1.4

Item {
    id: idRoot
    width: 500; height: 500

    signal backClicked()

    Rectangle {
        anchors.fill: idBillListView
        color: "#ffffff"
        border.color: "#d2d4d5"
        border.width: 1
        radius: 10
        anchors.topMargin: -50
    }

    BillDisplayArea {
        id: idBillArea
        width: (parent.width/2 < 500) ? parent.width/2 : 500
        height: parent.height *3/5

        anchors {
            left: parent.left
            top: parent.top
            margins: 10
        }
    }

    ListView {
        id: idBillListView
        anchors.top: idBillArea.bottom
        anchors.bottom: parent.bottom
        anchors.left: idBillArea.left
        anchors.right: idBillArea.right
        anchors.bottomMargin: 10
        anchors.topMargin: 5
        model: billItemsModel
        clip: true

        delegate: Item {
            id: idBillViewHeader

            anchors.margins: 5

            width: idBillListView.width
            height: 40
//            name: model.itemName
//            quantity: model.count
//            price: model.price / settings.monetaryUnitFraction
//            total: model.total / settings.monetaryUnitFraction

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
                color: "#dee0e1"
                anchors.bottom: parent.bottom
            }

         /*   Text {
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
               // anchors.left: idKot.right
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

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked item")
                    idBillListView.currentIndex = index
                }
            }
        }

//        delegate: BillDelegate {
//            width: idBillListView.width
//            height: 40
//            name: model.itemName
//            quantity: model.count
//            price: model.price / settings.monetaryUnitFraction
//            total: model.total / settings.monetaryUnitFraction

//            MouseArea {
//                anchors.fill: parent
//                onClicked: {
//                    console.log("clicked item")
//                    idBillListView.currentIndex = index
//                }
//            }
//        }

//        highlight: Rectangle {
//            color: "#229edf"
//        }
    }

    POS_FunctionButton {
        width: 100
        height: 50
        text: "Back"
        onClicked: {
            idRoot.backClicked()
        }

        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
    }

    Item {
        id: idBillSummaryBg
        anchors.left: idBillArea.right
        anchors.top: idBillArea.top
        anchors.leftMargin: 10
        width: parent.width / 4
        height: childrenRect.height

        Grid {
            columns: 2
            //rows: 2
            columnSpacing: 5
            rowSpacing: 5
            height: childrenRect.height

            Text {
                id: idDiscountTitle
                text: qsTr("Sub Total :")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                id: idDiscountText
                text: qsTr(" - ")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                id: idTaxTitle
                text: qsTr("Tax :")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                id: idTaxText
                text: qsTr(" - ")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                text: qsTr("Others :")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                text: qsTr(" - ")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                text: qsTr("Discount :")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                text: qsTr(" - ")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                text: qsTr("TOTAL :")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                text: qsTr(" - ")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                text: qsTr("Balance Due :")
                font.family: idFont.name
                font.pixelSize: 16
            }

            Text {
                text: qsTr(" - ")
                font.family: idFont.name
                font.pixelSize: 16
            }
        }
    }

    PayModesDisplayArea {
        anchors.left: idBillSummaryBg.right
        anchors.right: parent.right
        anchors.top: idBillSummaryBg.top
        anchors.bottom: idBillArea.bottom
        anchors.rightMargin: 10
//        anchors.margins: 10
//        anchors.bottomMargin: 0
    }

//    PayModesDisplayArea {
//        anchors.left: idBillArea.right
//        anchors.right: parent.right
//        anchors.top: idBillSummaryBg.bottom
//        anchors.bottom: idBillArea.bottom
//        anchors.margins: 10
//        anchors.bottomMargin: 0
//    }

    /*Item {
        id: idKeypadBg
        anchors.left: idBillArea.right
        anchors.top: idBillArea.top
        anchors.bottom: idBillArea.bottom
        anchors.leftMargin: 10

        width: parent.width / 4
//        height: parent.height / 2

        Column {
            spacing: 4

            Text {
                id: idTenderedTitle
                text: qsTr("Tendered Amount")
                font.family: idFont.name
                font.pixelSize: 16
                width: idKeypadBg.width
                height: idKeypadBg.height / 6 - 18
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
            }

            TextField {
                id: idTenderedAmount
                placeholderText: qsTr("Enter amount")
                width: idKeypadBg.width
                height: idKeypadBg.height / 6
                horizontalAlignment: Text.AlignRight
                font.family: idFontBold.name
                font.pixelSize: 16
            }

            Grid {
                rows: 4
                columns: 3
                columnSpacing: 3
                rowSpacing: 3

                POS_KeypadButton {
                    text: "7"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "7"
                    }
                }

                POS_KeypadButton {
                    text: "8"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "8"
                    }
                }

                POS_KeypadButton {
                    text: "9"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "9"
                    }
                }

                POS_KeypadButton {
                    text: "4"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "4"
                    }
                }

                POS_KeypadButton {
                    text: "5"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "5"
                    }
                }

                POS_KeypadButton {
                    text: "6"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "6"
                    }
                }

                POS_KeypadButton {
                    text: "3"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "3"
                    }
                }

                POS_KeypadButton {
                    text: "2"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "2"
                    }
                }

                POS_KeypadButton {
                    text: "1"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "1"
                    }
                }

                POS_KeypadButton {
                    text: "C"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text.slice(0, idTenderedAmount.text.length-1)
                    }

                    onPressAndHold: {
                        idTenderedAmount.text = ""
                    }
                }

                POS_KeypadButton {
                    text: "0"
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        idTenderedAmount.text = idTenderedAmount.text + "0"
                    }
                }

                POS_KeypadButton {
                    text: "."
                    width: idKeypadBg.width / 3 - 2
                    height: idKeypadBg.height / 6
                    onClicked: {
                        if (-1 === idTenderedAmount.text.indexOf("."))
                        {
                            idTenderedAmount.text = idTenderedAmount.text + "."
                        }
                    }
                }
            }
        }
    }*/
}
