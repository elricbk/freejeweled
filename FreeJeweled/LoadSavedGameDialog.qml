import Qt 4.7

Rectangle {
    id: dlgLoadSave
    anchors { fill: parent; margins: 10 }
    color: "black"
    visible: opacity > 0
    opacity: 0.0
    radius: 10

    signal opened
    signal closed
    signal cancel
    signal loadSaved
    signal newGame

    function forceClose() {
        if(dlgLoadSave.opacity == 0)
            return; //already closed
        dlgLoadSave.closed();
        dlgLoadSave.opacity = 0;
    }

    function show() {
        dlgLoadSave.opened();
        dlgLoadSave.opacity = 0.7
    }

    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    Text {
        id: dlgTitle
        text: "<p align=\"center\">You have saved game.<br>Want to load?<\p>"
        color: "white"
        font.pointSize: 18
        anchors { top: dlgLoadSave.top; horizontalCenter: dlgLoadSave.horizontalCenter; margins: 30 }
    }

    Rectangle {
        id: btnLoadSaved
        width: dlgLoadSave.width - 40
        height: 40
        radius: height/2.3
        color: "green"
        anchors { horizontalCenter: dlgLoadSave.horizontalCenter; margins: 10; top: dlgTitle.bottom }

        Text {
            anchors.centerIn: parent
            text: "Load Game"
            font.pointSize: 14
            font.family: buttonFont.name
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                dlgLoadSave.loadSaved();
                forceClose();
            }
        }
    }

    Rectangle {
        id: btnNewGame
        width: dlgLoadSave.width - 40
        height: 40
        radius: height/2.3
        color: "red"
        anchors { horizontalCenter: dlgLoadSave.horizontalCenter; margins: 10; top: btnLoadSaved.bottom }

        Text {
            anchors.centerIn: parent
            color: "white"
            text: "New Game"
            font.pointSize: 14
            font.family: buttonFont.name
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                dlgLoadSave.newGame();
                forceClose();
            }
        }
    }

    Rectangle {
        id: btnCancel
        width: dlgLoadSave.width - 40
        height: 40
        radius: height/2.3
        color: "gray"
        anchors { horizontalCenter: dlgLoadSave.horizontalCenter; margins: 10; top: btnNewGame.bottom }

        Text {
            anchors.centerIn: parent
            color: "white"
            text: "Cancel"
            font.pointSize: 14
            font.family: buttonFont.name
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                dlgLoadSave.cancel();
                forceClose();
            }
        }
    }
}
