import QtQuick

Rectangle {
    id: root
    color: "black"

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

        // Center Accretion Disk System
        Item {
            id: blackHoleSystem
            anchors.centerIn: parent
            width: 450
            height: 450

            // 1. Layer 1: Outer Accretion Disk (Glow and Main Colors)
            Canvas {
                id: outerDisk
                anchors.fill: parent
                antialiasing: true

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    var cx = width / 2;
                    var cy = height / 2;

                    // Radial Gradient for Accretion Disk
                    var grad = ctx.createRadialGradient(cx, cy, 30, cx, cy, 180);
                    grad.addColorStop(0.0, "black");
                    grad.addColorStop(0.2, "#7209B7"); // Synth Violet
                    grad.addColorStop(0.5, "#F72585"); // Magenta Neon
                    grad.addColorStop(0.8, "#00F0FF"); // Quantum Cyan
                    grad.addColorStop(1.0, "transparent");

                    ctx.fillStyle = grad;
                    ctx.beginPath();
                    ctx.arc(cx, cy, 180, 0, 2 * Math.PI);
                    ctx.fill();
                }

                // Smooth rotation animation
                RotationAnimator {
                    target: outerDisk
                    from: 0
                    to: 360
                    duration: 25000 // Slow geological rotation (25s)
                    loops: Animation.Infinite
                    running: true
                }
            }

            // 2. Layer 2: Spacetime Gravity Waves (Orbiting rings)
            Canvas {
                id: gravityWaves
                anchors.fill: parent
                antialiasing: true

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    var cx = width / 2;
                    var cy = height / 2;

                    ctx.lineWidth = 1.2;
                    
                    // Draw multiple orbital rings with varying opacity
                    for (var r = 50; r < 140; r += 20) {
                        var alpha = (1.0 - (r / 140.0)) * 0.4;
                        ctx.strokeStyle = "rgba(0, 240, 255, " + alpha + ")"; // Quantum Cyan tint
                        ctx.beginPath();
                        ctx.arc(cx, cy, r, 0, 2 * Math.PI);
                        ctx.stroke();

                        // Add small starlight points on the orbits
                        ctx.fillStyle = "rgba(255, 255, 255, " + (alpha * 1.5) + ")";
                        for (var a = 0; a < 2 * Math.PI; a += Math.PI / 4) {
                            var px = cx + Math.cos(a) * r;
                            var py = cy + Math.sin(a) * r;
                            ctx.beginPath();
                            ctx.arc(px, py, 1, 0, 2 * Math.PI);
                            ctx.fill();
                        }
                    }
                }

                // Fast reverse rotation to simulate counter-orbit particles
                RotationAnimator {
                    target: gravityWaves
                    from: 360
                    to: 0
                    duration: 15000 // 15s reverse
                    loops: Animation.Infinite
                    running: true
                }
            }

            // 3. Layer 3: The Event Horizon (The Void Center)
            Rectangle {
                anchors.centerIn: parent
                width: 70
                height: 70
                radius: 35
                color: "black"
                border.width: 3
                border.color: "#00F0FF" // Glowing cyan border

                // Subtle scaling pulse animation representing energy extraction
                SequentialAnimation on scale {
                    loops: Animation.Infinite
                    PropertyAnimation { to: 1.05; duration: 4000; easing.type: Easing.InOutQuad }
                    PropertyAnimation { to: 0.95; duration: 4000; easing.type: Easing.InOutQuad }
                }
            }
        }

        // Title and Subtitle
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: blackHoleSystem.bottom
            anchors.topMargin: 20
            spacing: 8

            Text {
                text: "BLACK HOLE"
                font.family: "JetBrains Mono"
                font.pointSize: 22
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                
                // Add a glowing effect using standard Text properties
                style: Text.Outline
                styleColor: "#6600f0ff"
            }

            Text {
                text: "AT THE EDGE OF REALITY // INTERACTIVE UNIVERSE"
                font.family: "JetBrains Mono"
                font.pointSize: 8
                color: "#4CC9F0" // Electric Blue
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
                    // Fades from default grey to cyan as Plasma advances stages
                    color: index < root.stage ? "#00F0FF" : "#333333"
                    
                    Behavior on color { 
                        ColorAnimation { duration: 300 } 
                    }
                }
            }
        }
    }
}
