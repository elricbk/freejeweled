import Qt 4.7

Item {
    id: cloudItem
    width: /*gameCanvas.blockSize*/ 30
    height: /*gameCanvas.blockSize*/ 30
    z: 5
    property int animationDuration: 9000

    Image {
        id: cloudImage
        anchors.centerIn: parent
        source: "pics/effects/arrows.png"

        SequentialAnimation {
            running: cloudItem.visible
            loops: Animation.Infinite
            NumberAnimation { target: cloudImage; property: "scale"; to: 0.8; duration: 150 }
            NumberAnimation { target: cloudImage; property: "scale"; to: 1.0; duration: 150 }
            NumberAnimation { target: cloudImage; property: "scale"; to: 0.8; duration: 150 }
            NumberAnimation { target: cloudImage; property: "scale"; to: 1.0; duration: 150 }
            PauseAnimation { duration: 500 }
        }
    }

//    NumberAnimation {
//        target: cloudImage
//        property: "rotation"
//        to: 360
//        duration: animationDuration
//        loops: Animation.Infinite
//        running: cloudItem.visible
//    }
}
