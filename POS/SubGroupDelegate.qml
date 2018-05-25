import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button {
    width: ListView.width
    height: ListView.height * 0.125
    text: name

    signal selected(string code)

//    style: BlackButtonStyle {
//        fontColor: root.darkFontColor
//        rightAlignedIconSource: "qrc:/images/icon-go.png"
//    }

    onClicked: {
        console.log("group clicked", code)
        selected(code)
    }
}

//Item {
//    signal selected(string code)

//    id: delegate
//        width: delegate.ListView.view.width;
//        height: 30
//        clip: true
//        anchors.margins: 4

//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                console.log("sub group clicked", code)
//                delegate.selected(code)
//            }
//        }

//        Row {
//            anchors.margins: 4
//            anchors.fill: parent
//            spacing: 4;
//            Text {
//                text: name
//                width: 150
//            }
//        }

//        Component.onCompleted: {
//            if (0 == index)
//            {
//                delegate.selected(code)
//            }
//        }
//}
