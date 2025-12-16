import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: cpuButton
    contentItem: Label {
        id: cpuUsage
        text: "CPU: " + cpuUsage.cpuPercent + "%"
        font.pixelSize: misc.buttonFontSize
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        property string cpuPercent: "N/A"

        Timer {
            id: cpuTimer
            interval: 500
            running: true
            repeat: true
            onTriggered: getCpuUsage.running = true
        }

        Process {
            id: getCpuUsage
            command: ["bash", "-c", "cat <(grep 'cpu ' /proc/stat) <(sleep 0.1 && grep 'cpu ' /proc/stat) | awk -v RS=\"\" '{printf \"%.1f\", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}'"]

            stdout: StdioCollector {
                onStreamFinished: {
                    cpuUsage.cpuPercent = this.text.trim()
                }
            }
        }
    }
    Layout.alignment: Qt.AlignRight
    Layout.preferredHeight: misc.buttonPreferredHeight
    Layout.preferredWidth: 90
    onClicked: resourceUsagePopup.visible = !resourceUsagePopup.visible
    background: Rectangle {
        anchors {
            fill: parent
            topMargin: -3
            bottomMargin: -3
            leftMargin: -3
            rightMargin: -3
        }
        bottomLeftRadius: misc.buttonRadius
        bottomRightRadius: misc.buttonRadius
        topLeftRadius: misc.buttonRadius
        topRightRadius: misc.buttonRadius
        border.color: colors.primaryColor
            border.width: misc.buttonBorderWidth
        color: parent.down ? colors.buttonClickedColor :
            parent.hovered ? colors.buttonHoverColor : colors.buttonColor
    }
}