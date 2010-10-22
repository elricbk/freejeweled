import Qt 4.7

Item {
    id: scoreItem

    width: 40
    height: 40
    opacity: 0

    property int type: 1
    property int shiftValue: 80
    property int scoreValue: 0
    property bool animationStarted: false

    Text {
        id: scoreLabel

        anchors.centerIn: scoreItem
        text: scoreItem.scoreValue
        font.bold: true
        font.pointSize: 16

        color: {
            if (scoreItem.type == 1)
                return "red";
            else if (scoreItem.type == 2)
                return "steelblue";
            else if (scoreItem.type == 3)
                return "green";
            else if (scoreItem.type == 4)
                return "purple";
            else if (scoreItem.type == 5)
                return "white";
            else if (scoreItem.type == 6)
                return "orange";
            else if (scoreItem.type == 0)
                return "yellow";
        }

        ParallelAnimation {
            id: scoreLabelAnimation
            running: scoreItem.animationStarted
            PropertyAction { target: scoreItem; property: "opacity"; value: 1 }
            NumberAnimation { target: scoreItem; property: "y"; to: scoreItem.y - scoreItem.shiftValue; duration: 1500 }
            NumberAnimation { target: scoreItem; property: "opacity"; to: 0; duration: 1500 }
        }
    }
}


