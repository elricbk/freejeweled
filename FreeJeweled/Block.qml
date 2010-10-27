import Qt 4.7
import Qt.labs.particles 1.0
import com.mycompany.gemcell 1.0

GemCell {
    id: block

    property int type: 0
    property bool spawned: false
    property bool normalDying: false
    property bool explodeDying: false
    property bool explodable: false
    property bool selected: false
    property int behaviorPause: 0
    property int srcSize: 80


    width: 40
    height: 40
    opacity: {
        if ((x < -width/2) || (y < -width/2) || (x >= width*8) || (y >= height*8))
            return 0;
        else
            return 1;
    }

    function picsDir() {
        if (g_scaleFactor > 1)
            return "pics/big/";
        else
            return "pics/big/";
    }

    Image {
        id: img
        anchors.fill: parent
//        source: {
//            if (modifier == GemCell.HyperCube) {
//                return (picsDir() + "hyperCube.resized.png");
//            } else if (type == 1)
//                return (picsDir() + "redGem.resized.png");
//            else if (type == 2)
//                return (picsDir() + "blueGem.resized.png");
//            else if (type == 3)
//                return (picsDir() + "greenGem.resized.png");
//            else if (type == 4)
//                return (picsDir() + "purpleGem.resized.png");
//            else if (type == 5)
//                return (picsDir() + "whiteGem.resized.png");
//            else if (type == 6)
//                return (picsDir() + "orangeGem.resized.png");
//            else if (type == 0)
//                return (picsDir() + "yellowGem.resized.png");
//        }
        source: {
            if (modifier == GemCell.HyperCube) {
                return (picsDir() + "hyperCube.svg");
            } else if (type == 1)
                return (picsDir() + "redGem.svg");
            else if (type == 2)
                return (picsDir() + "blueGem.svg");
            else if (type == 3)
                return (picsDir() + "greenGem.svg");
            else if (type == 4)
                return (picsDir() + "purpleGem.svg");
            else if (type == 5)
                return (picsDir() + "whiteGem.svg");
            else if (type == 6)
                return (picsDir() + "orangeGem.svg");
            else if (type == 0)
                return (picsDir() + "yellowGem.svg");
        }
        opacity: 1
        smooth: false
        sourceSize.width: srcSize
        sourceSize.height: srcSize
		
        Behavior on opacity {
            NumberAnimation { properties: "opacity"; duration: 400 }
        }

        Behavior on scale {
            NumberAnimation { properties: "scale"; duration: 400 }
        }

        Shine {
            visible: (modifier == GemCell.Explosive)
            anchors.top: parent.top
            anchors.left: parent.left
        }

        Cloud {
            visible: (modifier == GemCell.RowColumnRemove)
            anchors.fill: parent
        }
    }

    Behavior on x {
        enabled: spawned && behaviorEnabled
        SpringAnimation { spring: 2; damping: 0.2; duration: 200 }
    }

    Behavior on y {
        enabled: behaviorEnabled
        SequentialAnimation {
            PauseAnimation { duration: Math.floor(behaviorPause*(1 + Math.random()*0.4 - 0.2)) }
            SpringAnimation { spring: 2; damping: 0.2; duration: 200 }
//            PropertyAnimation { duration: 400; easing.type: Easing.OutBack }
            ScriptAction { script: behaviorPause = 0 }
        }
    }

    states: [
        State {
            name: "Normal"
            when: spawned == true && timeToDie == false && explodedOnce == false
            PropertyChanges { target: img; opacity: 1 }
        },
        State {
            name: "ExplodeDeathState"
            when: timeToDie == true && explodedOnce == true
            StateChangeScript {
                script: {
                    if (explodable) {
                        particles.burst(100)
                    } else {
                        particles.burst(50)
                    }
                }
            }
            PropertyChanges { target: img; opacity: 0 }
        },
        State {
            name: "NormalDeathState"
            when: timeToDie == true && explodedOnce == false
            PropertyChanges { target: img; scale: 0.1 }
            PropertyChanges { target: img; opacity: 0 }
        }
    ]

    Particles {
        id: particles

        width: 1; height: 1
        anchors.centerIn: parent

        emissionRate: 0
        lifeSpan: 500; lifeSpanDeviation: 400
        angle: 0; angleDeviation: 360;
        velocity: 200; velocityDeviation: 120
        source: {
            if (type == 1)
                return "pics/stars/redStar.new.png";
            else if (type == 2)
                return "pics/stars/blueStar.new.png";
            else if (type == 3)
                return "pics/stars/greenStar.new.png";
            else if (type == 4)
                return "pics/stars/purpleStar.new.png";
            else if (type == 5)
                return "pics/stars/whiteStar.new.png";
            else if (type == 6)
                return "pics/stars/orangeStar.new.png";
            else
                return "pics/stars/yellowStar.new.png";
        }
    }
}
