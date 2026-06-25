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

        // Center Neutron Star System
        Item {
            id: neutronStarSystem
            anchors.centerIn: parent
            width: 450
            height: 450

            // Canvas to draw magnetic loops, polar jets, and the core glow
            Canvas {
                id: starCanvas
                anchors.fill: parent
                antialiasing: true
                
                // animationTime drives the repaint of the Canvas animations
                property real animationTime: 0.0
                
                NumberAnimation on animationTime {
                    from: 0.0
                    to: 2 * Math.PI
                    duration: 4000
                    loops: Animation.Infinite
                    running: true
                }
                
                onAnimationTimeChanged: requestPaint()

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    var cx = width / 2;
                    var cy = height / 2;
                    
                    // 1. Draw polar jets (flaring up and down)
                    var jetWidth = 22 + 6 * Math.sin(animationTime * 8); // fluctuating width representing pulsar frequency
                    
                    // Top Jet
                    var gradTop = ctx.createLinearGradient(cx, cy, cx, 0);
                    gradTop.addColorStop(0.0, "white");
                    gradTop.addColorStop(0.15, "rgba(0, 240, 255, 0.9)");
                    gradTop.addColorStop(0.5, "rgba(67, 97, 238, 0.4)");
                    gradTop.addColorStop(1.0, "transparent");
                    
                    ctx.fillStyle = gradTop;
                    ctx.beginPath();
                    ctx.moveTo(cx, cy);
                    ctx.lineTo(cx - jetWidth, 0);
                    ctx.lineTo(cx + jetWidth, 0);
                    ctx.closePath();
                    ctx.fill();
                    
                    // Bottom Jet
                    var gradBot = ctx.createLinearGradient(cx, cy, cx, height);
                    gradBot.addColorStop(0.0, "white");
                    gradBot.addColorStop(0.15, "rgba(0, 240, 255, 0.9)");
                    gradBot.addColorStop(0.5, "rgba(67, 97, 238, 0.4)");
                    gradBot.addColorStop(1.0, "transparent");
                    
                    ctx.fillStyle = gradBot;
                    ctx.beginPath();
                    ctx.moveTo(cx, cy);
                    ctx.lineTo(cx - jetWidth, height);
                    ctx.lineTo(cx + jetWidth, height);
                    ctx.closePath();
                    ctx.fill();

                    // 2. Draw Magnetic Field Lines (Concentric, rotating magnetosphere loops)
                    ctx.lineWidth = 1.2;
                    for (var i = 0; i < 4; i++) {
                        var angle = (i * Math.PI / 4) + animationTime * 0.15;
                        var rx = 110 + 30 * Math.sin(animationTime + i);
                        var ry = 45 + 15 * Math.cos(animationTime + i);
                        
                        ctx.strokeStyle = "rgba(76, 201, 240, 0.25)"; // Electric Cyan
                        ctx.save();
                        ctx.translate(cx, cy);
                        ctx.rotate(angle);
                        ctx.beginPath();
                        ctx.ellipse(0, 0, rx, ry, 0, 0, 2 * Math.PI);
                        ctx.stroke();
                        ctx.restore();
                    }
                    
                    // 3. Draw Neutron Star Core Glow
                    var coreGlow = ctx.createRadialGradient(cx, cy, 10, cx, cy, 70);
                    coreGlow.addColorStop(0.0, "white");
                    coreGlow.addColorStop(0.25, "#00F0FF"); // Quantum Cyan
                    coreGlow.addColorStop(0.65, "#4361EE"); // Royal Blue
                    coreGlow.addColorStop(1.0, "transparent");
                    
                    ctx.fillStyle = coreGlow;
                    ctx.beginPath();
                    ctx.arc(cx, cy, 70, 0, 2 * Math.PI);
                    ctx.fill();
                }
            }
            
            // Ultra-dense stellar core (flashes rapidly)
            Rectangle {
                anchors.centerIn: parent
                width: 28
                height: 28
                radius: 14
                color: "white"
                border.width: 2.5
                border.color: "#00F0FF"

                // Fast core spin animation (flashes like a real pulsar)
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    PropertyAnimation { to: 0.65; duration: 40; easing.type: Easing.InOutQuad }
                    PropertyAnimation { to: 1.0; duration: 40; easing.type: Easing.InOutQuad }
                }
            }
        }

        // Title and Subtitle
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: neutronStarSystem.bottom
            anchors.topMargin: 20
            spacing: 8

            Text {
                text: "NEUTRON STAR"
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
                text: "MAGNETIC DYNAMO // INTERACTIVE UNIVERSE"
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
