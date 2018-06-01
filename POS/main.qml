import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    //flags: Qt.FramelessWindowHint

    FontLoader {
        id: idFont
        source: "qrc:/fonts/aileron/Aileron-Light.otf"
    }

    FontLoader {
        id: idFontThin
        source: "qrc:/fonts/aileron/Aileron-Thin.otf"
    }

    FontLoader {
        id: idFontBold
        source: "qrc:/fonts/aileron/Aileron-Regular.otf"
    }

    Item {
        id: settings
        property int monetaryUnitFraction: 100

        property double subtotal: 0.0
        property double sgst: 0.0
        property double cgst: 0.0
        property double total: 0.0
        property int billNo: 0
    }

    Item {
        id: idRoot
        anchors.fill: parent
        state: "home"

        TitleBar {
            id: idTitleBar
            width: parent.width
            height: parent.height/18

            onLogOut: {
                idRoot.state = "home"
            }
        }

        Settings {
            id: idSettingsScreen
            anchors.top: idTitleBar.bottom
            anchors.bottom: idStatusBar.top
            width: parent.width
        }

      /*  PaymentScreen {
            id: idPaymentScreen
            anchors.top: idTitleBar.bottom
            anchors.bottom: idStatusBar.top
            width: parent.width

            onBackClicked: {
                idRoot.state = "sales"
            }
        }*/

        OrderScreen1 {
            id: idOrderScreen
            anchors.top: idTitleBar.bottom
            anchors.bottom: idStatusBar.top
            width: parent.width

//            onPayClicked: {
//               idRoot.state = "payment"
//            }
        }

        HomeScreen {
            id: idHomeScreen
            width: parent.width
            height: parent.height

            onSettingsSelected: {
                idRoot.state = "settings"
            }
            onSalesSelected: {
                idRoot.state = "sales"
            }
        }

        StatusBar {
            id: idStatusBar
            width: parent.width
            height: parent.height/100
            anchors {
                bottom: parent.bottom
            }
        }

        onStateChanged: {
            console.log("state is", state)
        }

        states: [
            State { name: "home" },
            State {
                name: "sales"
//                PropertyChanges {
//                    target: idHomeScreen; x:-idRoot.width
//                }
//                PropertyChanges {
//                    target: idOrderScreen; x:0
//                }
               //PropertyChanges { target: idPaymentScreen; x:-idRoot.width }
            },
          /*  State {
                name: "payment"
                PropertyChanges { target: idPaymentScreen }
            },*/
            State {
                name: "settings"
                PropertyChanges { target: idSettingsScreen }

            }
        ]

        transitions: [
          /*  Transition {
                from: "sales"
                to: "payment"

                ParallelAnimation {
                    NumberAnimation {
                        target: idOrderScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: -idRoot.width
                    }

                    NumberAnimation {
                        target: idPaymentScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to:0; from: idRoot.width
                    }
                }
            },*/
            Transition {
                from: "home"
                to: "sales"

                ParallelAnimation {
                    NumberAnimation {
                        target: idHomeScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: -idRoot.width
                    }

                    NumberAnimation {
                        target: idOrderScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }

                    NumberAnimation {
                        target: idSettingsScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                         to:-idRoot.width ; from:0
                    }
                }
            },
          /*  Transition {
                to: "sales"
                from: "payment"

                ParallelAnimation {
                    NumberAnimation {
                        target: idOrderScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: -idRoot.width
                    }

                    NumberAnimation {
                        target: idPaymentScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: idRoot.width
                    }
                }
            },*/
            Transition {
                to: "home"
                from: "sales"

                ParallelAnimation {
                    NumberAnimation {
                        target: idHomeScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: -idRoot.width
                    }

                    NumberAnimation {
                        target: idOrderScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        from: 0; to: idRoot.width
                    }
                }
            },
            Transition {
                from: "home"
                to: "settings"

                ParallelAnimation {
                    NumberAnimation {
                        target: idHomeScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: -idRoot.width; from:0
                    }

                    NumberAnimation {
                        target: idSettingsScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                         to:0; from:idRoot.width
                    }

                   /* NumberAnimation {
                        target: idPaymentScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                         to: -idRoot.width; from:0
                    }*/

                    NumberAnimation {
                        target:idOrderScreen ; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                         to: -idRoot.width; from:0
                    }
                }
            },
            Transition {
                from:"settings"
                to: "home"

                ParallelAnimation {
                    NumberAnimation {
                        target: idHomeScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }

                    NumberAnimation {
                        target: idSettingsScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                         to:-idRoot.width ; from:0
                }
            }
            }/*,
            Transition {
                from:"payment"
                to: "home"

                ParallelAnimation {
                    NumberAnimation {
                        target: idHomeScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                        to: 0; from: idRoot.width
                    }

                    NumberAnimation {
                        target: idPaymentScreen; property: "x"
                        duration: 100; //easing.type: Easing.InOutQuad
                         to:-idRoot.width ; from:0
                }
            }
            }*/
        ]

        onWidthChanged: {
            console.log("width changed")
            if ("sales" === idRoot.state)
            {
                idHomeScreen.x = -idRoot.width
            }
            else if ("payment" === idRoot.state)
            {
                idOrderScreen.x = -idRoot.width
            }

        }
    }

    Text {
        id: textSingleton
    }
}
