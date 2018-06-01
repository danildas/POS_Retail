import QtQuick 2.0

Item {
    id: idRoot
    width: 100
    height: 100

    signal salesSelected()
    signal settingsSelected()

    Rectangle {
        id: idBgRect
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#04e6f2" } // c7c9cc
            GradientStop { position: 1.0; color: "#224547" }  // 47494c
        }
        anchors.fill: parent

        Grid {
            rows: 2
            columns: 2
            rowSpacing: 10
            columnSpacing: 10
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: parent.width / 8
            anchors.bottomMargin: parent.height / 8

            POS_HomeButton {
                width: idBgRect.width/4 - 20
                height: width/2
                text: "Reports"
            }

            POS_HomeButton {
                width: idBgRect.width/4 - 20
                height: width/2
                text: "Sales"
                onClicked: {
                    idRoot.salesSelected()
                }
            }

            POS_HomeButton {
                width: idBgRect.width/4 - 20
                height: width/2
                text: "Settings"
                onClicked: {
                    idRoot.settingsSelected()
                }
            }

            POS_HomeButton {
                width: idBgRect.width/4 - 20
                height: width/2
                text: "Exit"
                onClicked: {
                    Qt.quit()
                }
            }
        }
    }
}
