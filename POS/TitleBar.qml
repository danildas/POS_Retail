import QtQuick 2.0

Item {
    id: idRoot
    width: 500
    height: 200

    signal logOut()

    Image {
        id: idBackground
        anchors.fill: parent
        source: "qrc:/images/theme1/titlebar_background.png"
        fillMode: Image.TileHorizontally
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#47494c" }
            GradientStop { position: 1.0; color: "#c7c9cc" }
        }
    }

    Text {
        id: idBillTitle
        text: "#"
        color: "white"
        height: parent.height
        font.family: idFont.name
        font.pixelSize: 16
        verticalAlignment: Text.AlignVCenter

        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Text {
        id: idLogOut
        text: qsTr("Logout")
        color: "white"
        height: parent.height
        font.family: idFont.name
        font.pixelSize: 16
        verticalAlignment: Text.AlignVCenter

        anchors.right: parent.right
        anchors.rightMargin: 10

        MouseArea {
            anchors.fill: parent
            onClicked: {
                idRoot.logOut()
            }
        }
    }
}
