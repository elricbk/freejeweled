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

        onLevelUp: {
            pbLevelProgress.minimum = gameBoard.score;
            background.source = getBackgroundSource();
            levelUpAnimation.start();
            gameBoard.resetBoard();
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
        height: 60 /* cellSize, actually */

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

    Text {
        id: txtLevelUp
        color: "gold"
        font.family: gameFont.name
        font.pointSize: 38
        font.bold: true
        text: "LEVEL UP!"
        anchors.centerIn: gameBoard
        style: Text.Outline
        smooth: true
        styleColor: "red"
        z: 5
        opacity: 0

        SequentialAnimation {
            id: levelUpAnimation

            ParallelAnimation {
                NumberAnimation { target: txtLevelUp; properties: "opacity"; from: 0; to: 1; duration: 400 }
                NumberAnimation { target: txtLevelUp; properties: "scale"; from: 0.1; to: 1; duration: 400 }
            }

//            PauseAnimation { duration: 500 }
            NumberAnimation { target: txtLevelUp; properties: "scale"; from: 1; to: 0.7; duration: 400 }
            NumberAnimation { target: txtLevelUp; properties: "scale"; from: 0.7; to: 1; duration: 400 }

            PauseAnimation { duration: 700 }
            ParallelAnimation {
                NumberAnimation { target: txtLevelUp; properties: "opacity"; from: 1; to: 0; duration: 1000 }
                NumberAnimation { target: txtLevelUp; properties: "scale"; from: 1; to: 0.1; duration: 1000 }
            }
        }
    }

    Item {
        id: toolBar
        width: parent.width
        height: parent.height - scoreBox.height - topGameBoardBorder.height - gameBoard.height - bottomGameBoardBorder.height - pbLevelProgress.height
        anchors.top: pbLevelProgress.bottom

        SimpleButton {
            id: btnReset
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            color: "red"
            caption: "Reset"

            onClicked: gameBoard.resetBoard()
        }

        SimpleButton {
            id: btnRemoveAll
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: btnReset.right
            anchors.leftMargin: 10
            caption: "Run"
            color: "steelblue"

            onClicked: gameBoard.removeAll()
        }

        SimpleButton {
            id: btnLoadTest
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: btnRemoveAll.right
            anchors.leftMargin: 10
            caption: "Test"
            color: "green"

            onClicked: {
                gameBoard.loadBoardStateFromFile();
                pbLevelProgress.maximum = gameBoard.levelCap(gameBoard.level);
                pbLevelProgress.minimum = gameBoard.levelCap(gameBoard.level - 1);
            }

        }

        SimpleButton {
            id: btnLevelUp
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: btnLoadTest.right
            anchors.leftMargin: 10
            caption: "LevelUp"
            color: "gold"

            onClicked: gameBoard.score = gameBoard.levelCap(gameBoard.level)
        }
    }
}