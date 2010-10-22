import Qt 4.7

Rectangle {
    id: page

    signal closed
    signal opened

    function forceClose() {
        if(page.opacity == 0)
            return; //already closed
        page.closed();
        page.state = "stateHidden";
        page.opacity = 0;
    }

    function show() {
        page.opened();
        page.state = "stateShown";
    }

    anchors.fill: parent
    anchors.margins: 10
    state: "stateHidden"
    color: "black"
    border.width: 1
    opacity: 0
    visible: opacity > 0
    radius: 5
    Behavior on opacity {
        NumberAnimation { duration: 100 }
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
            from: "stateHidden"
            to: "stateShown"
            SequentialAnimation {
                /* Turning labeles and scores invisible */
                PropertyAction {
                    targets: [lblLevel, lblScore, valueLevel, valueScore, titleText];
                    properties: "visible";
                    value: false
                }

                /* This pause is used to wait until text message animation ends */
                PauseAnimation { duration: 2800 }

                /* Showing main page and title text */
                PropertyAction { target: page; property: "opacity"; value: 0.7 }
                PropertyAction { target: titleText; property: "visible"; value: true }
                AnchorAnimation { targets: titleText; duration: 500; easing.type: Easing.OutBounce }

                /* Turning labeles and scores visible and show 'em */
                PauseAnimation { duration: 500 }
                PropertyAction {
                    targets: [lblLevel, lblScore, valueLevel, valueScore];
                    properties: "visible";
                    value: true
                }
                AnchorAnimation { duration: 500; easing.type: Easing.OutBounce }
            }
        },
        Transition {
            from: "stateShown"
            to: "stateHidden"
            AnchorAnimation { duration: 1000 }
        }
    ]


    MouseArea { anchors.fill: parent; onClicked: page.forceClose(); }
}
