import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

Item {
    id: idWindow
    width: 500; height: 500
    state: "Settings"

    signal settingsSelected()
    signal backClicked()

    TabView {
        id: tabPages
        width: parent.width
        height: parent.height

        Tab {
            id: idGSTTab
            title: "Tax"

            Item {
                id: idItemTax
                width: parent.width
                height: parent.height
                anchors.top: parent.top

                Rectangle {
                    id: idRectangleTax
                    width: idItemTax.width
                    height: idItemTax.height/1.5
                    border.color: "#E3E8EC"
                    border.width: 2
                    radius: 5
                    anchors {
                        top: idItemTax.top
                        left: idItemTax.left
                        right: idItemTax.right
                        bottom: idItemTax.bottom
                        bottomMargin: 20
                        topMargin: 20
                        leftMargin: 10
                        rightMargin: 10
                    }

                        Text {
                            id: idtxtCGST
                            width: idRectangleTax.width/2
                            height: idRectangleTax.height/12
                            text: qsTr("CGST")
                            font.family: idFont.name
                            font.pixelSize: 15
                            anchors{
                                top: idRectangleTax.top
                                left: idRectangleTax.left
                                topMargin: 20
                                leftMargin: 50
                                 }
                             }

                        TextField {
                            id: idTxtFieldCGST
                            width: idRectangleTax.width/2
                            height: idRectangleTax.height/12
                            font.family: "Courier"
                            placeholderText: "CGST Percent"
                            readOnly: true
                            states: [
                                State {
                                    name: "CGST"
                                    PropertyChanges { target: idTxtFieldCGST; readOnly: false }
                                }]
                            anchors{
                                 top: idRectangleTax.top
                                 left: idtxtCGST.right
                                 right: idRectangleTax.right
                                 topMargin: 20
                                 rightMargin: 50
                                 }
                        }

                        Text {
                            id: idtxtSGST
                            width: idRectangleTax.width/2
                            height: idRectangleTax.height/12
                            text: qsTr("SGST")
                            font.family: idFont.name
                            font.pixelSize: 15
                            anchors{
                                top: idtxtCGST.bottom
                                left: idRectangleTax.left
                                topMargin: 10
                                leftMargin: 50
                                 }
                             }

                        TextField {
                            id: idTxtFieldSGST
                            width: idRectangleTax.width/2
                            height: idRectangleTax.height/12
                            font.family: "Courier"
                            placeholderText: "SGST Percent"
                            readOnly: true
                            states: [
                                State {
                                    name: "SGST"
                                    PropertyChanges { target: idTxtFieldSGST; readOnly: false }
                                }]
                            anchors {
                                top: idTxtFieldCGST.bottom
                                left: idtxtSGST.right
                                right: idRectangleTax.right
                                topMargin: 10
                                rightMargin: 50
                            }
                        }

                        Rectangle {
                            id: idRectangleInside
                            width: idRectangleTax.width
                            height: idRectangleTax.height/3
                            color: "#E3E8EC"
                            radius: 5
                            anchors {
                               bottom: idRectangleTax.bottom
                               left: idRectangleTax.left
                               right: idRectangleTax.right
                               leftMargin: 5
                               rightMargin: 5
                               bottomMargin: 5
                            }

                            Button {
                                id: idNewButton
                                anchors{
                                    top: idRectangleInside.top
                                    right: idEditButton.left
                                    topMargin: idRectangleInside.height/6
                                    rightMargin: idRectangleInside.width/8.5

                                }
                                background: POS_FunctionButton {
                                    text: "New"
                                    width: idRectangleInside.width/8
                                    height: idRectangleInside.height/3
                                    onClicked: {
                                        idTxtFieldSGST.state = "SGST"
                                        idTxtFieldCGST.state = "CGST"
                                    }
                                }
                            }
                            Button {
                                id: idEditButton
                                anchors{
                                    top: idRectangleInside.top
                                    right: idDeleteButton.left
                                    topMargin: idRectangleInside.height/6
                                   rightMargin: idRectangleInside.width/8.5
                                }
                                background: POS_FunctionButton {
                                    text: "Edit"
                                    width: idRectangleInside.width/8
                                    height: idRectangleInside.height/3
                                    onClicked: {
                                        idSaveButton.visible = false
                                        idUpdateButton.visible = true
                                    }
                                }
                            }
                            Button {
                                id: idDeleteButton
                                anchors{
                                    top: idRectangleInside.top
                                    right: idRectangleInside.right
                                    rightMargin: idRectangleInside.width/8
                                    topMargin: idRectangleInside.height/6
                                }
                                background: POS_FunctionButton {
                                    text: "Delete"
                                    width: idRectangleInside.width/8
                                    height: idRectangleInside.height/3
                                    onClicked: taxMaster.deleteTax()
                                }
                            }
                            Button {
                                id: idClearButton
                                anchors{
                                    top: idEditButton.bottom
                                    right: idSaveButton.left
                                    topMargin: idRectangleInside.height/4.5
                                    rightMargin: idRectangleInside.width/8.5
                                }
                                background: POS_FunctionButton {
                                    text: "Refresh"
                                    width: idRectangleInside.width/8
                                    height: idRectangleInside.height/3
                                    onClicked:  { taxMaster.getTax()
                                        idTxtFieldSGST.text = taxMaster.sgst
                                        idTxtFieldCGST.text = taxMaster.cgst
                                    }

                                }
                            }
                            Button {
                                id: idSaveButton
                                anchors{
                                    top: idDeleteButton.bottom
                                    right: idRectangleInside.right
                                    topMargin: idRectangleInside.height/4.5
                                    rightMargin: idRectangleInside.width/8
                                }
                                background: POS_FunctionButton {
                                    text: "Save"
                                    width: idRectangleInside.width/8
                                    height: idRectangleInside.height/3
                                    onClicked: { taxMaster.saveTax(idTxtFieldSGST.text,idTxtFieldCGST.text)
                                        idTxtFieldSGST.readOnly = true
                                        idTxtFieldCGST.readOnly = true
                                    }
                                }
                            }
                            Button {
                                id: idUpdateButton
                                anchors{
                                    top: idDeleteButton.bottom
                                    right: idRectangleInside.right
                                    topMargin: idRectangleInside.height/4.5
                                    rightMargin: idRectangleInside.width/8
                                }
                                visible: false
                                background: POS_FunctionButton {
                                    text: "Update"
                                    width: idRectangleInside.width/8
                                    height: idRectangleInside.height/3
                                    onClicked: {
                                        taxMaster.editTax(idTxtFieldSGST.text,idTxtFieldCGST.text)
                                        idSaveButton.visible = false
                                        idUpdateButton.visible = true
                                        idTxtFieldSGST.readOnly = true
                                        idTxtFieldCGST.readOnly = true
                                    }
                                }
                            }
                        }
                }
            }
        }
        Tab {
            id: idCostCenterTab
            title: "Cost Center"
        }

        Tab {
            id: idPOSMachineTab
            title: "POS Machine"
        }

        Tab {
            id: idPrinterTab
            title: "Printer"

            Item {
                id: idRoot
                width: parent.width
                height: parent.height
                anchors.top: parent.top

            Rectangle {
                id:idRectangle1
                width: idRoot.width
                height: idRoot.height/1.5
                border.color: "#E3E8EC"
                border.width: 2
                radius: 5
                anchors {
                    top: idRoot.top
                    left: idRoot.left
                    right: idRoot.right
                    bottom: idRoot.bottom
                    bottomMargin: 20
                    topMargin: 20
                    leftMargin: 10
                    rightMargin: 10
                }

                    Text {
                        id: idtxtPrinterName
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        text: qsTr("Printer Code")
                        font.family: idFont.name
                        font.pixelSize: 15
                        anchors{
                            top:idRectangle1.top
                            left: idRectangle1.left
                            topMargin: 20
                            leftMargin: 50
                             }
                         }

                    TextField{
                        id: idTxtFieldPrinterName
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        font.family: "Courier"
                        placeholderText: "Printer Code"
                        readOnly: true
                        states: [
                            State {
                                name: "PrinterName"
                                PropertyChanges { target: idTxtFieldPrinterName; readOnly: false }
                            }]
                        anchors{
                             top: idRectangle1.top
                             left: idtxtPrinterName.right
                             right: idRectangle1.right
                             topMargin: 20
                             rightMargin: 50
                             }
                    }

                    Text {
                        id: idtxtPrinterType
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        text: qsTr("Type of Printer")
                        font.family: idFont.name
                        font.pixelSize: 15
                        anchors{
                            top:idtxtPrinterName.bottom
                            left: idRectangle1.left
                            topMargin: 8
                            leftMargin: 50
                             }
                         }

                    ComboBox {
                        id: idComboBoxPrinterList
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        model: ListModel{
                            id: idcomboModel
                            ListElement{Text:"Ethernet"}
                            ListElement{Text:"Serial port"}
                        }
                        anchors{
                             top: idTxtFieldPrinterName.bottom
                             left: idtxtPrinterType.right
                             right: idRectangle1.right
                             topMargin: 8
                             rightMargin: 50
                             }
                        onCurrentTextChanged: {
                            if(idComboBoxPrinterList.currentText=="Serial port")
                            {
                                console.log("Serial port");
                                idTxtFieldBauderate.enabled  =true
                                idTxtFieldIp.enabled =false
                                idTxtFieldIp.text=""
                            }
                            else
                            {
                                console.log("Ethernet");
                                idTxtFieldIp.enabled  =true
                                idTxtFieldBauderate.enabled  =false
                                idTxtFieldBauderate.text=""
                            }
                        }
                    }

                    Text {
                        id: idtxtIp
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        text: qsTr("IP")
                        font.family: idFont.name
                        font.pixelSize: 15
                        anchors{
                            top:idtxtPrinterType.bottom
                            left: idRectangle1.left
                            topMargin: 5
                            leftMargin: 50
                        }
                    }

                    TextField{
                        id:idTxtFieldIp
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        font.family: "Courier"
                        placeholderText: "Ip"
                        readOnly: true
                        states: [
                            State {
                                name: "Ip"
                                PropertyChanges { target: idTxtFieldIp; readOnly: false }
                            }]
                        anchors{
                             top: idComboBoxPrinterList.bottom
                             left: idtxtIp.right
                             right: idRectangle1.right
                             topMargin: 5
                             rightMargin: 50
                             }
                    }

                    Text {
                        id: idtxtPortnumber
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        text: qsTr("Port Number")
                        font.family: idFont.name
                        font.pixelSize: 15
                        anchors{
                            top:idtxtIp.bottom
                            left: idRectangle1.left
                            topMargin: 5
                            leftMargin: 50
                        }
                    }

                    TextField{
                        id:idTxtFieldPortNumber
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        font.family: "Courier"
                        placeholderText: "Port Number"
                        readOnly: true
                        states: [
                            State {
                                name: "PortNumber"
                                PropertyChanges { target: idTxtFieldPortNumber; readOnly: false }
                            }
                        ]
                        anchors{
                             top: idTxtFieldIp.bottom
                             left: idtxtPortnumber.right
                             right: idRectangle1.right
                             topMargin: 5
                             rightMargin: 50
                             }
                    }

                    Text {
                        id: idtxtBauderate
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        text: qsTr("Baud rate")
                        font.family: idFont.name
                        font.pixelSize: 15
                        anchors{
                            top:idtxtPortnumber.bottom
                            left: idRectangle1.left
                            topMargin: 5
                            leftMargin: 50
                        }
                    }

                    TextField{
                        id:idTxtFieldBauderate
                        width: idRectangle1.width/2
                        height: idRectangle1.height/12
                        font.family: "Courier"
                        placeholderText: "Baud rate"
                        readOnly: true
                        states: [
                            State {
                                name: "Bauderate"
                                PropertyChanges { target: idTxtFieldBauderate; readOnly: false }
                            }
                        ]
                        anchors{
                             top: idTxtFieldPortNumber.bottom
                             left: idtxtBauderate.right
                             right: idRectangle1.right
                             topMargin: 5
                             rightMargin: 50
                             }
                    }

                    Rectangle {
                        id: idRectangleInside
                        width: idRectangle1.width
                        height: idRectangle1.height/3
                        color: "#E3E8EC"
                        radius: 5
                        anchors {
                           bottom: idRectangle1.bottom
                           left: idRectangle1.left
                           right: idRectangle1.right
                           leftMargin: 5
                           rightMargin: 5
                           bottomMargin: 5
                        }


                        Button {
                            id: idPrevButton
                            anchors{
                                top: idRectangleInside.top
                                left: idRectangleInside.left
                                topMargin: idRectangleInside.height/6
                                leftMargin: idRectangleInside.width/45
                            }
                            background: POS_FunctionButton {
                                width: idRectangleInside.width/8
                                height: idRectangleInside.height/3
                                text: "Prev"
                                onClicked: {
                                    console.log("Prev");
                                    printerMaster.previous();
                                    idTxtFieldPrinterName.text =printerMaster.Code
                                    idComboBoxPrinterList.currentIndex = (printerMaster.PrinterType === "Ethernet")? 0 : 1
                                    idTxtFieldIp.text = printerMaster.Ip
                                    idTxtFieldPortNumber.text = printerMaster.Port
                                    idTxtFieldBauderate.text = printerMaster.BaudRate

                                    if( printerMaster.PrinterType=="Ethernet")
                                    {
                                        idTxtFieldBauderate.enabled=false
                                        idTxtFieldIp.enabled=true
                                    }
                                    else
                                    {
                                        idTxtFieldBauderate.enabled=true
                                        idTxtFieldIp.enabled=false
                                    }
                                    idSaveButton.visible=true
                                    idUpdateButton.visible=false
                            }
                            }
                        }

                        Button {
                            id: idNextButton
                            anchors{
                                top: idRectangleInside.top
                                left: idPrevButton.right
                                topMargin: idRectangleInside.height/6
                                leftMargin: idRectangleInside.width/8.5
                            }
                            background: POS_FunctionButton {
                                text: "Next"
                                width: idRectangleInside.width/8
                                height: idRectangleInside.height/3
                                onClicked: {
                                    console.log("Next", printerMaster.PrinterType);
                                    printerMaster.next();

                                    idTxtFieldPrinterName.text =printerMaster.Code
                                    idComboBoxPrinterList.currentIndex = (printerMaster.PrinterType === "Ethernet")? 0 : 1
                                    idTxtFieldIp.text = printerMaster.Ip
                                    idTxtFieldPortNumber.text = printerMaster.Port
                                    idTxtFieldBauderate.text = printerMaster.BaudRate

                                    if( printerMaster.PrinterType=="Ethernet")
                                    {
                                        idTxtFieldBauderate.enabled=false
                                        idTxtFieldIp.enabled=true
                                    }
                                    else
                                    {
                                        idTxtFieldBauderate.enabled=true
                                        idTxtFieldIp.enabled=false
                                    }
                                    idSaveButton.visible=true
                                    idUpdateButton.visible=false
                                    idTxtFieldPrinterName.state = ""
                                    idTxtFieldBauderate.state = ""
                                    idTxtFieldIp.state = ""
                                    idTxtFieldPortNumber.state = ""
                            }
                            }
                        }
                        Button {
                            id: idNewButton
                            anchors{
                                top: idRectangleInside.top
                                //left: idNextButton.right
                                right: idEditButton.left
                                topMargin: idRectangleInside.height/6
                                rightMargin: idRectangleInside.width/8.5

                            }
                            background: POS_FunctionButton {
                                text: "New"
                                width: idRectangleInside.width/8
                                height: idRectangleInside.height/3
                                onClicked: {
                                        printerMaster.refresh()
                                    idTxtFieldPrinterName.state='PrinterName'
                                    idTxtFieldIp.state = 'Ip'
                                    idTxtFieldPortNumber.state = 'PortNumber'
                                    idTxtFieldBauderate.state = 'Bauderate'
                                    idTxtFieldIp.text =""
                                    idTxtFieldPrinterName.text = ""
                                    idTxtFieldPortNumber.text = ""
                                    idTxtFieldBauderate.text= ""
                                    idTxtFieldPrinterName.readOnly= false
                                    idTxtFieldIp.readOnly= false
                                    idTxtFieldPortNumber.readOnly= false
                                    idTxtFieldBauderate.readOnly= false
                                    idComboBoxPrinterList.enabled  = true
                                    idSaveButton.visible=true
                                    idUpdateButton.visible=false
                                }
                            }
                        }
                        Button {
                            id: idEditButton
                            anchors{
                                top: idRectangleInside.top
                                right: idDeleteButton.left
                                topMargin: idRectangleInside.height/6
                               rightMargin: idRectangleInside.width/8.5
                            }
                            background: POS_FunctionButton {
                                text: "Edit"
                                width: idRectangleInside.width/8
                                height: idRectangleInside.height/3
                                onClicked: {
                                    if(  idTxtFieldIp.text !=""|| idTxtFieldPortNumber.text !=""|| idTxtFieldBauderate.text!="")
                                    {
                                    console.log("Edit clicked")
                                    idTxtFieldBauderate.state = 'Bauderate'
                                    idTxtFieldIp.state = 'Ip'
                                    idTxtFieldPortNumber.state = 'PortNumber'

                                    idUpdateButton.visible= true
                                    idSaveButton.visible= false
                                    idComboBoxPrinterList.enabled  = false

                                    idTxtFieldIp.readOnly= false
                                    idTxtFieldPortNumber.readOnly= false
                                    idTxtFieldBauderate.readOnly= false
                                    }
                                    else
                                    {
                                       console.log("Textfields are empty!")
                                    }
                                }
                            }
                        }
                        Button {
                            id: idDeleteButton
                            anchors{
                                top: idRectangleInside.top
                                right: idRectangleInside.right
                                rightMargin: idRectangleInside.width/8
                                topMargin: idRectangleInside.height/6
                            }
                            background: POS_FunctionButton {
                                text: "Delete"
                                width: idRectangleInside.width/8
                                height: idRectangleInside.height/3
                                onClicked:{
                                    if(idTxtFieldPrinterName.text !="")
                                    {
                                    printerMaster.deletePrinter()
                                     printerMaster.refresh()
                                       printerMaster.previous()
                                        idTxtFieldPrinterName.text =printerMaster.Code
                                        idComboBoxPrinterList.currentIndex = (printerMaster.PrinterType === "Ethernet")? 0 : 1
                                        idTxtFieldIp.text = printerMaster.Ip
                                        idTxtFieldPortNumber.text = printerMaster.Port
                                        idTxtFieldBauderate.text = printerMaster.BaudRate

                                        if( printerMaster.PrinterType=="Ethernet")
                                        {
                                            idTxtFieldBauderate.enabled=false
                                            idTxtFieldIp.enabled=true
                                        }
                                        else
                                        {
                                            idTxtFieldBauderate.enabled=true
                                            idTxtFieldIp.enabled=false
                                        }
                                    }
                                    else
                                    {
                                       console.log("Textfields are empty!")
                                    }
                                }
                            }
                        }
                        Button {
                            id: idClearButton
                            anchors{
                                top: idEditButton.bottom
                                right: idSaveButton.left
                                topMargin: idRectangleInside.height/4.5
                                rightMargin: idRectangleInside.width/8.5
                            }
                            background: POS_FunctionButton {
                                text: "Clear"
                                width: idRectangleInside.width/8
                                height: idRectangleInside.height/3
                                onClicked: {
                                    printerMaster.refresh()
                                    idTxtFieldPrinterName.state='PrinterName'
                                    idTxtFieldIp.state = 'Ip'
                                    idTxtFieldPortNumber.state = 'PortNumber'
                                    idTxtFieldBauderate.state = 'Bauderate'
                                    idTxtFieldIp.text =""
                                    idTxtFieldPrinterName.text = ""
                                    idTxtFieldPortNumber.text = ""
                                    idTxtFieldBauderate.text= ""
                              }
                            }
                        }
                        Button {
                            id: idSaveButton
                            anchors{
                                top: idDeleteButton.bottom
                                right: idRectangleInside.right
                                topMargin: idRectangleInside.height/4.5
                                rightMargin: idRectangleInside.width/8
                            }
                            background: POS_FunctionButton {
                                text: "Save"
                                width: idRectangleInside.width/8
                                height: idRectangleInside.height/3
                                onClicked: {
                                    if(idTxtFieldPrinterName.text !="" && idTxtFieldPortNumber.text !="" || idTxtFieldIp.text !="" || idTxtFieldBauderate.text!="")
                                    {
                                    printerMaster.savePrinter(idTxtFieldPrinterName.text,idComboBoxPrinterList.currentText,idTxtFieldIp.text,idTxtFieldPortNumber.text,idTxtFieldBauderate.text)

                                        printerMaster.refresh();
                                        printerMaster.next();

                                        idTxtFieldPrinterName.text =printerMaster.Code
                                        idComboBoxPrinterList.currentIndex = (printerMaster.PrinterType === "Ethernet")? 0 : 1
                                        idTxtFieldIp.text = printerMaster.Ip
                                        idTxtFieldPortNumber.text = printerMaster.Port
                                        idTxtFieldBauderate.text = printerMaster.BaudRate

                                        if( printerMaster.PrinterType=="Ethernet")
                                        {
                                            idTxtFieldBauderate.enabled=false
                                            idTxtFieldIp.enabled=true
                                        }
                                        else
                                        {
                                            idTxtFieldBauderate.enabled=true
                                            idTxtFieldIp.enabled=false
                                        }
                                        idSaveButton.visible=true
                                        idUpdateButton.visible=false
                                        idComboBoxPrinterList.enabled=true
                                        idTxtFieldPrinterName.readOnly= true
                                            idTxtFieldIp.readOnly= true
                                            idTxtFieldPortNumber.readOnly= true
                                            idTxtFieldBauderate.readOnly= true
                                       }
                                    else
                                    {
                                        console.log("Textfields are empty!")
                                    }
                                }
                            }
                        }
                        Button {
                            id: idUpdateButton
                            anchors{
                                top: idDeleteButton.bottom
                                right: idRectangleInside.right
                                topMargin: idRectangleInside.height/4.5
                                rightMargin: idRectangleInside.width/8
                            }
                            visible: false
                            background: POS_FunctionButton {
                                text: "Update"
                                width: idRectangleInside.width/8
                                height: idRectangleInside.height/3
                                onClicked: {
                                    if(idTxtFieldPrinterName.text !="" || idTxtFieldIp.text !=""|| idTxtFieldPortNumber.text !=""|| idTxtFieldBauderate.text!="")
                                    {
                                    printerMaster.edit(idTxtFieldIp.text,idTxtFieldPortNumber.text,idTxtFieldBauderate.text)
                                    idSaveButton.visible=true
                                    idUpdateButton.visible=false
                                    idComboBoxPrinterList.enabled=true
                                        idTxtFieldIp.readOnly= true
                                        idTxtFieldPortNumber.readOnly= true
                                        idTxtFieldBauderate.readOnly= true
                                    printerMaster.refresh()
                                    }
                                }
                            }
                        }
                    }
            }
            }
        }

        Tab {
            id: idGeneralSettings
            title: "General Settings"
            onActiveFocusChanged: printerMaster.getCode()

            Item {
                id: idItemGeneralSettings
                width: parent.width
                height: parent.height
                anchors.top: parent.top

            Rectangle {
                id:idRectangleGeneralSettings
                width: idItemGeneralSettings.width
                height: idItemGeneralSettings.height/1.5
                border.color: "#E3E8EC"
                border.width: 2
                radius: 5
                anchors {
                    top: idItemGeneralSettings.top
                    left: idItemGeneralSettings.left
                    right: idItemGeneralSettings.right
                    bottom: idItemGeneralSettings.bottom
                    bottomMargin: 20
                    topMargin: 20
                    leftMargin: 10
                    rightMargin: 10
                }

                Text {
                    id: idtxtReceiptPrinter
                    width: idRectangleGeneralSettings.width/2
                    height: idRectangleGeneralSettings.height/12
                    text: qsTr("Receipt Printer")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top:idRectangleGeneralSettings.top
                        left: idRectangleGeneralSettings.left
                        topMargin: 20
                        leftMargin: 50
                         }
                     }
                ComboBox {
                    id: idComboBoxReceiptPrinter
                    width: idRectangleGeneralSettings.width/2
                    height: idRectangleGeneralSettings.height/12
                    model: printerMaster
                    textRole: "Code"
                    anchors{
                         top: idRectangleGeneralSettings.top
                         left: idtxtReceiptPrinter.right
                         right: idRectangleGeneralSettings.right
                         topMargin: 20
                         rightMargin: 50
                         }
                }
            }
            }
        }

        Tab {
            id: idUserRegister
            title: "User Register"
            onActiveFocusChanged: roleMaster.getRole();

            Item {
                id: idItemUserRegister
                width: parent.width
                height: parent.height
                anchors.top: parent.top

            Rectangle {
                id: idRectangleUserRegister
                width: idItemUserRegister.width
                height: idItemUserRegister.height/1.5
                border.color: "#E3E8EC"
                border.width: 2
                radius: 5
                anchors {
                    top: idItemUserRegister.top
                    left: idItemUserRegister.left
                    right: idItemUserRegister.right
                    bottom: idItemUserRegister.bottom
                    bottomMargin: 20
                    topMargin: 20
                    leftMargin: 10
                    rightMargin: 10
                }
                Text {
                    id: idtxtUserName
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    text: qsTr("User Name")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top:idRectangleUserRegister.top
                        left: idRectangleUserRegister.left
                        topMargin: 20
                        leftMargin: 50
                         }
                     }

                TextField{
                    id:idTxtFieldUserName
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    font.family: "Courier"
                    readOnly: true
                    placeholderText: "User Name"
                    anchors{
                         top: idRectangleUserRegister.top
                         left: idtxtUserName.right
                         right: idRectangleUserRegister.right
                         topMargin: 20
                         rightMargin: 50
                         }
                }

                Text {
                    id: idtxtRole
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    text: qsTr("Role")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top: idtxtUserName.bottom
                        left: idRectangleUserRegister.left
                        topMargin: 10
                        leftMargin: 50
                         }
                     }

                ComboBox {
                    id: idComboBoxRole
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    model: roleMaster
                    textRole: "Role"
                    visible: false
                    anchors{
                        top: idTxtFieldUserName.bottom
                        left: idtxtRole.right
                        right: idRectangleUserRegister.right
                        topMargin: 10
                        rightMargin: 50
                         }
                }

                TextField{
                    id: idTxtFieldRole
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    font.family: "Courier"
                    readOnly: true
                    placeholderText: "Role"
                    anchors{
                        top: idTxtFieldUserName.bottom
                        left: idtxtRole.right
                        right: idRectangleUserRegister.right
                        topMargin: 10
                        rightMargin: 50
                         }
                }

                Text {
                    id: idtxtPassword
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    text: qsTr("Password")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top: idtxtRole.bottom
                        left: idRectangleUserRegister.left
                        topMargin: 10
                        leftMargin: 50
                         }
                     }

                TextField{
                    id: idTxtFieldPassword
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    font.family: "Courier"
                    readOnly: true
                    placeholderText: "Password"
                    echoMode: TextInput.Password
                    anchors{
                         top: idComboBoxRole.bottom
                         left: idtxtPassword.right
                         right: idRectangleUserRegister.right
                         topMargin: 10
                         rightMargin: 50
                         }
                }

                Text {
                    id: idtxtConfirmPassword
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    text: qsTr("Confirm Password")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top: idtxtPassword.bottom
                        left: idRectangleUserRegister.left
                        topMargin: 10
                        leftMargin: 50
                         }
                     }

                TextField{
                    id: idTxtFieldConfirmPassword
                    width: idRectangleUserRegister.width/2
                    height: idRectangleUserRegister.height/12
                    font.family: "Courier"
                    readOnly: true
                    placeholderText: "Confirm Password"
                    echoMode: TextInput.Password
                    anchors{
                         top: idTxtFieldPassword.bottom
                         left: idtxtConfirmPassword.right
                         right: idRectangleUserRegister.right
                         topMargin: 10
                         rightMargin: 50
                         }
                }

                Rectangle {
                    id: idRectangleInsideUserRegister
                    width: idRectangleUserRegister.width
                    height: idRectangleUserRegister.height/3
                    color: "#E3E8EC"
                    radius: 5
                    anchors {
                       bottom: idRectangleUserRegister.bottom
                       left: idRectangleUserRegister.left
                       right: idRectangleUserRegister.right
                       leftMargin: 5
                       rightMargin: 5
                       bottomMargin: 5
                    }
                    Button {
                        id: idPrevButtonUser
                        anchors{
                            top: idRectangleInsideUserRegister.top
                            left: idRectangleInsideUserRegister.left
                            topMargin: idRectangleInsideUserRegister.height/6
                            leftMargin: idRectangleInsideUserRegister.width/45
                        }
                        background: POS_FunctionButton {
                            text: "Prev"
                            width: idRectangleInsideUserRegister.width/8
                            height: idRectangleInsideUserRegister.height/3
                            onClicked: { userMaster.previous()
                                idTxtFieldUserName.text= userMaster.UserName
                                idTxtFieldRole.text=userMaster.Role
                                idComboBoxRole.visible=false
                                idTxtFieldRole.visible=true
                                idTxtFieldUserName.readOnly= true
                                idTxtFieldPassword.readOnly= true
                                idTxtFieldConfirmPassword.readOnly= true
                                 idUpdateButtonUser.visible=false
                            }
                        }
                    }

                    Button {
                        id: idNextButtonUser
                        anchors{
                            top: idRectangleInsideUserRegister.top
                            left: idPrevButtonUser.right
                            topMargin: idRectangleInsideUserRegister.height/6
                            leftMargin: idRectangleInsideUserRegister.width/8.5
                        }
                        background: POS_FunctionButton {
                            text: "Next"
                            width: idRectangleInsideUserRegister.width/8
                            height: idRectangleInsideUserRegister.height/3
                            onClicked: {
                                userMaster.next()
                                //if(userMaster.UserName!="")
                                //{
                                idTxtFieldUserName.text= userMaster.UserName
                                idTxtFieldRole.text=userMaster.Role
                                idComboBoxRole.visible=false
                                idTxtFieldRole.visible=true
                                idTxtFieldUserName.readOnly= true
                                idTxtFieldPassword.readOnly= true
                                idTxtFieldConfirmPassword.readOnly= true
                                 idUpdateButtonUser.visible=false
                                //}
                            }
                        }
                    }
                    Button {
                        id: idNewButtonUser
                        anchors{
                            top: idRectangleInsideUserRegister.top
                            right: idEditButtonUser.left
                            topMargin: idRectangleInsideUserRegister.height/6
                            rightMargin: idRectangleInsideUserRegister.width/8.5
                        }
                        background: POS_FunctionButton {
                            text: "New"
                            width: idRectangleInsideUserRegister.width/8
                            height: idRectangleInsideUserRegister.height/3
                            onClicked: {
                                idTxtFieldUserName.readOnly= false
                                idTxtFieldPassword.readOnly= false
                                idTxtFieldConfirmPassword.readOnly= false
                                idTxtFieldUserName.text=""
                                idTxtFieldPassword.text=""
                                idTxtFieldConfirmPassword.text=""
                                idTxtFieldRole.visible=false
                                idComboBoxRole.visible=true
                                idUpdateButtonUser.visible=false
                            }
                        }
                    }
                    Button {
                        id: idEditButtonUser
                        anchors{
                            top: idRectangleInsideUserRegister.top
                            right: idDeleteButtonUser.left
                            topMargin: idRectangleInsideUserRegister.height/6
                           rightMargin: idRectangleInsideUserRegister.width/8.5
                        }
                        background: POS_FunctionButton {
                            text: "Edit"
                            width: idRectangleInsideUserRegister.width/8
                            height: idRectangleInsideUserRegister.height/3
                            onClicked: {
                                if(  idTxtFieldUserName.text !="")
                                {
                                idTxtFieldUserName.readOnly= false
                                idTxtFieldPassword.readOnly= false
                                idTxtFieldConfirmPassword.readOnly= false
                                idUpdateButtonUser.visible=true
                                idTxtFieldRole.visible=false
                                idComboBoxRole.visible=true
                                }
                                else
                                {
                                    console.log("Textfields are empty!")
                                }
                            }
                        }
                    }
                    Button {
                        id: idDeleteButtonUser
                        anchors{
                            top: idRectangleInsideUserRegister.top
                            right: idRectangleInsideUserRegister.right
                            rightMargin: idRectangleInsideUserRegister.width/8
                            topMargin: idRectangleInsideUserRegister.height/6
                        }
                        background: POS_FunctionButton {
                            text: "Delete"
                            width: idRectangleInsideUserRegister.width/8
                            height: idRectangleInsideUserRegister.height/3
                            onClicked: {
                                if(idTxtFieldUserName.text!="")
                                {
                                userMaster.deleteUser()
                                idTxtFieldUserName.text=""
                                idTxtFieldPassword.text=""
                                idTxtFieldConfirmPassword.text=""
                                    userMaster.refresh()
                                    userMaster.previous()
                                    idTxtFieldUserName.text= userMaster.UserName
                                    idTxtFieldRole.text=userMaster.Role
                                    idComboBoxRole.visible=false
                                    idTxtFieldRole.visible=true
                                }
                                else
                                {
                                console.log("Please select User!")
                                }
                            }
                        }
                    }
                    Button {
                        id: idClearButtonUser
                        anchors{
                            top: idEditButtonUser.bottom
                            right: idSaveButtonUser.left
                            topMargin: idRectangleInsideUserRegister.height/4.5
                            rightMargin: idRectangleInsideUserRegister.width/8.5
                        }
                        background: POS_FunctionButton {
                            text: "Clear"
                            width: idRectangleInsideUserRegister.width/8
                            height: idRectangleInsideUserRegister.height/3
                            onClicked: {
                                idTxtFieldUserName.text=""
                                idTxtFieldPassword.text=""
                                idTxtFieldConfirmPassword.text=""
                                idTxtFieldRole.visible=false
                                idComboBoxRole.visible=true
                                userMaster.refresh()
                            }
                        }
                    }
                    Button {
                        id: idSaveButtonUser
                        anchors{
                            top: idDeleteButtonUser.bottom
                            right: idRectangleInsideUserRegister.right
                            topMargin: idRectangleInsideUserRegister.height/4.5
                            rightMargin: idRectangleInsideUserRegister.width/8
                        }
                        background: POS_FunctionButton {
                            text: "Register"
                            width: idRectangleInsideUserRegister.width/8
                            height: idRectangleInsideUserRegister.height/3
                            onClicked:  { console.log("clicked")
                                if(idTxtFieldUserName.text!= "" && idTxtFieldPassword.text!="" && idTxtFieldConfirmPassword.text!="")
                                {
                                if(idTxtFieldPassword.text == idTxtFieldConfirmPassword.text)
                                {
                                    userMaster.saveUser(idTxtFieldUserName.text,idComboBoxRole.currentText,idTxtFieldPassword.text)
                                   /* idTxtFieldUserName.text= ""
                                    idTxtFieldPassword.text=""
                                    idTxtFieldConfirmPassword.text=""*/
                                    idComboBoxRole.visible=false
                                    idTxtFieldRole.visible=true
                                    userMaster.refresh()
                                    userMaster.next()
                                    idTxtFieldUserName.text= userMaster.UserName
                                    idTxtFieldRole.text=userMaster.Role
                                    idTxtFieldUserName.readOnly= true
                                    idTxtFieldPassword.readOnly= true
                                    idTxtFieldConfirmPassword.readOnly= true
                                }
                                else
                                {
                                    console.log("Password do not match")
                                }
                                }
                                else
                                {
                                    console.log("Textfields are empty!")
                                }
                            }
                        }
                    }
                    Button {
                        id: idUpdateButtonUser
                        anchors{
                            top: idDeleteButtonUser.bottom
                            right: idRectangleInsideUserRegister.right
                            topMargin: idRectangleInsideUserRegister.height/4.5
                            rightMargin: idRectangleInsideUserRegister.width/8
                        }
                        visible: false
                        background: POS_FunctionButton {
                            text: "Update"
                            width: idRectangleInsideUserRegister.width/8
                            height: idRectangleInsideUserRegister.height/3
                            onClicked: {
                                if(idTxtFieldUserName.text!= "" && idTxtFieldPassword.text!="" && idTxtFieldConfirmPassword.text!="")
                                {
                                if(idTxtFieldPassword.text == idTxtFieldConfirmPassword.text)
                                {
                                    userMaster.editUser(idTxtFieldUserName.text,idComboBoxRole.currentText,idTxtFieldPassword.text)
                                    idUpdateButtonUser.visible=false
                                    idTxtFieldPassword.text=""
                                    idTxtFieldConfirmPassword.text=""
                                    idTxtFieldUserName.readOnly= true
                                    idTxtFieldPassword.readOnly= true
                                    idTxtFieldConfirmPassword.readOnly= true
                                    idComboBoxRole.visible=false
                                    idTxtFieldRole.visible=true
                                    idComboBoxRole.currentIndex=0
                                    userMaster.refresh()
                                }
                                else
                                {
                                    console.log("Password do not match")
                                }
                            }
                            }
                        }
                    }
                }
            }
            }
        }

        Tab {
            id: idRole
            title: "Role"
            property int sale:0
            property int payment:0
            property int setting:0
            property int report:0
            Item {
                id: idItemRole
                width: parent.width
                height: parent.height
                anchors.top: parent.top

            Rectangle {
                id: idRectangleRole
                width: idItemRole.width
                height: idItemRole.height/1.5
                border.color: "#E3E8EC"
                border.width: 2
                radius: 5
                anchors {
                    top: idItemRole.top
                    left: idItemRole.left
                    right: idItemRole.right
                    bottom: idItemRole.bottom
                    bottomMargin: 20
                    topMargin: 20
                    leftMargin: 10
                    rightMargin: 10
                }

                Text {
                    id: idTxtRole
                    width: idRectangleRole.width/2
                    height: idRectangleRole.height/12
                    text: qsTr("Role")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top:idRectangleRole.top
                        left: idRectangleRole.left
                        topMargin: 20
                        leftMargin: 50
                         }
                     }

                TextField{
                    id: idTxtFieldRoleName
                    width: idRectangleRole.width/2
                    height: idRectangleRole.height/12
                    font.family: "Courier"
                    placeholderText: "Role"
                    readOnly: true
                    anchors{
                         top: idRectangleRole.top
                         left: idTxtRole.right
                         right: idRectangleRole.right
                         topMargin: 20
                         rightMargin: 50
                         }
                }

                Text {
                    id: idTxtCheckBoxSales
                    width: idRectangleRole.width/2
                    height: idRectangleRole.height/12
                    text: qsTr("Sales")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top: idTxtRole.bottom
                        left: idRectangleRole.left
                        leftMargin: 50
                        topMargin: 20
                         }
                     }

                CheckBox {
                    id: idCheckBoxSales
                   // text: qsTr("Sales")
                    checked: false
                    enabled: false
                    anchors {
                        top: idTxtFieldRoleName.bottom
                        left: idTxtCheckBoxSales.right
                        topMargin: 10
                    }
                }

                Text {
                    id: idTxtCheckBoxPayment
                    width: idRectangleRole.width/2
                    height: idRectangleRole.height/12
                    text: qsTr("Payment")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top: idTxtCheckBoxSales.bottom
                        left: idRectangleRole.left
                        leftMargin: 50
                        topMargin: 20
                         }
                     }

                CheckBox {
                    id: idCheckBoxPayment
                    //text: qsTr("Payment")
                    checked: false
                    enabled: false
                    anchors {
                        top: idCheckBoxSales.bottom
                        left: idTxtCheckBoxPayment.right
                        topMargin: 10
                    }
                }

                Text {
                    id: idTxtCheckBoxSettings
                    width: idRectangleRole.width/2
                    height: idRectangleRole.height/12
                    text: qsTr("Settings")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top: idTxtCheckBoxPayment.bottom
                        left: idRectangleRole.left
                        leftMargin: 50
                        topMargin: 10
                         }
                     }

                CheckBox {
                    id: idCheckBoxSettings
                    //text: qsTr("Settings")
                    checked: false
                    enabled: false
                    anchors {
                        top: idCheckBoxPayment.bottom
                        left: idTxtCheckBoxSettings.right
                        topMargin: 10
                    }
                }

                Text {
                    id: idTxtCheckBoxReports
                    width: idRectangleRole.width/2
                    height: idRectangleRole.height/12
                    text: qsTr("Reports")
                    font.family: idFont.name
                    font.pixelSize: 15
                    anchors{
                        top: idTxtCheckBoxSettings.bottom
                        left: idRectangleRole.left
                        leftMargin: 50
                        topMargin: 15
                         }
                     }

                CheckBox {
                    id: idCheckBoxReports
                    //text: qsTr("Reports")
                    checked: false
                    enabled: false
                    anchors {
                        top: idCheckBoxSettings.bottom
                        left: idTxtCheckBoxReports.right
                        topMargin: 10
                    }
                }

                Rectangle {
                    id: idRectangleInsideRole
                    width: idRectangleRole.width
                    height: idRectangleRole.height/3
                    color: "#E3E8EC"
                    radius: 5
                    anchors {
                       bottom: idRectangleRole.bottom
                       left: idRectangleRole.left
                       right: idRectangleRole.right
                       leftMargin: 5
                       rightMargin: 5
                       bottomMargin: 5
                    }
                    Button {
                        id: idPrevButtonRole
                        anchors{
                            top: idRectangleInsideRole.top
                            left: idRectangleInsideRole.left
                            topMargin: idRectangleInsideRole.height/6
                            leftMargin: idRectangleInsideRole.width/45
                        }
                        background: POS_FunctionButton {
                            text: "Prev"
                            width: idRectangleInsideRole.width/8
                            height: idRectangleInsideRole.height/3
                            onClicked: {
                                roleMaster.previous()
                                idTxtFieldRoleName.text=roleMaster.Role
                                if(roleMaster.sales =="1")
                                {
                                    idCheckBoxSales.checked = true
                                }
                                else
                                {
                                    idCheckBoxSales.checked = false
                                }
                                if(roleMaster.payments =="1")
                                {
                                    idCheckBoxPayment.checked = true
                                }
                                else
                                {
                                    idCheckBoxPayment.checked = false
                                }
                                if(roleMaster.settings =="1")
                                {
                                    idCheckBoxSettings.checked = true
                                }
                                else
                                {
                                    idCheckBoxSettings.checked = false
                                }
                                if(roleMaster.report =="1")
                                {
                                    idCheckBoxReports.checked = true
                                }
                                else
                                {
                                    idCheckBoxReports.checked = false
                                }
                                idTxtFieldRoleName.readOnly =true
                                idCheckBoxSales.enabled =false
                                idCheckBoxPayment.enabled =false
                                idCheckBoxSettings.enabled =false
                                idCheckBoxReports.enabled =false
                                idUpdateButtonRole.visible=false
                            }
                        }
                    }
                    Button {
                        id: idNextButtonRole
                        anchors{
                            top: idRectangleInsideRole.top
                            left: idPrevButtonRole.right
                            topMargin: idRectangleInsideRole.height/6
                            leftMargin: idRectangleInsideRole.width/8.5
                        }
                        background: POS_FunctionButton {
                            text: "Next"
                            width: idRectangleInsideRole.width/8
                            height: idRectangleInsideRole.height/3
                            onClicked: {
                                roleMaster.next()
                                idTxtFieldRoleName.text=roleMaster.Role
                                if(roleMaster.sales =="1")
                                {
                                    idCheckBoxSales.checked = true
                                }
                                else
                                {
                                    idCheckBoxSales.checked = false
                                }
                                if(roleMaster.payments =="1")
                                {
                                    idCheckBoxPayment.checked = true
                                }
                                else
                                {
                                    idCheckBoxPayment.checked = false
                                }
                                if(roleMaster.settings =="1")
                                {
                                    idCheckBoxSettings.checked = true
                                }
                                else
                                {
                                    idCheckBoxSettings.checked = false
                                }
                                if(roleMaster.report =="1")
                                {
                                    idCheckBoxReports.checked = true
                                }
                                else
                                {
                                    idCheckBoxReports.checked = false
                                }
                                idTxtFieldRoleName.readOnly =true
                                idCheckBoxSales.enabled =false
                                idCheckBoxPayment.enabled =false
                                idCheckBoxSettings.enabled =false
                                idCheckBoxReports.enabled =false
                                idUpdateButtonRole.visible=false
                            }
                        }
                    }
                    Button {
                        id: idNewButtonRole
                        anchors{
                            top: idRectangleInsideRole.top
                            right: idEditButtonRole.left
                            topMargin: idRectangleInsideRole.height/6
                            rightMargin: idRectangleInsideRole.width/8.5

                        }
                        background: POS_FunctionButton {
                            text: "New"
                            width: idRectangleInsideRole.width/8
                            height: idRectangleInsideRole.height/3
                            onClicked: {
                                roleMaster.refresh()
                                idTxtFieldRoleName.readOnly= false
                                idTxtFieldRoleName.text=""
                                idCheckBoxSales.checked =false
                                idCheckBoxPayment.checked =false
                                idCheckBoxSettings.checked = false
                                idCheckBoxReports.checked =false
                                idCheckBoxSales.enabled =true
                                idCheckBoxPayment.enabled =true
                                idCheckBoxSettings.enabled =true
                                idCheckBoxReports.enabled =true
                            }
                        }
                    }
                    Button {
                        id: idEditButtonRole
                        anchors{
                            top: idRectangleInsideRole.top
                            right: idDeleteButtonRole.left
                            topMargin: idRectangleInsideRole.height/6
                           rightMargin: idRectangleInsideRole.width/8.5
                        }
                        background: POS_FunctionButton {
                            text: "Edit"
                            width: idRectangleInsideRole.width/8
                            height: idRectangleInsideRole.height/3
                            onClicked:{
                                if(idTxtFieldRoleName.text!="")
                                {
                                    idUpdateButtonRole.visible=true
                                    idTxtFieldRoleName.readOnly=false
                                    idCheckBoxSales.enabled =true
                                    idCheckBoxPayment.enabled =true
                                    idCheckBoxSettings.enabled =true
                                    idCheckBoxReports.enabled =true
                                }
                                else
                                {
                                    console.log("Textfields are empty!")
                                }
                            }
                        }
                    }
                    Button {
                        id: idDeleteButtonRole
                        anchors{
                            top: idRectangleInsideRole.top
                            right: idRectangleInsideRole.right
                            rightMargin: idRectangleInsideRole.width/8
                            topMargin: idRectangleInsideRole.height/6
                        }
                        background: POS_FunctionButton {
                            text: "Delete"
                            width: idRectangleInsideRole.width/8
                            height: idRectangleInsideRole.height/3
                            onClicked: {
                                if(idTxtFieldRoleName.text!="")
                                {
                                roleMaster.deleteRole()
                                roleMaster.refresh()
                                    roleMaster.previous()
                                    idTxtFieldRoleName.text=roleMaster.Role
                                    if(roleMaster.sales =="1")
                                    {
                                        idCheckBoxSales.checked = true
                                    }
                                    else
                                    {
                                        idCheckBoxSales.checked = false
                                    }
                                    if(roleMaster.payments =="1")
                                    {
                                        idCheckBoxPayment.checked = true
                                    }
                                    else
                                    {
                                        idCheckBoxPayment.checked = false
                                    }
                                    if(roleMaster.settings =="1")
                                    {
                                        idCheckBoxSettings.checked = true
                                    }
                                    else
                                    {
                                        idCheckBoxSettings.checked = false
                                    }
                                    if(roleMaster.report =="1")
                                    {
                                        idCheckBoxReports.checked = true
                                    }
                                    else
                                    {
                                        idCheckBoxReports.checked = false
                                    }
                                    idTxtFieldRoleName.readOnly =true
                                    idCheckBoxSales.enabled =false
                                    idCheckBoxPayment.enabled =false
                                    idCheckBoxSettings.enabled =false
                                    idCheckBoxReports.enabled =false
                                    idUpdateButtonRole.visible=false
                                }
                                else
                                {
                                    console.log("Please select Role!")
                                }
                            }
                        }
                    }
                    Button {
                        id: idClearButtonRole
                        anchors{
                            top: idEditButtonRole.bottom
                            right: idSaveButtonRole.left
                            topMargin: idRectangleInsideRole.height/4.5
                            rightMargin: idRectangleInsideRole.width/8.5
                        }
                        background: POS_FunctionButton {
                            text: "Clear"
                            width: idRectangleInsideRole.width/8
                            height: idRectangleInsideRole.height/3
                            onClicked: {
                                roleMaster.refresh()
                                idTxtFieldRoleName.text=""
                                idCheckBoxSales.checked =false
                                idCheckBoxPayment.checked =false
                                idCheckBoxSettings.checked = false
                                idCheckBoxReports.checked =false
                                idUpdateButtonRole.visible=false
                            }
                        }
                    }
                    Button {
                        id: idSaveButtonRole
                        anchors{
                            top: idDeleteButtonRole.bottom
                            right: idRectangleInsideRole.right
                            topMargin: idRectangleInsideRole.height/4.5
                            rightMargin: idRectangleInsideRole.width/8
                        }
                        background: POS_FunctionButton {
                            text: "Save"
                            width: idRectangleInsideRole.width/8
                            height: idRectangleInsideRole.height/3
                            onClicked:
                            if(idTxtFieldRoleName.text!="")
                            {
                                if(idCheckBoxSales.checked == true)
                                { sale =1
                                }
                                else
                                {
                                    sale=0
                                }
                                if(idCheckBoxPayment.checked == true)
                                { payment =1
                                }
                                else
                                {
                                    payment=0
                                }
                                if(idCheckBoxSettings.checked == true)
                                { setting =1
                                }
                                else
                                {
                                    setting=0
                                }
                                if(idCheckBoxReports.checked == true)
                                { report =1
                                }
                                else
                                {
                                    report=0
                                }

                                console.log("save")
                                    roleMaster.saveRole(idTxtFieldRoleName.text,sale,payment,setting,report)
                                 roleMaster.refresh()
                                roleMaster.next()
                                idTxtFieldRoleName.text=roleMaster.Role
                                if(roleMaster.sales =="1")
                                {
                                    idCheckBoxSales.checked = true
                                }
                                else
                                {
                                    idCheckBoxSales.checked = false
                                }
                                if(roleMaster.payments =="1")
                                {
                                    idCheckBoxPayment.checked = true
                                }
                                else
                                {
                                    idCheckBoxPayment.checked = false
                                }
                                if(roleMaster.settings =="1")
                                {
                                    idCheckBoxSettings.checked = true
                                }
                                else
                                {
                                    idCheckBoxSettings.checked = false
                                }
                                if(roleMaster.report =="1")
                                {
                                    idCheckBoxReports.checked = true
                                }
                                else
                                {
                                    idCheckBoxReports.checked = false
                                }
                                idTxtFieldRoleName.readOnly =true
                                idUpdateButtonRole.visible=false
                                idCheckBoxSales.checked =false
                                idCheckBoxPayment.checked =false
                                idCheckBoxSettings.checked = false
                                idCheckBoxReports.checked =false
                                idCheckBoxSales.enabled =false
                                idCheckBoxPayment.enabled =false
                                idCheckBoxSettings.enabled =false
                                idCheckBoxReports.enabled =false
                            }
                            else
                            {
                                console.log("Textfields are empty!")
                            }
                        }
                    }
                    Button {
                        id: idUpdateButtonRole
                        anchors{
                            top: idDeleteButtonRole.bottom
                            right: idRectangleInsideRole.right
                            topMargin: idRectangleInsideRole.height/4.5
                            rightMargin: idRectangleInsideRole.width/8
                        }
                        visible: false
                        background: POS_FunctionButton {
                            text: "Update"
                            width: idRectangleInsideRole.width/8
                            height: idRectangleInsideRole.height/3
                            onClicked:  {
                                if(idCheckBoxSales.checked == true)
                                { sale =1
                                }
                                else
                                {
                                    sale =0
                                }
                                if(idCheckBoxPayment.checked == true)
                                { payment =1
                                }
                                else
                                {
                                    payment =0
                                }
                                if(idCheckBoxSettings.checked == true)
                                { setting =1
                                }
                                else
                                {
                                    setting =0
                                }
                                if(idCheckBoxReports.checked == true)
                                { report = 1
                                }
                                else
                                {
                                    report = 0
                                }
                                roleMaster.edit(idTxtFieldRoleName.text,sale,payment,setting,report)
                                roleMaster.editUserRole(idTxtFieldRoleName.text)
                                roleMaster.refresh()
                                idUpdateButtonRole.visible = false
                                idTxtFieldRoleName.readOnly =true
                                idCheckBoxSales.enabled =false
                                idCheckBoxPayment.enabled =false
                                idCheckBoxSettings.enabled =false
                                idCheckBoxReports.enabled =false
                            }
                        }
                    }
                }
            }
            }
        }
    }
}

