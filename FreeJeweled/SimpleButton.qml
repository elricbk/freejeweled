import Qt 4.7

Rectangle {
    id: button
    color: "white"

    property string caption: "Button"
    property color textColor: "white"
    signal clicked

    radius: 8
    smooth: true

    width: buttonLabel.width + 20
    height: buttonLabel.height + 5
    border { width: 1; color: Qt.darker(button.color) }

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
        GradientStop {
            position: 1.0;
            color: {
                if (!mouseArea.pressed)
                    return Qt.darker(button.color);
                else
                    return Qt.darker(Qt.darker(button.color));
            }
        }
    }

    Text {
        id: buttonLabel
        anchors.centerIn: parent
        text: caption
        color: textColor
        styleColor: "black"
        font.pointSize: 10
        font.family: buttonFont.name
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: button.clicked()
    }
}
