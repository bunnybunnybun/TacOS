import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: ramButton
    property alias ramPercent: freeMemory.ramPercent
    contentItem: Label {
        id: freeMemory
        text: "RAM: " + ramPercent + "%"
        font.pixelSize: misc.buttonFontSize
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        property string ramPercent: "N/A"

        Timer {
            id: ramTimer
            interval: 500
            running: true
            repeat: true
            onTriggered: getRamUsage.running = true
        }

        Process {
            id: getRamUsage
            command: ["bash", "-c", "free | awk '/Mem/ {printf \"%.1f\", $3/$2 * 100}'"]

            stdout: StdioCollector {
                onStreamFinished: {
                    freeMemory.ramPercent = this.text.trim()
                }
            }
        }
    }
    Layout.alignment: Qt.AlignRight
    Layout.preferredHeight: misc.buttonPreferredHeight
    Layout.preferredWidth: 92
    onClicked: resourceUsagePopup.visible = !resourceUsagePopup.visible
    background: Rectangle {
        bottomLeftRadius: misc.buttonRadius
        bottomRightRadius: misc.buttonRadius
        topLeftRadius: misc.buttonRadius
        topRightRadius: misc.buttonRadius
        color: parent.down ? colors.buttonClickedColor :
            parent.hovered ? colors.buttonHoverColor : colors.buttonColor
    }
}