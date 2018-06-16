import QtQuick 2.0

Item {
    id: idRoot
    width: 200
    height: 100

    signal groupChanged(string groupName);

    /*BorderImage {
        id: idGroupBackground
        source: "qrc:/images/theme1/containerBg.png"
        border.left: 10; border.top: 10
        border.right: 10; border.bottom: 10
        anchors.fill: parent
    }*/

    Rectangle {
        id: idGroupBackground
        anchors.fill: parent
        radius: 2 //10
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#97b8ed" }// "#ebebec" }
            GradientStop { position: 1.0; color: "#97b8ed" }// "#e3e8ec" }
        }

        border.color: "#35507c" //"#d2d4d5"
        border.width: 1
    }

    ListView {
        id: idGroupList
        anchors.fill: idGroupBackground
        anchors.margins: 10
        anchors.rightMargin: height * 0.6
        orientation: Qt.Horizontal
        clip: true
        //highlightMoveDuration: 10
        model: groupModel
        delegate: idDelegate
        spacing: 5
        /* POS_Button {
            property variant modelData: model
            name: model.name
            height: idGroupList.height
            width: height * 0.9

            onClicked: {
                ListView.view.currentIndex = index
            }
        }*/

        onCurrentIndexChanged: {
            console.log("group index changed handler")
            itemModel.groupCode = currentItem.modelData.code
            subGroupModel.groupCode = currentItem.modelData.code
//            idSubGroupListView.currentIndex = 0
            idRoot.groupChanged(currentItem.modelData.name)
        }
    }

    Component {
        id: idDelegate
        Rectangle {
            id: idComponentRectangle
            width: idGroupBackground.width / 3
            height: idGroupBackground.height
            property variant modelData: model

            Text {
                text: model.name
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: idGroupList.currentIndex = index
            }
        }
    }

    Item {
        id: idGroupNavControl
        anchors.left: idGroupList.right
        anchors.top: idGroupBackground.top
        anchors.bottom: idGroupBackground.bottom
        anchors.right: idGroupBackground.right
        anchors.margins: 10
        property int scrollXValue: 0

        Column {
            Image {
                id: idGroupNavLeft
                source: "qrc:/images/theme1/groupNavLeft.png"
                width: idGroupNavControl.width
                height: idGroupNavControl.height/2

                MouseArea{
                    anchors.fill: parent
                    onPressed: idGroupNavLeft.scale = 0.98
                    onReleased: idGroupNavLeft.scale = 1
                    onClicked: {
                        var firstVisibleItemIndex = Math.floor((idGroupNavControl.scrollXValue -
                                                idGroupList.width)/(idGroupList.contentWidth/idGroupList.count))
                        firstVisibleItemIndex = (firstVisibleItemIndex < 0) ? -1 : firstVisibleItemIndex

                        if (-1 !== firstVisibleItemIndex)
                        {
                            idGroupNavControl.scrollXValue = idGroupNavControl.scrollXValue - idGroupList.width
//                            idGroupList.currentIndex = firstVisibleItemIndex;
                        }
                        else
                        {
//                            idGroupList.currentIndex = 0
//                            idGroupNavControl.scrollXValue = 0
                        }
                    }
                }
            }

            Image {
                id: idGroupNavRight
                source: "qrc:/images/theme1/groupNavRight.png"
                width: idGroupNavLeft.width
                height: idGroupNavLeft.height

                MouseArea{
                    anchors.fill: parent
                    onPressed: idGroupNavRight.scale = 0.98
                    onReleased: idGroupNavRight.scale = 1
                    onClicked: {
                        var lastVisibleItemIndex = Math.floor((idGroupNavControl.scrollXValue +
                                                idGroupList.width)/(idGroupList.contentWidth/idGroupList.count))
                        lastVisibleItemIndex = (lastVisibleItemIndex > idGroupList.count -1) ? -1 : lastVisibleItemIndex

                        if (-1 !== lastVisibleItemIndex)
                        {
                            idGroupNavControl.scrollXValue = idGroupNavControl.scrollXValue + idGroupList.width
//                            idGroupList.currentIndex = lastVisibleItemIndex;
                        }
                        else
                        {
//                            idGroupList.currentIndex = idGroupList.count - 1
                            idGroupNavControl.scrollXValue = idGroupList.contentWidth
                        }
                    }
                }
            }
        }
    }


    /* Below connection is needed, as on group index change, subgroup current index
        does not change, it  remains 0, so explicitly call the function to update model*/
    Component.onCompleted: {
        subGroupModel.onGroupCodeChanged.connect(idSubGroupListView.onCurrentIndexChanged)
    }

    /* Sub group which is not visible */

    ListView {
        id: idSubGroupListView
        visible: false//isSubGroupVisible
//        anchors.fill: idSubGroupBackground
        model: subGroupModel
        focus: true
        highlight: Rectangle { color: "#115d8b"}

        header: Item {
            id: idSubGroupHeaderItem
            width: idSubGroupListView.width
            height: idSubGroupListView.height * 0.1
            baselineOffset: idSubGroupHeadertext.y + idSubGroupHeadertext.baselineOffset

            Text {
                id: idSubGroupHeadertext
                text: "SUB CATEGORY"
                color: "lightgrey"
                font.pixelSize: idSubGroupHeaderItem.height * 0.25
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
        }

        delegate: POS_Button {
            id: idSubGroupListButton
            property variant modelData: model
            width: 100//idGroupListView.width
            height: 100//idGroupListView.height * 0.1
            name: name

            onClicked: {
                console.log("clicked handler")
                ListView.view.currentIndex = index
            }
        }

        onCurrentIndexChanged: {
            console.log("subgroup index changed handler")
            itemModel.subGroupCode = currentItem.modelData.code
//            idItemListView.currentIndex = 0
        }
    }

}




