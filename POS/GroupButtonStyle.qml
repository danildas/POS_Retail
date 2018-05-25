import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

ButtonStyle {
    id: idRoot
    property color fontColor
    property bool pressed: false

    background: Rectangle {
        //color: idRoot.pressed ? "orange" : "transparent"
        color: "transparent"
    }

    label: Item {
        implicitWidth: row.implicitWidth
        implicitHeight: row.implicitHeight
        baselineOffset: row.y + text.y + text.baselineOffset

        Row {
            id: row
            anchors.left: control.text.length === 0 ? undefined : parent.left
            anchors.leftMargin: control.text.length === 0 ? 0 : textSingleton.implicitHeight - 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: control.text.length === 0 ? parent.horizontalCenter : undefined

            Text {
                id: text
                text: control.text
                color: fontColor
                font.pixelSize: control.height * 0.25
                //font.family:
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
