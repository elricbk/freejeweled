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
        anchors.bottom: gameBoard.top
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
        anchors.centerIn: parent

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

        onLevelChanged: {
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
        maximum: 5*gameBoard.level*(gameBoard.level + 3)/2*60
        value: gameBoard.score
        anchors.topMargin: 2
    }

    Text {
        color: "white"
        font.family: gameFont.name
        font.pointSize: 16
        font.bold: true
        text: "     " + gameBoard.score
        anchors.bottom: topGameBoardBorder.top
        anchors.left: parent.left
    }

    Text {
        color: "white"
        font.family: gameFont.name
        font.pointSize: 16
        font.bold: true
        text: "Level " + gameBoard.level +" "
        anchors.bottom: topGameBoardBorder.top
        anchors.right: parent.right
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

    SimpleButton {
        id: btnReset
        anchors.bottom: parent.bottom
        color: "red"
        caption: "Reset"

        onClicked: gameBoard.resetBoard()
    }

    SimpleButton {
        id: btnRemoveAll
        anchors.bottom: parent.bottom
        anchors.left: btnReset.right
        caption: "Run"
        color: "steelblue"

        onClicked: gameBoard.removeAll()
    }

    SimpleButton {
        id: btnLoadTest
        anchors.bottom: parent.bottom
        anchors.left: btnRemoveAll.right
        caption: "Test"
        color: "green"

        onClicked: gameBoard.loadTestBoard()
    }

    SimpleButton {
        id: btnLevelUp
        anchors.bottom: parent.bottom
        anchors.left: btnLoadTest.right
        caption: "LevelUp"
        color: "gold"

        onClicked: gameBoard.level += 1
    }
}
