import Qt 4.7

Item {
    id: dlgAbout
    anchors.fill: parent
    Text {
        id: dlgTitle
        anchors { horizontalCenter: dlgAbout.horizontalCenter; top: dlgAbout.top; margins: 10 }
        text: "About"
        color: "white"
        font.bold: true
        font.pointSize: 25
    }
    Text {
        anchors { centerIn:dlgAbout; margins: 10 }
        width: dlgAbout.width - 2*anchors.margins
        font.pointSize: 14
        color: "white"
        wrapMode: Text.WordWrap
        text: "<b>FreeJeweled</b> is a free Bejeweled2 inspired game"
            + "<p align=\"center\"><b>Game Author</b></p>"
            + "<p align=\"center\">Boris Kuchin, elricbk@gmail.com</p>"
            + "<p align=\"center\"><b>Gem Images</b></p>"
            + "<p align=\"center\">Sebastien Delestaing, Gweled creator"
            + "<p align=\"center\"><b>Background Images</b></p>"
            + "<p align=\"center\">Cosmos Packages by #resurgere on devianArt.com";
    }
}
