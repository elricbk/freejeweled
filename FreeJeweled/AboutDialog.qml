import Qt 4.7

Item {
    id: dlgAbout
    anchors.fill: parent

    FontLoader { id: aboutFont; source: "fonts/forgotte.ttf" }
    Rectangle {
        anchors.fill: dlgAbout
        color: "black"
        opacity: 0.3
    }

    Text {
        id: dlgTitle
        anchors { horizontalCenter: dlgAbout.horizontalCenter; top: dlgAbout.top; margins: 10 }
        text: "About"
        color: "white"
        font.bold: true
        font.pointSize: 36
        font.family: aboutFont.name
    }

    Text {
        anchors { horizontalCenter: dlgAbout.horizontalCenter; margins: 5; top: dlgTitle.bottom }
        width: dlgAbout.width - 2*anchors.margins
        font.pointSize: 16
        font.family: aboutFont.name
        color: "white"
        wrapMode: Text.WordWrap
        text: "<b>FreeJeweled</b> is a free Bejeweled2 inspired game"
            + "<p align=\"center\"><b>Game Author</b></p>"
            + "<p align=\"center\">Boris Kuchin, elricbk@gmail.com</p>"
            + "<p align=\"center\"><b>Gem Images</b></p>"
            + "<p align=\"center\">Sebastien Delestaing, Gweled creator"
            + "<p align=\"center\"><b>Background Images</b></p>"
            + "<p align=\"center\">Cosmos Packages by #resurgere on devianArt.com"
            + "<p align=\"center\"><b>Fonts</b></p>"
            + "<p align=\"center\">Pirulen, MailRays, RedCircle, ForgottenFuturist fonts from 1001freefonts.com";
    }
}
