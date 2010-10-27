import Qt 4.7
import com.mycompany.gemcell 1.0

Rectangle {
    id: screen

    width: 8*gameBoard.cellSize
    height: 12*gameBoard.cellSize
    property double g_scaleFactor: gameBoard.cellSize/40
    state: "stateMainMenu"
    z: -10

    function setBackgroundSource() {
        var source = generateBackgroundFileName();
        while (source == background.source) {
            source = generateBackgroundFileName();
        }
        background.source = source;
    }

    function generateBackgroundFileName() {
        var bgrStr = Math.floor(Math.random()*20 + 1).toString();
        if (bgrStr.length == 1) {
            bgrStr = "0" + bgrStr;
        }
        return "pics/backgrounds/bgr" + bgrStr + ".jpg";
    }

    SystemPalette { id: activePalette }

    FontLoader { id: gameFont; source: "fonts/mailrays.ttf" }
    FontLoader { id: buttonFont; source: "fonts/pirulen.ttf" }
    FontLoader { id: titleFont; source: "fonts/redcircle.ttf" }

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: bgrMainMenu
        anchors.fill: parent
        source: "pics/backgrounds/bgr00.jpg"
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
        height: 5*gameBoard.cellSize/40
        width: parent.width
    }

    Rectangle {
        id: bottomGameBoardBorder
        visible: screen.state == "stateGame"
        color: "white"
        opacity: 0.5
        anchors.top: gameBoard.bottom
        height: 5*gameBoard.cellSize/40
        width: parent.width
    }

    GameBoard {
        id: gameBoard
        width: 8*gameBoard.cellSize
        height: 8*gameBoard.cellSize
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
            width: gameBoard.cellSize
            height: gameBoard.cellSize
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
            width: gameBoard.cellSize
            height: gameBoard.cellSize/2


            visible: gameBoard.hintVisible
            z: 5
            ParallelAnimation {
                running: hintImage.visible
                SequentialAnimation {
                    loops: Animation.Infinite
                    PropertyAnimation {
                        target: hintImage;
                        property: "y";
                        to: gameBoard.hintY - 3*hintImage.height/4;
                        duration: 300;
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAnimation {
                        target: hintImage;
                        property: "y";
                        to: gameBoard.hintY - hintImage.height/4;
                        duration: 300;
                        easing.type: Easing.InOutQuad
                    }
                }
                SequentialAnimation {
                    PauseAnimation { duration: 3000 }
                    ScriptAction { script: gameBoard.hintVisible = false }
                }
            }
        }

        onLevelUp: levelUpAnimation.start()

        onNoMoreMoves: {
            msgText.text = "NO MORE MOVES";
            msgText.font.pointSize = 30*gameBoard.cellSize/40;
            msgText.show();
            dlgEndGame.show("Your result\nLevel: " + gameBoard.level + "\nScore: " + gameBoard.score);
        }
    }

    SequentialAnimation {
        id: levelUpAnimation
        ScriptAction {
            script: {
                msgText.text = "LEVEL UP!";
                msgText.font.pointSize = 38*gameBoard.cellSize/40;
                msgText.show();
                gameBoard.dropGemsDown();
            }
        }
        PauseAnimation { duration: 3000 }
        ScriptAction {
            script: {
                msgText.text = "LEVEL " + gameBoard.level;
                msgText.font.pointSize = 38*gameBoard.cellSize/40;
                msgText.show();
                pbLevelProgress.minimum = gameBoard.levelCap(gameBoard.level - 1);
                pbLevelProgress.maximum = gameBoard.levelCap(gameBoard.level);
                setBackgroundSource();
                gameBoard.resetBoard();
            }
        }
    }

    EndOfGameDialog {
        id: dlgEndGame
        anchors.centerIn: gameBoard
        z: 10
        onClosed: screen.state = "stateMainMenu"
    }

    LoadSavedGameDialog {
        id: dlgLoadSave
        anchors.centerIn: screen
        z: 10
        onCancel: screen.state = "stateMainMenu"
        onLoadSaved: {
            gameBoard.loadBoardStateFromFile();
            pbLevelProgress.minimum = gameBoard.levelCap(gameBoard.level - 1);
            pbLevelProgress.maximum = gameBoard.levelCap(gameBoard.level);
        }
        onNewGame: gameBoard.newGame();
    }

    ProgressBar {
        id: pbLevelProgress
        visible: screen.state == "stateGame"
        anchors.horizontalCenter: screen.horizontalCenter
        anchors.top: bottomGameBoardBorder.bottom
        color: "white"
        secondColor: "green"
        height: 20*gameBoard.cellSize/40
        maximum: gameBoard.levelCap(gameBoard.level)
        value: gameBoard.score
    }

    Item {
        id: scoreBox

        width: parent.width
        height: 60*gameBoard.cellSize/40 /* cellSize*1.5, actually */
        state: "stateHidden"

        anchors.top: parent.top

        Text {
            id: txtScore
            color: "white"
            font.family: gameFont.name
            font.pointSize: 16*gameBoard.cellSize/40
            font.bold: true
            text: gameBoard.score
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10*gameBoard.cellSize/40
            anchors.bottomMargin: 5*gameBoard.cellSize/40
        }

        Text {
            id: txtLevel
            color: "white"
            font.family: gameFont.name
            font.pointSize: 16*gameBoard.cellSize/40
            font.bold: true
            text: "Level " + gameBoard.level + " "
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10*gameBoard.cellSize/40
            anchors.bottomMargin: 5*gameBoard.cellSize/40
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
                AnchorAnimation { duration: 200; easing.type: Easing.Linear }
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
        height: parent.height - scoreBox.height - topGameBoardBorder.height - gameBoard.height
            - bottomGameBoardBorder.height - pbLevelProgress.height
        anchors.top: pbLevelProgress.bottom
        visible: opacity > 0

        InGameButton {
            id: btnReset
            anchors.top: parent.top
            anchors.left: parent.left
            color: "red"
            caption: "Reset"

            onClicked: gameBoard.resetBoard()
        }

        InGameButton {
            id: btnRemoveAll
            anchors.top: parent.top
            anchors.left: btnReset.right
            caption: "Run"
            color: "steelblue"

            onClicked: gameBoard.removeAll()
        }

        InGameButton {
            id: btnLevelUp
            anchors.top: parent.top
            anchors.left: btnRemoveAll.right
            caption: "LevelUp"
            color: "blue"

            onClicked: {
                gameBoard.score = gameBoard.levelCap(gameBoard.level);
                gameBoard.removeAll();
            }
        }

        /* Second row of buttons */
        InGameButton {
            id: btnLoadTest
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            caption: "Test"
            color: "royalblue"

            onClicked: gameBoard.loadTestBoard()
        }

        InGameButton {
            id: btnShowHint
            anchors.bottom: parent.bottom
            anchors.left: btnLoadTest.right
            caption: "Hint"
            color: "green"

            onClicked: gameBoard.showHint()
        }

        InGameButton {
            id: btnMenu
            anchors.bottom: parent.bottom
            anchors.left: btnShowHint.right
            caption: "Menu"
            color: "red"

            onClicked: screen.state = "stateMainMenu"
        }

        InGameButton {
            id: btnChangeScreenSize

            anchors.bottom: parent.bottom
            anchors.left: btnMenu.right
            caption: "big"
            color: "blue"

            onClicked: {
                if (gameBoard.cellSize > 40)
                    gameBoard.cellSize = 40;
                else
                    gameBoard.cellSize = 80;
            }
        }
    }

    Text {
        id: gameTitle
        text: "<p align=\"center\">Free<br>Jeweled</p>"
        anchors.topMargin: 30*gameBoard.cellSize/40
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        font.pointSize: 36*gameBoard.cellSize/40
        font.family: titleFont.name
        color: "lightgray"

        Image {
            anchors.centerIn: parent
            width: 50*gameBoard.cellSize/40
            height: 50*gameBoard.cellSize/40
            visible: gameTitle.y > 0
            source: "pics/big/blueGem.title.png"
            Shine { anchors { leftMargin: 10*gameBoard.cellSize/40; topMargin: 10*gameBoard.cellSize/40 } }
        }
    }

    MainMenuButton {
        id: btnClassic
        caption: "CLASSIC"
        anchors.top: screen.top
        anchors.margins: gameTitle.height + gameTitle.anchors.topMargin + 40*gameBoard.cellSize/40
        color: "steelblue"
        onClicked: screen.state = "stateGame"
    }

    MainMenuButton {
        id: btnEndless
        caption: "ENDLESS"
        anchors.top: btnClassic.bottom
        anchors.margins: 10*gameBoard.cellSize/40
        color: "gray"
    }

    MainMenuButton {
        id: btnAction
        caption: "Action"
        anchors.top: btnEndless.bottom
        anchors.margins: 10*gameBoard.cellSize/40
        color: "gray"
    }

    MainMenuButton {
        id: btnAbout
        caption: "about"
        anchors.top: btnAction.bottom
        anchors.margins: 10*gameBoard.cellSize/40
        color: "steelblue"
        onClicked: screen.state = "stateAbout"
    }

    states: [
        State {
            name: "stateMainMenu"
            /* Main menu elements anchors */
            AnchorChanges { target: gameTitle; anchors.top: screen.top }
            AnchorChanges { target: btnClassic; anchors.horizontalCenter: screen.horizontalCenter }
            AnchorChanges { target: btnEndless; anchors.horizontalCenter: screen.horizontalCenter }
            AnchorChanges { target: btnAction; anchors.horizontalCenter: screen.horizontalCenter }
            AnchorChanges { target: btnAbout; anchors.horizontalCenter: screen.horizontalCenter }

            /* Game elements anchors */
            AnchorChanges { target: toolBar; anchors.top: screen.bottom }
            AnchorChanges { target: gameBoard; anchors.left: screen.right }
        },
        State {
            name: "stateGame"
            /* Main menu elements anchors */
            AnchorChanges { target: gameTitle; anchors.bottom: screen.top }
            AnchorChanges { target: btnClassic; anchors.right: screen.left }
            AnchorChanges { target: btnEndless; anchors.left: screen.right }
            AnchorChanges { target: btnAction; anchors.right: screen.left }
            AnchorChanges { target: btnAbout; anchors.left: screen.right }

            /* Game elements anchors */
            AnchorChanges { target: toolBar; anchors.top: pbLevelProgress.bottom }
            AnchorChanges { target: gameBoard; anchors.left: screen.left }
        },
        State {
            name: "stateAbout"
            /* Main menu elements anchors */
            AnchorChanges { target: gameTitle; anchors.bottom: screen.top }
            AnchorChanges { target: btnClassic; anchors.right: screen.left }
            AnchorChanges { target: btnEndless; anchors.left: screen.right }
            AnchorChanges { target: btnAction; anchors.right: screen.left }
            AnchorChanges { target: btnAbout; anchors.left: screen.right }

            /* Game elements anchors */
            AnchorChanges { target: toolBar; anchors.top: screen.bottom }

            /* Showing About dialog */
            PropertyChanges { target: dlgAbout; opacity: 1.0 }
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
                        btnAction,
                        btnAbout
                    ]
                    duration: 500;
                    easing.type: Easing.InOutQuad
                }

                ScriptAction {
                    script: {
                        setBackgroundSource();
                        if (gameBoard.hasSave()) {
                            dlgLoadSave.show();
                        } else {
                            gameBoard.newGame();
                        }
                    }
                }

                PropertyAction { target: bgrMainMenu; property: "visible"; value: false }
                PropertyAction { target: gameBoard; property: "opacity"; value: 1.0 }
                AnchorAnimation {
                    duration: 500;
                    targets: gameBoard;
                }

                ParallelAnimation {
                    PropertyAction { target: scoreBox; property: "state"; value: "stateNormal" }
                    AnchorAnimation { targets: toolBar; duration: 200 }
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
                ScriptAction {
                    script: {
                        if (!gameBoard.gameLost)
                            gameBoard.saveBoardStateToFile();
                    }
                }
                PropertyAction { target: gameBoard; property: "opacity"; value: 0.0 }
                PropertyAction { target: scoreBox; property: "state"; value: "stateHidden" }
                AnchorAnimation { targets: toolBar; duration: 400; }
                PropertyAction { target: bgrMainMenu; property: "visible"; value: true }
                AnchorAnimation {
                    targets: [
                        gameTitle,
                        btnClassic,
                        btnEndless,
                        btnAction,
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
