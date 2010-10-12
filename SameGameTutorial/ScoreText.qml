import Qt 4.7

Text {
    id: scoreLabel
    property int type: 1
    property int shiftValue: 80
    property int scoreValue: 0
    property bool animationStarted: false

    text: scoreValue
    font.bold: true
    font.pointSize: 16
    opacity: 0
    color: {
        if (type == 1)
            return "red";
        else if (type == 2)
            return "steelblue";
        else if (type == 3)
            return "green";
        else if (type == 4)
            return "purple";
        else if (type == 5)
            return "white";
        else if (type == 6)
            return "orange";
        else if (type == 0)
            return "yellow";
    }

    ParallelAnimation {
        id: scoreLabelAnimation
        running: scoreLabel.animationStarted
        PropertyAction { target: scoreLabel; property: "opacity"; value: 1 }
        NumberAnimation { target: scoreLabel; property: "y"; to: scoreLabel.y - scoreLabel.shiftValue; duration: 1500 }
        NumberAnimation { target: scoreLabel; property: "opacity"; to: 0; duration: 1500 }
    }
}
