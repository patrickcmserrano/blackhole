import QtQuick
import QtWebEngine

Rectangle {
    id: root
    color: "black"

    // KDE Plasma sets this property from 1 to 6 during desktop load.
    property int stage: 0
    onStageChanged: {
        webglWebEngine.runJavaScript("if (window.setSplashStage) window.setSplashStage(" + stage + ");");
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
        url: Qt.resolvedUrl("index.html?scene=blackhole&splash=true")

        onLoadingChanged: {
            if (loading === WebEngineView.LoadSucceededStatus) {
                runJavaScript("if (window.setSplashStage) window.setSplashStage(" + root.stage + ");");
            }
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
