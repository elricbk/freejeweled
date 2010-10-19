import Qt 4.7

Rectangle {
    id: page

    property string title: ""

    signal closed
    signal opened
    function forceClose() {
        if(page.opacity == 0)
            return; //already closed
        page.closed();
        page.state = "stateHidden";
        page.opacity = 0;
    }

    function show(txt) {
        page.opened();
//        dialogText.text = txt;
        page.state = "stateShown";
        page.opacity = 0.7;
    }

    width: 200; height: 300
    state: "stateHidden"
    color: "black"
    border.width: 1
    opacity: 0
    visible: opacity > 0
    radius: 5
    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    Text {
        id: titleText;
        anchors.top: parent.top;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5;
        font.bold: true;
        font.pointSize: 20
        color: "white"
        text: "Your result"
    }

    Text {
        id: lblLevel
        color: "white"
        text: "Level"
        anchors.top: titleText.bottom
        anchors.margins: 10
        font.pointSize: 16
    }

    Text {
        id: lblScore
        color: "white"
        text: "Score"
        anchors.top: lblLevel.bottom
        anchors.margins: 10
        font.pointSize: 16
    }

    Text {
        id: valueLevel
        color: "white"
        text: gameBoard.level
        anchors.top: titleText.bottom
        anchors.margins: 10
        font.pointSize: 16
    }

    Text {
        id: valueScore
        color: "white"
        text: gameBoard.score
        anchors.top: valueLevel.bottom
        anchors.margins: 10
        font.pointSize: 16
    }

    states: [
        State {
            name: "stateShown"
            when: visible == true
            AnchorChanges { target: titleText; anchors.top: page.top }
            AnchorChanges { target: lblLevel; anchors.left: page.left }
            AnchorChanges { target: lblScore; anchors.left: page.left }
            AnchorChanges { target: valueLevel; anchors.right: page.right }
            AnchorChanges { target: valueScore; anchors.right: page.right }
        },
        State {
            name: "stateHidden"
            when: visible == false
            AnchorChanges { target: titleText; anchors.top: page.bottom }
            AnchorChanges { target: lblLevel; anchors.right: page.left }
            AnchorChanges { target: lblScore; anchors.right: page.left }
            AnchorChanges { target: valueLevel; anchors.left: page.right }
            AnchorChanges { target: valueScore; anchors.left: page.right }
            AnchorChanges { target: page; anchors.bottom: parent.top }
        }
    ]

    transitions: [
        Transition {
            PauseAnimation { duration: 500 }
            AnchorAnimation { duration: 1000 }
        }
    ]


    MouseArea { anchors.fill: parent; onClicked: forceClose(); }
}
