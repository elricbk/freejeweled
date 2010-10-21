import Qt 4.7
//import "qml"
import com.mycompany.gemcell 1.0

Rectangle {
    id: screen

    width: 320
    height: 480
    state: "stateMainMenu"
    z: -10

    function getBackgroundSource() {
        var bgrStr = Math.floor(Math.random()*20 + 1).toString();
        if (bgrStr.length == 1) {
            bgrStr = "0" + bgrStr;
        }
        return "pics/backgrounds/bgr" + bgrStr + ".jpg";
    }

    SystemPalette { id: activePalette }

    FontLoader { id: gameFont; source: "fonts/mailrays.ttf" }

    Image {
        id: background
        anchors.fill: parent
        source: getBackgroundSource()
        fillMode: Image.PreserveAspectCrop
    }

    AboutDialog {
        id: dlgAbout
        visible: opacity > 0
        opacity: 0.0
        MouseArea {
            anchors.fill: parent
            onClicked: screen.state = "stateMainMenu"
        }
        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }
    }

    Rectangle {
        id: topGameBoardBorder
        visible: screen.state == "stateGame"
        color: "white"
        opacity: 0.5
        anchors.top: scoreBox.bottom
        height: 5
        width: parent.width
    }

    Rectangle {
        id: bottomGameBoardBorder
        visible: screen.state == "stateGame"
        color: "white"
        opacity: 0.5
        anchors.top: gameBoard.bottom
        height: 5
        width: parent.width
    }

    GameBoard {
        id: gameBoard
        width: 320
        height: 320
        anchors.top: topGameBoardBorder.bottom
        visible: opacity > 0
        opacity: 0
        property int hintX: 0
        property int hintY: 0
        property bool hintVisible: false

        MouseArea {
            anchors.fill: parent
            onClicked: gameBoard.handleClick(mouse.x, mouse.y)
        }

        Image {
            source: "pics/field.png"
            anchors.fill: parent
        }

        Item {
            id: selectionRect
            width: 40
            height: 40
            visible: gameBoard.gemSelected
            x: gameBoard.selGemColumn*width
            y: gameBoard.selGemRow*width

            Image {
                anchors.fill: parent
                source: "pics/selectionBorder.png"
                opacity: 0.8
                fillMode: Image.PreserveAspectCrop
            }
        }

        Image {
            id: hintImage
            source: "pics/hintArrow.png"
            x: gameBoard.hintX
            y: gameBoard.hintY - height/4

            visible: gameBoard.hintVisible
            z: 5
            ParallelAnimation {
                running: hintImage.visible
                SequentialAnimation {
                    loops: Animation.Infinite
                    PropertyAnimation { target: hintImage; property: "y"; to: gameBoard.hintY - 3*hintImage.height/4; duration: 300; easing.type: Easing.InOutQuad }
                    PropertyAnimation { target: hintImage; property: "y"; to: gameBoard.hintY - hintImage.height/4; duration: 300; easing.type: Easing.InOutQuad }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 3000 }
                    ScriptAction { script: gameBoard.hintVisible = false }
                }
            }
        }

        EndOfGameDialog {
            id: dlgEndGame
            anchors.centerIn: gameBoard
            z: 10
            onClosed: screen.state = "stateMainMenu"
        }

        onLevelUp: {
            msgText.text = "LEVEL UP!"
            msgText.font.pointSize = 38
            msgText.runAnimation();
            pbLevelProgress.minimum = gameBoard.score;
            pbLevelProgress.maximum = gameBoard.levelCap(gameBoard.level)
            background.source = getBackgroundSource();
            gameBoard.resetBoard();
        }

        onNoMoreMoves: {
            msgText.text = "NO MORE MOVES";
            msgText.font.pointSize = 30;
            msgText.runAnimation();
            dlgEndGame.show("Your result\nLevel: " + gameBoard.level + "\nScore: " + gameBoard.score);
        }
    }

    ProgressBar {
        id: pbLevelProgress
        visible: screen.state == "stateGame"
        anchors.horizontalCenter: screen.horizontalCenter
        anchors.top: bottomGameBoardBorder.bottom
        color: "white"
        secondColor: "green"
        height: 20
        maximum: gameBoard.levelCap(gameBoard.level)
        value: gameBoard.score
    }

    Item {
        id: scoreBox

        width: parent.width
        height: 60 /* cellSize*1.5, actually */
        state: "stateHidden"

        anchors.top: parent.top

        Text {
            id: txtScore
            color: "white"
            font.family: gameFont.name
            font.pointSize: 16
            font.bold: true
            text: gameBoard.score
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.bottomMargin: 5
        }

        Text {
            id: txtLevel
            color: "white"
            font.family: gameFont.name
            font.pointSize: 16
            font.bold: true
            text: "Level " + gameBoard.level + " "
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 5
        }

        states: [
            State {
                name: "stateNormal"
                AnchorChanges { target: txtScore; anchors.left: scoreBox.left }
                AnchorChanges { target: txtLevel; anchors.right: scoreBox.right }
            },
            State {
                name: "stateHidden"
                AnchorChanges { target: txtScore; anchors.right: scoreBox.left }
                AnchorChanges { target: txtLevel; anchors.left: scoreBox.right }
            }
        ]

        transitions: [
            Transition {
                from: "stateHidden"
                to: "stateNormal"
                AnchorAnimation { duration: 500; easing.type: Easing.OutBounce }
            },
            Transition {
                from: "stateNormal"
                to: "stateHidden"
                AnchorAnimation { duration: 200; easing.type: Easing.Linear }
            }
        ]

    }

    MsgText {
        id: msgText
    }

    Item {
        id: toolBar
        width: parent.width
        height: parent.height - scoreBox.height - topGameBoardBorder.height - gameBoard.height - bottomGameBoardBorder.height - pbLevelProgress.height
        anchors.top: pbLevelProgress.bottom
        visible: opacity > 0

        SimpleButton {
            id: btnReset
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 10
            color: "red"
            caption: "Reset"

            onClicked: gameBoard.resetBoard()
        }

        SimpleButton {
            id: btnRemoveAll
            anchors.top: parent.top
            anchors.left: btnReset.right
            anchors.leftMargin: 10
            caption: "Run"
            color: "steelblue"

            onClicked: gameBoard.removeAll()
        }

        SimpleButton {
            id: btnLoadSave
            anchors.top: parent.top
            anchors.left: btnRemoveAll.right
            anchors.leftMargin: 10
            caption: "Load"
            color: "green"

            onClicked: {
                gameBoard.loadBoardStateFromFile();
                pbLevelProgress.maximum = gameBoard.levelCap(gameBoard.level);
                pbLevelProgress.minimum = gameBoard.levelCap(gameBoard.level - 1);
            }

        }

        SimpleButton {
            id: btnLevelUp
            anchors.top: parent.top
            anchors.left: btnLoadSave.right
            anchors.leftMargin: 10
            caption: "LevelUp"
            color: "gold"

            onClicked: gameBoard.score = gameBoard.levelCap(gameBoard.level)
        }

        /* Second row of buttons */
        SimpleButton {
            id: btnLoadTest
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            caption: "Test"
            color: "royalblue"

            onClicked: gameBoard.loadTestBoard()
        }

        SimpleButton {
            id: btnShowHint
            anchors.bottom: parent.bottom
            anchors.left: btnLoadTest.right
            anchors.leftMargin: 10
            caption: "Hint"
            color: "beige"

            onClicked: gameBoard.showHint()
        }

        SimpleButton {
            id: btnMenu
            anchors.bottom: parent.bottom
            anchors.left: btnShowHint.right
            anchors.leftMargin: 10
            caption: "Menu"
            color: "red"

            onClicked: screen.state = "stateMainMenu"
        }
    }

    Text {
        id: gameTitle
        text: "FreeJeweled"
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        font.pointSize: 40
        font.family: gameFont.name
        color: "white"
    }

    Rectangle {
        id: btnClassic
        width: parent.width*0.75
        height: parent.height*0.15
        radius: height/2
        anchors.top: screen.top
        anchors.margins: gameTitle.height + gameTitle.anchors.topMargin + 75
        smooth: true
        border.width: 4
        border.color: "white"

        gradient: Gradient {
            GradientStop { color: "steelblue"; position: 0.0 }
            GradientStop { color: Qt.lighter("steelblue"); position: 0.2 }
            GradientStop { color: "steelblue"; position: 1.0 }
        }

        Text {
            font.family: gameFont.name
            font.pointSize: 30
            text: "Classic"
            color: "white"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: screen.state = "stateGame"
        }
    }

    Rectangle {
        id: btnEndless
        width: parent.width*0.75
        height: parent.height*0.15
        radius: height/2
        anchors.top: btnClassic.bottom
        anchors.margins: 10
        smooth: true
        border.width: 4
        border.color: "white"

        gradient: Gradient {
            GradientStop { color: "gray"; position: 0.0 }
            GradientStop { color: Qt.lighter("gray"); position: 0.2 }
            GradientStop { color: "gray"; position: 1.0 }
        }

        Text {
            font.family: gameFont.name
            font.pointSize: 30
            text: "Endless"
            color: "white"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: btnAbout
        width: parent.width*0.75
        height: parent.height*0.15
        radius: height/2
        anchors.top: btnEndless.bottom
        anchors.margins: 10
        smooth: true
        border.width: 4
        border.color: "white"

        gradient: Gradient {
            GradientStop { color: "steelblue"; position: 0.0 }
            GradientStop { color: Qt.lighter("steelblue"); position: 0.2 }
            GradientStop { color: "steelblue"; position: 1.0 }
        }

        Text {
            font.family: gameFont.name
            font.pointSize: 30
            text: "About"
            color: "white"
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: screen.state = "stateAbout"
        }
    }

    states: [
        State {
            name: "stateMainMenu"
            /* Main menu elements anchors */
            AnchorChanges { target: gameTitle; anchors.top: screen.top }
            AnchorChanges { target: btnClassic; anchors.horizontalCenter: screen.horizontalCenter }
            AnchorChanges { target: btnEndless; anchors.horizontalCenter: screen.horizontalCenter }
            AnchorChanges { target: btnAbout; anchors.horizontalCenter: screen.horizontalCenter }

            /* Game elements anchors */
            AnchorChanges { target: toolBar; anchors.top: screen.bottom }
        },
        State {
            name: "stateAbout"
            /* Main menu elements anchors */
            AnchorChanges { target: gameTitle; anchors.bottom: screen.top }
            AnchorChanges { target: btnClassic; anchors.right: screen.left }
            AnchorChanges { target: btnEndless; anchors.left: screen.right }
            AnchorChanges { target: btnAbout; anchors.right: screen.left }

            /* Game elements anchors */
            AnchorChanges { target: toolBar; anchors.top: screen.bottom }

            /* Showing About dialog */
            PropertyChanges { target: dlgAbout; opacity: 1.0 }
        },
        State {
            name: "stateGame"
            /* Main menu elements anchors */
            AnchorChanges { target: gameTitle; anchors.bottom: screen.top }
            AnchorChanges { target: btnClassic; anchors.right: screen.left }
            AnchorChanges { target: btnEndless; anchors.left: screen.right }
            AnchorChanges { target: btnAbout; anchors.right: screen.left }

            /* Game elements anchors */
            AnchorChanges { target: toolBar; anchors.top: pbLevelProgress.bottom }
        }
    ]

    transitions: [
        Transition {
            from: "stateMainMenu"
            to: "stateGame"
            SequentialAnimation {
                AnchorAnimation {
                    targets: [
                        gameTitle,
                        btnClassic,
                        btnEndless,
                        btnAbout
                    ]
                    duration: 500;
                    easing.type: Easing.InOutQuad
                }
                PropertyAction { target: gameBoard; property: "opacity"; value: 1.0 }
                PropertyAnimation {
                    duration: 500;
                    target: gameBoard;
                    property: "scale"; from: 5.0; to: 1.0;
                    easing.type: Easing.OutBounce
                }

                ParallelAnimation {
                    PropertyAction { target: scoreBox; property: "state"; value: "stateNormal" }
                    AnchorAnimation { targets: toolBar; duration: 200 }
                }

                ScriptAction {
                    script: {
                        if (gameBoard.hasSave()) {
                            gameBoard.loadBoardStateFromFile();
                            pbLevelProgress.maximum = gameBoard.levelCap(gameBoard.level);
                            pbLevelProgress.minimum = gameBoard.levelCap(gameBoard.level - 1);
                        } else {
                            gameBoard.newGame();
                        }
                    }
                }
            }
        },
        Transition {
            from: "stateMainMenu"
            to: "stateAbout"
            AnchorAnimation { duration: 500; easing.type: Easing.InOutQuad }
            PropertyAction { target: scoreBox; property: "state"; value: "stateHidden" }
        },
        Transition {
            from: "stateAbout"
            to: "stateMainMenu"
            SequentialAnimation {
                ScriptAction { script: dlgAbout.opacity = 0.0 }
                AnchorAnimation { duration: 500; easing.type: Easing.InOutQuad }
            }
        },
        Transition {
            from: "stateGame"
            to: "stateMainMenu"
            SequentialAnimation {
                ScriptAction { script: gameBoard.saveBoardStateToFile(); }
                PropertyAction { target: gameBoard; property: "opacity"; value: 0.0 }
                PropertyAction { target: scoreBox; property: "state"; value: "stateHidden" }
                AnchorAnimation { targets: toolBar; duration: 400; }
                AnchorAnimation {
                    targets: [
                        gameTitle,
                        btnClassic,
                        btnEndless,
                        btnAbout
                    ]
                    duration: 500;
                    easing.type: Easing.InOutQuad
                }
                ScriptAction {
                    script: {
                        gameBoard.clearBoard();
                        pbLevelProgress.minimum = 0;
                        pbLevelProgress.maximum = gameBoard.levelCap(1);
                    }
                }
            }
        }
    ]

}
