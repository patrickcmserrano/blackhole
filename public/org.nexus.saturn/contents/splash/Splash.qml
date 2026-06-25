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

        // Center Saturn System
        Item {
            id: saturnSystem
            anchors.centerIn: parent
            width: 450
            height: 450

            Canvas {
                id: saturnCanvas
                anchors.fill: parent
                antialiasing: true

                property real animationTime: 0.0

                NumberAnimation on animationTime {
                    from: 0.0
                    to: 2 * Math.PI
                    duration: 35000 // Slow cosmological rotation
                    loops: Animation.Infinite
                    running: true
                }

                onAnimationTimeChanged: requestPaint()

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    var cx = width / 2;
                    var cy = height / 2;

                    // Angle of ring tilt
                    var tiltAngle = -0.22; // radians (about -12 degrees)

                    // Helper to draw ring loops
                    function drawRings(isFront) {
                        ctx.save();
                        ctx.translate(cx, cy);
                        ctx.rotate(tiltAngle);

                        ctx.lineWidth = 1.6;

                        var ringRadii = [88, 93, 103, 116, 122, 132];
                        var ringColors = [
                            "rgba(224, 186, 120, 0.4)", // Inner dusty amber
                            "rgba(240, 217, 181, 0.65)", // Bright A Ring
                            "rgba(253, 244, 226, 0.8)",  // B Ring (brightest)
                            "rgba(120, 100, 80, 0.25)",  // Cassini division (faint)
                            "rgba(210, 180, 140, 0.5)",  // C Ring
                            "rgba(180, 150, 120, 0.2)"   // Outer dusty ring
                        ];

                        for (var i = 0; i < ringRadii.length; i++) {
                            var r = ringRadii[i];
                            
                            ctx.strokeStyle = ringColors[i];
                            ctx.beginPath();
                            
                            ctx.save();
                            // Scale the y-axis to create the perspective tilt
                            ctx.scale(1, 0.35);
                            if (isFront) {
                                ctx.arc(0, 0, r, 0, Math.PI); // Front half
                            } else {
                                ctx.arc(0, 0, r, Math.PI, 2 * Math.PI); // Back half
                            }
                            ctx.restore();
                            ctx.stroke();
                        }
                        ctx.restore();
                    }

                    // 1. Draw BACK half of rings (hidden behind planet)
                    drawRings(false);

                    // 2. Draw Saturn Planet Sphere (with horizontal bands)
                    ctx.save();
                    ctx.beginPath();
                    ctx.arc(cx, cy, 55, 0, 2 * Math.PI);
                    ctx.clip(); // restrict drawing to planet boundaries

                    // Radial gradient for 3D sphere lighting
                    var planetGrad = ctx.createRadialGradient(cx - 18, cy - 18, 10, cx, cy, 58);
                    planetGrad.addColorStop(0.0, "#FFF5D6"); // Sun highlight
                    planetGrad.addColorStop(0.5, "#E2C18F"); // Core beige
                    planetGrad.addColorStop(1.0, "#96733E"); // Dark shadow edge
                    ctx.fillStyle = planetGrad;
                    ctx.fill();

                    // Planet atmospheric bands (horizontal stripes)
                    var bandOffsets = [-38, -24, -10, 4, 18, 32];
                    var bandHeights = [8, 10, 6, 9, 7, 11];
                    var bandColors = [
                        "rgba(139, 101, 57, 0.22)", // Muted amber band
                        "rgba(255, 255, 255, 0.12)", // Bright zone
                        "rgba(188, 143, 93, 0.26)",
                        "rgba(139, 101, 57, 0.18)",
                        "rgba(255, 255, 255, 0.08)",
                        "rgba(90, 70, 45, 0.28)"
                    ];

                    for (var j = 0; j < bandOffsets.length; j++) {
                        ctx.fillStyle = bandColors[j];
                        ctx.fillRect(cx - 60, cy + bandOffsets[j], 120, bandHeights[j]);
                    }
                    ctx.restore();

                    // 3. Draw FRONT half of rings (overlays the planet)
                    drawRings(true);

                    // 4. Draw orbiting moons (tiny glowing white points)
                    var moonOrbitTime = animationTime;
                    var moons = [
                        { r: 165, speed: 1.3, size: 2.2, color: "#E0F2FE" },
                        { r: 205, speed: 0.8, size: 1.8, color: "#F0FDF4" }
                    ];

                    for (var k = 0; k < moons.length; k++) {
                        var m = moons[k];
                        var angle = moonOrbitTime * m.speed;
                        
                        // Circular orbit projected using the tiltAngle
                        var mx = m.r * Math.cos(angle);
                        var my_local = m.r * 0.35 * Math.sin(angle);
                        
                        var px = cx + mx * Math.cos(tiltAngle) - my_local * Math.sin(tiltAngle);
                        var py = cy + mx * Math.sin(tiltAngle) + my_local * Math.cos(tiltAngle);

                        ctx.fillStyle = m.color;
                        ctx.beginPath();
                        ctx.arc(px, py, m.size, 0, 2 * Math.PI);
                        ctx.fill();
                    }
                }
            }
        }

        // Title and Subtitle
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: saturnSystem.bottom
            anchors.topMargin: 20
            spacing: 8

            Text {
                text: "SATURN"
                font.family: "JetBrains Mono"
                font.pointSize: 22
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                
                // Add a glowing effect using standard Text properties
                style: Text.Outline
                styleColor: "#66e0ba78"
            }

            Text {
                text: "RINGS OF GOLD // INTERACTIVE UNIVERSE"
                font.family: "JetBrains Mono"
                font.pointSize: 8
                color: "#E2C18F" // Golden Amber
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
                    // Fades from default grey to amber as Plasma advances stages
                    color: index < root.stage ? "#E2C18F" : "#333333"
                    
                    Behavior on color { 
                        ColorAnimation { duration: 300 } 
                    }
                }
            }
        }
    }
}
