import QtQuick 2.0

BorderImage {
    id: idRoot
    source: "qrc:/images/theme1/itemButton.png"
    width: parent.width/4; height: parent.width/4
    border.left: 5; border.top: 5
    border.right: 5; border.bottom: 5

    property bool groupButton: true
    property alias name: idNameText.text
    property alias price: idPriceText.text

    signal clicked();

 /*   Image {
        id: idDefaultImage
        source: (idRoot.groupButton) ? "qrc:/images/theme1/groupDefaultImage.png" : "qrc:/images/theme1/itemDefaultImage.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/12
        width: parent.width/2
        height: parent.height/2
        fillMode: Image.PreserveAspectFit
    }*/

    Text {
        id: idNameText
        anchors.bottom: idRoot.bottom
        anchors.left: idRoot.left
        anchors.right: idRoot.right
        anchors.top: idRoot.verticalCenter
        anchors.margins: 10
        text: "- Untitled -"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
    }

    Rectangle {
        anchors.fill: idPriceText
        anchors.margins: -10
        color: "yellow"
        opacity: 0.5
        visible: idPriceText.visible
    }

    Text {
        id: idPriceText
        text: qsTr("- 0.00 -")
        anchors.right: idRoot.right
        anchors.rightMargin: 16
       // anchors.verticalCenter: idDefaultImage.verticalCenter
        font.bold: true
        visible: !groupButton
    }

    MouseArea {
        anchors.fill: parent
        onPressed: idRoot.scale = 0.98
        onReleased: idRoot.scale = 1
        onClicked: idRoot.clicked()
    }
}
