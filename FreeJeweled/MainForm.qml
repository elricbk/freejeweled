import Qt 4.7
//import "qml"
import com.mycompany.gemcell 1.0

Rectangle {
    id: screen

    width: 320
    height: 480
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

    Rectangle {
        id: topGameBoardBorder
        color: "white"
        opacity: 0.5
        anchors.top: scoreBox.bottom
        height: 5
        width: parent.width
    }

    Rectangle {
        id: bottomGameBoardBorder
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

            opacity: {
                if (gameBoard.hintVisible)
                    return 1;
                else
                    return 0;
            }
            z: 5
            ParallelAnimation {
                running: gameBoard.hintVisible
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
            onClosed: gameBoard.newGame()
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
        anchors.top: bottomGameBoardBorder.bottom
        color: "white"
        secondColor: "green"
        height: 20
        maximum: gameBoard.levelCap(gameBoard.level)
        value: gameBoard.score
        anchors.topMargin: 2
    }

    Item {
        id: scoreBox

        width: parent.width
        height: 60 /* cellSize*1.5, actually */

        anchors.top: parent.top

        Text {
            color: "white"
            font.family: gameFont.name
            font.pointSize: 16
            font.bold: true
            text: gameBoard.score
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottomMargin: 5
        }

        Text {
            color: "white"
            font.family: gameFont.name
            font.pointSize: 16
            font.bold: true
            text: "Level " + gameBoard.level +" "
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottomMargin: 5
        }
    }

    MsgText {
        id: msgText
    }

    Item {
        id: toolBar
        width: parent.width
        height: parent.height - scoreBox.height - topGameBoardBorder.height - gameBoard.height - bottomGameBoardBorder.height - pbLevelProgress.height
        anchors.top: pbLevelProgress.bottom

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
    }
}
