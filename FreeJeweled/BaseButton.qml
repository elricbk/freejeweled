/* Base button defines a bunch of properties which later used to customize different derived
buttons. These derived buttons are used later throughout the game. */
import Qt 4.7

Rectangle {
    id: button
    color: "white"
    width: buttonLabel.width + 20
    height: buttonLabel.height + 5
    radius: button.height/2.1
    smooth: true

    property alias caption: buttonLabel.text
    property alias textColor: buttonLabel.color
    property color borderColor: "white"
    property int borderWidth: 1
    property int fontSize: 10
    signal clicked

    border { width: borderWidth; color: borderColor }

    gradient: Gradient {
        GradientStop {
            position: 0.0;
            color: {
                if (!mouseArea.pressed)
                    return Qt.lighter(button.color);
                else
                    return button.color;
            }

        }
        GradientStop {
            position: 0.5;
            color: {
                if (!mouseArea.pressed)
                    return button.color;
                else
                    return Qt.darker(button.color);
            }

        }
//        GradientStop {
//            position: 1.0;
//            color: {
//                if (!mouseArea.pressed)
//                    return Qt.darker(button.color);
//                else
//                    return Qt.darker(Qt.darker(button.color));
//            }
//        }
    }

    Text {
        id: buttonLabel
        anchors.centerIn: parent
        font.pointSize: fontSize
        font.family: buttonFont.name
        color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: button.clicked()
    }
}
