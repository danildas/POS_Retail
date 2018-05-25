import QtQuick 2.0

Rectangle {
    id: idRoot
    width: 50; height: width
    radius: 5
    gradient: idGradient1

    property alias text: idText.text

    signal clicked(var value)
    signal pressAndHold()

    Gradient {
        id: idGradient1
        GradientStop { position: 0.0; color: "#ffffff" }
        GradientStop { position: 1.0; color: "#e3e8ec" }
    }

    Gradient {
        id: idGradient2
        GradientStop { position: 0.0; color: "#e3e8ec" }
        GradientStop { position: 1.0; color: "#ffffff" }
    }

    border.width: 1
    border.color: "#e3e8ec"

    Text {
        id: idText
        text: qsTr("1")
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: idFont.name
        font.pixelSize: 14
    }

    MouseArea {
        anchors.fill: parent
        onPressed: idRoot.gradient = idGradient2
        onReleased: idRoot.gradient = idGradient1
        onClicked: idRoot.clicked(idText.text)
        onPressAndHold: idRoot.pressAndHold()
    }
}
