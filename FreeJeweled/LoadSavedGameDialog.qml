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

    LoadDialogButton {
        id: btnNewGame
        caption: "New Game"
        color: "red"
        anchors.top: dlgTitle.bottom
        onClicked: {
            dlgLoadSave.newGame();
            forceClose();
        }
    }

    LoadDialogButton {
        id: btnLoadSaved
        caption: "Load game"
        color: "blue"
        anchors.top: btnNewGame.bottom
        onClicked: {
            dlgLoadSave.loadSaved();
            forceClose();
        }
    }

    LoadDialogButton {
        id: btnCancel
        color: "gray"
        caption: "Cancel"
        anchors.top: btnLoadSaved.bottom
        onClicked: {
            dlgLoadSave.cancel();
            forceClose();
        }
    }
}
