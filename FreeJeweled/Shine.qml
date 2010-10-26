import Qt 4.7

Item {
    id: shineItem
    width: /*gameCanvas.blockSize*/ 30*g_scaleFactor
    height: /*gameCanvas.blockSize*/ 30*g_scaleFactor
    z: 5
    property int animationDuration: 9000

    Image {
        id: firstShine
        opacity: 0.8
        anchors.fill: parent
        source: "pics/effects/shine.png"
    }

    Image {
        id: secondShine
        anchors.fill: parent
        source: "pics/effects/shine.png"
    }

    ParallelAnimation {
        running: shineItem.visible
        NumberAnimation { target: firstShine; property: "rotation"; to: 360; duration: animationDuration; loops: Animation.Infinite }
        NumberAnimation { target: secondShine; property: "rotation"; to: -360; duration: animationDuration/2; loops: Animation.Infinite }
        SequentialAnimation {
            loops: Animation.Infinite
            NumberAnimation { target: secondShine; property: "opacity"; to: 0.0; duration: animationDuration/8 }
            NumberAnimation { target: secondShine; property: "opacity"; to: 1.0; duration: animationDuration/8 }
        }
    }
}
