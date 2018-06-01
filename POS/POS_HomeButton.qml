import QtQuick 2.0

Item {
    id: idRoot
    property alias text: idText.text
    width: 100
    height: 50

    signal clicked()

    Rectangle {
        id: idBaseRect
        anchors.fill: idRoot
        radius: 2

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#e5e5e5" }
            GradientStop { position: 1.0; color: "#ffffff" }
        }
    }

    Rectangle {
        id: idInnerRect
        anchors.fill: idBaseRect
        anchors.margins: 10
        radius: 2

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ffffff" }
            GradientStop { position: 1.0; color: "#f2f2f2" }
        }

        border.color: "#224547"  //"#47494c"
        border.width: 1

        Text {
            id: idText
            text: qsTr("Sales")
            font.family: idFont.name
            font.bold: true
            font.pixelSize: 18
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#47494c"
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                idRoot.state = "Pressed"
            }

            onReleased: {
                idRoot.state = ""
            }

            onClicked: idRoot.clicked()
        }
    }

    states: [
        State {
            name: "Pressed"
            PropertyChanges { target: idInnerRect; scale: 0.9 }
        }
    ]
}
