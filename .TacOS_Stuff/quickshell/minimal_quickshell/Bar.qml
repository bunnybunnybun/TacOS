import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Scope {
    id: root
    property string homePath: ""
    property bool homePathReady: false
    property string time

    Process {
        id: homeDirProc
        command: ["sh", "-c", "echo $HOME"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.homePath = this.text.trim()
                root.homePathReady = true
            }
        }
    }

    Variants {
        model: Quickshell.screens;

        PanelWindow {
            id: toplevel
            required property var modelData
            screen: modelData
            aboveWindows: false

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 48

            Rectangle {
                Item {
                    id: colors
                    property var primaryColor: Qt.rgba(0.667, 0.455, 0.522, 1.0)
                    property var secondaryColor: Qt.rgba(0.657, 0.395, 0.462, 1.0)
                    property var buttonColor: Qt.rgba(0.657, 0.395, 0.462, 1.0)
                    property var buttonHoverColor: Qt.rgba(0.617, 0.355, 0.422, 1.0)
                    property var buttonClickedColor: Qt.rgba(0.657, 0.395, 0.462, 1.0)
                }

                Item {
                    id: misc
                    property var buttonBorderWidth: 3
                    property var buttonRadius: 5
                    property var button2Radius: 5
                    property var radius: 5
                    property var borderWidth: 3
                    property var hoverTime: 400
                }

                anchors {
                    fill: parent
                    leftMargin: 8
                    rightMargin: 8
                    topMargin: 8
                    bottomMargin: 6
                }
                color: colors.primaryColor
                bottomLeftRadius: misc.radius
                bottomRightRadius: misc.radius
                topLeftRadius: misc.radius
                topRightRadius: misc.radius
                border.color: colors.secondaryColor
                border.width: misc.borderWidth

                RowLayout {
                    anchors.fill: parent

                    RowLayout {
                        id: leftModules
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: false
                        Layout.topMargin: 6
                        Layout.bottomMargin: 6
                        Layout.leftMargin: 6
                        spacing: 10

                        Button {
                            id: appsButton
                            contentItem: Label {
                                text: "Apps"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            Layout.preferredHeight: 22
                            Layout.preferredWidth: 50
                            onClicked: launchFuzzel.running = true

                            background: Rectangle {
                                bottomLeftRadius: misc.buttonRadius
                                bottomRightRadius: misc.buttonRadius
                                topLeftRadius: misc.buttonRadius
                                topRightRadius: misc.buttonRadius
                                color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                            }
                        }
                    }

                    RowLayout {
                        id: centerModules
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 6
                        Layout.bottomMargin: 6
                        Layout.leftMargin: 6
                        spacing: 10

                        Button {
                            id: clockButton
                            contentItem: Label {
                                text: root.time
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            Layout.preferredHeight: 22
                            Layout.preferredWidth: 250
                            onClicked: clockPopup.visible = !clockPopup.visible
                            background: Rectangle {
                                bottomLeftRadius: misc.buttonRadius
                                bottomRightRadius: misc.buttonRadius
                                topLeftRadius: misc.buttonRadius
                                topRightRadius: misc.buttonRadius
                                color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                            }
                        }

                        Button {
                            id: settingsButton
                            contentItem: Label {
                                text: ""
                                font.pixelSize: 16
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            Layout.preferredHeight: 22
                            Layout.preferredWidth: 50
                            Layout.alignment: Qt.AlignRight
                            onClicked: settingsPopup.visible = !settingsPopup.visible
                            background: Rectangle {
                                bottomLeftRadius: misc.buttonRadius
                                bottomRightRadius: misc.buttonRadius
                                topLeftRadius: misc.buttonRadius
                                topRightRadius: misc.buttonRadius
                                color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                            }
                        }
                    }

                    RowLayout {
                        id: rightModules
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignRight
                        Layout.fillWidth: false
                        Layout.topMargin: 6
                        Layout.bottomMargin: 6
                        Layout.rightMargin: 6
                        spacing: 10

                        Button {
                            id: cpuButton
                            contentItem: Label {
                                id: cpuUsage
                                text: "CPU: " + cpuUsage.cpuPercent + "%"

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
                            Layout.preferredHeight: 22
                            Layout.preferredWidth: 75
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

                        Button {
                            id: ramButton
                            contentItem: Label {
                                id: freeMemory
                                text: "RAM: " + ramPercent + "%"

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
                            Layout.preferredHeight: 22
                            Layout.preferredWidth: 78
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
                        
                        Button {
                            id: trayButton
                            contentItem: Label {
                                text: "󰁋"
                                font.pixelSize: 20
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            Layout.alignment: Qt.AlignRight
                            Layout.preferredHeight: 22
                            Layout.preferredWidth: 35
                            onClicked: trayPopup.visible = !trayPopup.visible
                            background: Rectangle {
                                bottomLeftRadius: misc.buttonRadius
                                bottomRightRadius: misc.buttonRadius
                                topLeftRadius: misc.buttonRadius
                                topRightRadius: misc.buttonRadius
                                color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: clockPopup
                anchor.window: toplevel
                anchor.rect.x: parentWindow.width / 2 -width / 2
                anchor.rect.y: 50
                implicitWidth: 400
                implicitHeight: 400
                visible: false
                color: "transparent"
                Rectangle {
                    color: colors.primaryColor
                    border.color: colors.secondaryColor
                    border.width: misc.borderWidth
                    anchors {
                        fill: parent
                        topMargin: 10
                    }
                    radius: misc.radius
                    Text {
                        text: "The time is.... jk im not telling u\n ok here you go: " + root.time + "\n dunno why you clicked on this just to see the time again but oh well..."
                        anchors.centerIn: parent
                    }
                }
            }

            PopupWindow {
                id: resourceUsagePopup
                anchor.item: ramButton
                anchor.rect.x: 32
                anchor.rect.y: 42
                implicitWidth: 400
                implicitHeight: 400
                visible: false
                color: "transparent"
                Rectangle {
                    color: colors.primaryColor
                    border.color: colors.secondaryColor
                    border.width: misc.borderWidth
                    anchors {
                        fill: parent
                        topMargin: 10
                    }
                    radius: misc.radius

                    ColumnLayout {
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 15

                        Text {
                            text: "Resource usage"
                            font.pixelSize: 32
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        GridLayout {
                            rows: 3
                            columns: 2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.margins: 0
                            

                            Text {
                                text: "RAM usage: " + freeMemory.ramPercent + "%"
                                anchors.left: parent.left
                                font.pixelSize: 15
                            }

                            Rectangle {
                                id: ramUsageBar
                                color: Qt.rgba(0.65, 0.65, 0.65, 1.0)
                                radius: 4
                                implicitWidth: 200
                                implicitHeight: 15

                                property string ramTotal: "Loading..."

                                HoverHandler {
                                    id: ramHoverHandler
                                }

                                ToolTip {
                                    visible: ramHoverHandler.hovered
                                    text: ramUsageBar.ramTotal
                                    delay: misc.hoverTime

                                    background: Rectangle {
                                        color: colors.secondaryColor
                                    }

                                    Timer {
                                        id: ramTotalTimer
                                        interval: 500
                                        running: ramHoverHandler.hovered
                                        repeat: true
                                        onTriggered: getRamTotal.running = true
                                    }

                                    Process {
                                        id: getRamTotal
                                        command: ["bash", "-c", "free -k | awk '/Mem:/ {printf $3 \" KiB / \"$2 \" KiB\"}'"]

                                        stdout: StdioCollector {
                                            onStreamFinished: {
                                                ramUsageBar.ramTotal = this.text.trim()
                                            }
                                        }
                                    }
                                }

                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: parent.width * (freeMemory.ramPercent / 100)
                                    radius: 4
                                    color: {
                                        if (freeMemory.ramPercent < 65) Qt.rgba(0.0, 0.75, 0.0, 1.0)
                                        else if (freeMemory.ramPercent < 80) Qt.rgba(0.9, 0.9, 0.0, 1.0)
                                        else if (freeMemory.ramPercent < 90) Qt.rgba(0.9, 0.6, 0.0, 1.0)
                                        else Qt.rgba(1.0, 0.0, 0.0, 1.0)
                                    }
                                }
                            }

                            Text {
                                text: "CPU usage: " + cpuUsage.cpuPercent + "%"
                                anchors.left: parent.left
                                font.pixelSize: 15
                            }

                            Rectangle {
                                color: Qt.rgba(0.65, 0.65, 0.65, 1.0)
                                radius: 4
                                implicitWidth: 200
                                implicitHeight: 15

                                Rectangle {
                                    id: cpuUsageBar
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: parent.width * (cpuUsage.cpuPercent / 100)
                                    radius: 4
                                    color: {
                                        if (cpuUsage.cpuPercent < 65) Qt.rgba(0.0, 0.75, 0.0, 1.0)
                                        else if (cpuUsage.cpuPercent < 80) Qt.rgba(0.9, 0.9, 0.0, 1.0)
                                        else if (cpuUsage.cpuPercent < 90) Qt.rgba(0.9, 0.6, 0.0, 1.0)
                                        else Qt.rgba(1.0, 0.0, 0.0, 1.0)
                                    }
                                }
                            }

                            Text {
                                text: "GPU usage: N/A"
                                anchors.left: parent.left
                                font.pixelSize: 15
                            }

                            Rectangle {
                                color: Qt.rgba(0.65, 0.65, 0.65, 1.0)
                                radius: 4
                                implicitWidth: 200
                                implicitHeight: 15

                                Rectangle {
                                    id: gpuUsageBar
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: parent.width * (freeMemory.ramPercent / 100)
                                    radius: 4
                                    color: {
                                        if (freeMemory.ramPercent < 65) Qt.rgba(0.0, 0.75, 0.0, 1.0)
                                        else if (freeMemory.ramPercent < 80) Qt.rgba(0.9, 0.9, 0.0, 1.0)
                                        else if (freeMemory.ramPercent < 90) Qt.rgba(0.9, 0.6, 0.0, 1.0)
                                        else Qt.rgba(1.0, 0.0, 0.0, 1.0)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: trayPopup
                anchor.item: trayButton
                anchor.gravity: Edges.Bottom | Edges.Left
                anchor.rect.y: 32
                anchor.rect.x: 42
                implicitWidth: 300
                implicitHeight: 500
                visible: false
                color: "transparent"
                Rectangle {
                    color: colors.primaryColor
                    border.color: colors.secondaryColor
                    border.width: misc.borderWidth
                    anchors {
                        fill: parent
                        topMargin: 10
                    }
                    radius: misc.radius

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 15

                        Button {
                            id: openSettingsApp
                            Layout.alignment: Qt.AlignTop
                            Layout.margins: 25
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            Layout.preferredHeight: 35
                            Layout.preferredWidth: 35
                            onClicked: trayPopup.visible = !trayPopup.visible, Quickshell.execDetached([
                                "bash", "-c", "~/.TacOS_Stuff/TacOS_Settings_App/TacOS_Settings"
                            ])
                            contentItem: Label {
                                text: "Settings "
                                font.pixelSize: 20
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            background: Rectangle {
                                radius: misc.button2Radius
                                color: parent.down ? colors.buttonClickedColor :
                                parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                            }
                        }

                        Label {
                            anchors {
                                fill: parent
                            }
                            text: "WIP"
                            font.pixelSize: 45
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        FileView {
                            id: viewRamUsage
                            path: Qt.resolvedUrl("/proc/meminfo")
                            preload: true
                            watchChanges: true
                            onLoaded: console.log("Beepity bop meminfo:", text)
                            onLoadFailed: {
                                console.log("Failed to load file:", text())
                            }
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignBottom
                            Layout.margins: 10
                            spacing: 0
                            
                            Button {
                                id: logoutButton
                                onClicked: logoutConfirmation.visible = !logoutConfirmation.visible
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 35
                                Layout.preferredWidth: 100
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "logout"
                                    font.pixelSize: 15
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }

                            Button {
                                id: rebootButton
                                onClicked: rebootConfirmation.visible = !rebootConfirmation.visible
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 35
                                Layout.preferredWidth: 100
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "reboot"
                                    font.pixelSize: 15
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }

                            Button {
                                id: shutdownButton
                                onClicked: shutdownConfirmation.visible = !shutdownConfirmation.visible
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 35
                                Layout.preferredWidth: 100
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "shutdown"
                                    font.pixelSize: 15
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: logoutConfirmation
                anchor.window: toplevel
                anchor.rect.x: 760
                anchor.rect.y: 290
                implicitHeight: 250
                implicitWidth: 450
                color: "transparent"
                visible: false
                Rectangle {
                    color: colors.primaryColor
                    border.width: misc.borderWidth
                    border.color: colors.secondaryColor
                    radius: misc.radius
                    anchors {
                        fill: parent
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 15
                        Text {
                            text: "Are you sure you want to logout?"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: 20
                            font.pixelSize: 24
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignBottom
                            Layout.margins: 10
                            spacing: 0

                            Button {
                                id: logoutYes
                                onClicked: execDetached ([
                                    "bash", "-c", "niri msg action quit -s"
                                ])
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 60
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "Yes"
                                    font.pixelSize: 20
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }

                            Button {
                                id: logoutNo
                                onClicked: logoutConfirmation.visible = !logoutConfirmation.visible
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 60
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "No"
                                    font.pixelSize: 20
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: rebootConfirmation
                anchor.window: toplevel
                anchor.rect.x: 760
                anchor.rect.y: 290
                implicitHeight: 250
                implicitWidth: 450
                color: "transparent"
                visible: false
                Rectangle {
                    color: colors.primaryColor
                    border.width: misc.borderWidth
                    border.color: colors.secondaryColor
                    radius: misc.radius
                    anchors {
                        fill: parent
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 15
                        Text {
                            text: "Are you sure you want to reboot?"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: 20
                            font.pixelSize: 24
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignBottom
                            Layout.margins: 10
                            spacing: 0

                            Button {
                                id: rebootYes
                                onClicked: execDetached ([
                                    "bash", "-c", "reboot"
                                ])
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 60
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "Yes"
                                    font.pixelSize: 20
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }

                            Button {
                                id: rebootNo
                                onClicked: rebootConfirmation.visible = !rebootConfirmation.visible
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 60
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "No"
                                    font.pixelSize: 20
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: shutdownConfirmation
                anchor.window: toplevel
                anchor.rect.x: 760
                anchor.rect.y: 290
                implicitHeight: 250
                implicitWidth: 450
                color: "transparent"
                visible: false
                Rectangle {
                    color: colors.primaryColor
                    border.width: misc.borderWidth
                    border.color: colors.secondaryColor
                    radius: misc.radius
                    anchors {
                        fill: parent
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 15
                        Text {
                            text: "Are you sure you want to poweroff?"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: 20
                            font.pixelSize: 24
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignBottom
                            Layout.margins: 10
                            spacing: 0

                            Button {
                                id: shutdownYes
                                onClicked: execDetached ([
                                    "bash", "-c", "poweroff"
                                ])
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 60
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "Yes"
                                    font.pixelSize: 20
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }

                            Button {
                                id: shutdownNo
                                onClicked: shutdownConfirmation.visible = !shutdownConfirmation.visible
                                Layout.margins: 5
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 60
                                Layout.fillWidth: true
                                contentItem: Label {
                                    text: "No"
                                    font.pixelSize: 20
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                background: Rectangle {
                                    radius: misc.buttonRadius
                                    color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                }
                            }
                        }
                    }
                }
            }

            PopupWindow {
                id: settingsPopup
                anchor.window: toplevel
                anchor.rect.x: parentWindow.width / 2 -width / 2
                anchor.rect.y: 50
                implicitWidth: 500
                implicitHeight: 500
                visible: false
                color: "transparent"
                Rectangle {
                    color: colors.primaryColor
                    border.color: colors.secondaryColor
                    border.width: misc.borderWidth
                    anchors {
                        fill: parent
                        topMargin: 10
                    }
                    radius: misc.radius
                    
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 15
                        Text {
                            text: "Choose a wallpaper:"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: 20
                            font.pixelSize: 32
                        }

                        GridLayout {
                            id: wallpaperGrid
                            visible: root.homePathReady
                            rows: 3
                            columns: 2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.margins: 15

                            Repeater {
                                function getFilePath(relativePath) {
                                    return "file://" + Qt.application.path + "/../" + relativePath;
                                }

                                model: [
                                    { path: "file://" + homePath + "/.TacOS_Stuff/swaybg/Daisies.jpg", name: "Daisies", command: "swaybg -m fill -i " + homePath + "/.TacOS_Stuff/swaybg/Daisies.jpg" },
                                    { path: "file://" + homePath + "/.TacOS_Stuff/swaybg/arch_rainbow.png", name: "Arch", command: "swaybg -m fill -i "  + homePath + "/.TacOS_Stuff/swaybg/arch_rainbow.png" },
                                    { path: "file://" + homePath + "/.TacOS_Stuff/swaybg/fall.jpg", name: "Fall", command: "swaybg -m fill -i "  + homePath + "/.TacOS_Stuff/swaybg/fall.jpg" },
                                    { path: "file://" + homePath + "/.TacOS_Stuff/swaybg/halloween.jpg", name: "Graveyard", command: "swaybg -m fill -i "  + homePath + "/.TacOS_Stuff/swaybg/halloween.jpg" },
                                    { path: "file://" + homePath + "/.TacOS_Stuff/swaybg/magic.jpg", name: "Magic", command: "swaybg -m fill -i "  + homePath + "/.TacOS_Stuff/swaybg/magic.jpg" },
                                    { path: "file://" + homePath + "/.TacOS_Stuff/custom_wallpaper_engine/space_with_eyes.png", name: "Eyes (interactive)", command: "python3 " + homePath + "/.TacOS_Stuff/custom_wallpaper_engine/parallax_wallpaper_engine.py" },
                                    { path: "file://" + homePath + "/.TacOS_Stuff/custom_wallpaper_engine/space_background_2.jpg", name: "Eyes (interactive)", command: "python3 " + homePath + "/.TacOS_Stuff/custom_wallpaper_engine/parallax_wallpaper_engine_2.py" },
                                ]

                                Button {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.margins: 4

                                    background: Rectangle {
                                        radius: misc.button2Radius
                                        border.color: parent.down ? colors.buttonClickedColor :
                                        parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                                        border.width: misc.buttonBorderWidth

                                        Image {
                                            source: modelData.path
                                            anchors.fill: parent
                                            anchors.margins: misc.buttonBorderWidth
                                            fillMode: Image.PreserveAspectCrop
                                        }
                                    }

                                    ToolTip.text: modelData.name
                                    ToolTip.delay: 1

                                    onClicked: Quickshell.execDetached([
                                        "bash", "-c", "killall swaybg; " + modelData.command
                                    ])
                                }
                            }
                        }

                        Button {
                            id: customWallpaper
                            contentItem: Label {
                                text: "Create your own interactive wallpaper"
                                font.pixelSize: 20
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            Layout.alignment: Qt.AlignRight
                            anchors.rightMargin: 8
                            Layout.preferredHeight: 35
                            Layout.preferredWidth: 460
                            Layout.margins: 20
                            onClicked: settingsPopup.visible = !settingsPopup.visible, Quickshell.execDetached([
                                "bash", "-c", "python3 ~/.TacOS_Stuff/wallpaper_creator_app/wallpaper_creator.py"
                            ])
                            background: Rectangle {
                                bottomLeftRadius: misc.buttonRadius
                                bottomRightRadius: misc.buttonRadius
                                topLeftRadius: misc.buttonRadius
                                topRightRadius: misc.buttonRadius
                                color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                            }
                        }
                    }
                }
            }
        }
    }

    Process {
        id: openSettings
        command: ["bash", "-c", "/usr/bin/python3 ~/.TacOS_Stuff/TacOS_Settings_App/TacOS\ Settings.py"]
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(`Boop bop testing ${this.text}`)
            }
        }
    }

    Process {
        id: getFreeMemory
        command: ["bash", "-c", "cat /proc/meminfo | grep MemFree"]
    }

    Process {
        id: dateProc
        command: ["date"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.time = this.text
        }
    }

    Process {
        id: launchFuzzel
        command: ["bash", "-c", "fuzzel --config /etc/xdg/fuzzel/minimal_fuzzel_app_drawer.ini"]
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}