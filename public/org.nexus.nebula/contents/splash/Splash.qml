import QtQuick

Rectangle {
    id: root
    color: "#050510" // Deep space background

    // KDE Plasma sets this property from 1 to 6 during desktop load.
    property int stage: 0
    onStageChanged: {
        if (stage >= 2) {
            contentArea.opacity = 1.0;
        }
        if (stage === 6) {
            root.opacity = 0.0; // Fade-out look-and-feel window on completion
        }
    }

    Behavior on opacity { 
        OpacityAnimator { duration: 500 } 
    }

    Item {
        id: contentArea
        anchors.fill: parent
        opacity: 0.0
        
        Behavior on opacity { 
            OpacityAnimator { duration: 800 } 
        }

        // Center Nebula Visualization System
        Item {
            id: nebulaSystem
            anchors.fill: parent

            Canvas {
                id: nebulaCanvas
                anchors.fill: parent
                antialiasing: true

                property real animationTime: 0.0

                NumberAnimation on animationTime {
                    from: 0.0
                    to: 2 * Math.PI
                    duration: 25000 // Slow organic drift duration
                    loops: Animation.Infinite
                    running: true
                }

                onAnimationTimeChanged: requestPaint()

                // Static list of stars generated once
                property var stars: []

                Component.onCompleted: {
                    var tempStars = [];
                    for (var i = 0; i < 75; i++) {
                        tempStars.push({
                            x: Math.random(),
                            y: Math.random(),
                            size: 0.6 + Math.random() * 1.6,
                            phase: Math.random() * 2 * Math.PI,
                            speed: 0.4 + Math.random() * 1.2
                        });
                    }
                    stars = tempStars;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    var w = width;
                    var h = height;

                    // Deep space background
                    ctx.fillStyle = "#050510";
                    ctx.fillRect(0, 0, w, h);

                    // 1. Draw twinkling background stars
                    for (var i = 0; i < stars.length; i++) {
                        var star = stars[i];
                        var opacity = 0.2 + 0.8 * Math.abs(Math.sin(animationTime * star.speed + star.phase));
                        ctx.fillStyle = "rgba(255, 255, 255, " + opacity + ")";
                        ctx.beginPath();
                        ctx.arc(star.x * w, star.y * h, star.size, 0, 2 * Math.PI);
                        ctx.fill();
                    }

                    // Soft screen blending for additive gas clouds
                    ctx.globalCompositeOperation = "screen";

                    // 2. Draw drifting gas clouds (glowing nebulae)
                    // 3 pillars/clouds representing Sulfur Gold, Oxygen Cyan, Hydrogen Pink
                    var cx = w / 2;
                    var cy = h / 2;

                    var clouds = [
                        {
                            x: cx - 60 + 35 * Math.sin(animationTime * 0.5),
                            y: cy - 40 + 30 * Math.cos(animationTime * 0.35),
                            r: 220,
                            color0: "rgba(255, 204, 51, 0.25)", // Sulfur Gold
                            color1: "rgba(255, 204, 51, 0.0)"
                        },
                        {
                            x: cx + 80 + 40 * Math.cos(animationTime * 0.4),
                            y: cy - 60 + 35 * Math.sin(animationTime * 0.6),
                            r: 240,
                            color0: "rgba(0, 255, 255, 0.22)", // Oxygen Cyan
                            color1: "rgba(0, 255, 255, 0.0)"
                        },
                        {
                            x: cx + 10 + 30 * Math.sin(animationTime * 0.7),
                            y: cy + 70 + 40 * Math.cos(animationTime * 0.5),
                            r: 200,
                            color0: "rgba(255, 0, 102, 0.18)", // Hydrogen Pink
                            color1: "rgba(255, 0, 102, 0.0)"
                        }
                    ];

                    for (var j = 0; j < clouds.length; j++) {
                        var c = clouds[j];
                        var grad = ctx.createRadialGradient(c.x, c.y, 5, c.x, c.y, c.r);
                        grad.addColorStop(0.0, c.color0);
                        grad.addColorStop(0.5, c.color0.replace("0.25", "0.1").replace("0.22", "0.09").replace("0.18", "0.07"));
                        grad.addColorStop(1.0, c.color1);
                        
                        ctx.fillStyle = grad;
                        ctx.beginPath();
                        ctx.arc(c.x, c.y, c.r, 0, 2 * Math.PI);
                        ctx.fill();
                    }
                }
            }
        }

        // Title and Subtitle
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Math.round(parent.height * 0.2)
            spacing: 8

            Text {
                text: "NEBULA"
                font.family: "JetBrains Mono"
                font.pointSize: 22
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                
                // Add a glowing effect using standard Text properties
                style: Text.Outline
                styleColor: "#66a853f7"
            }

            Text {
                text: "PILLARS OF CREATION // INTERACTIVE UNIVERSE"
                font.family: "JetBrains Mono"
                font.pointSize: 8
                color: "#E2C391" // Soft Dust Gold
                opacity: 0.8
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        // Progress Dots (Corresponds to Boot Stages 1 to 5)
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Math.round(parent.height * 0.08)
            spacing: 14

            Repeater {
                model: 5
                Rectangle {
                    width: 6; height: 6; radius: 3
                    // Fades from default grey to purple as Plasma advances stages
                    color: index < root.stage ? "#A853F7" : "#333333"
                    
                    Behavior on color { 
                        ColorAnimation { duration: 300 } 
                    }
                }
            }
        }
    }
}
