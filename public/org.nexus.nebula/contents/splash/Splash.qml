import QtQuick
import QtWebEngine

Rectangle {
    id: root
    color: "#050510" // Deep space background

    // KDE Plasma sets this property from 1 to 6 during desktop load.
    property int stage: 0
    onStageChanged: {
        if (stage === 6) {
            root.opacity = 0.0; // Fade-out look-and-feel window on completion
        }
    }

    Behavior on opacity { 
        OpacityAnimator { duration: 500 } 
    }

    WebEngineView {
        id: webglWebEngine
        anchors.fill: parent
        url: Qt.resolvedUrl("index.html?scene=nebula&splash=true")
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
