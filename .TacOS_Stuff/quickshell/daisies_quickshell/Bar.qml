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

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 50

            Rectangle {
                Item {
                    id: colors
                    property var primaryColor: Qt.rgba(1.0, 1.0, 1.0, 1.0)
                    property var secondaryColor: Qt.rgba(0.192, 0.686, 0)
                    property var buttonColor: Qt.rgba(0.957, 0.855, 0.196, 1.0)
                    property var buttonHoverColor: Qt.rgba(0.192, 0.686, 0)
                    property var buttonClickedColor: Qt.rgba(0.957, 0.855, 0.196, 1.0)
                }

                Item {
                    id: misc
                    property var buttonBorderWidth: 5
                    property var buttonRadius: 10
                    property var button2Radius: 5
                    property var radius: 10
                    property var borderWidth: 4
                }

                anchors {
                    fill: parent
                    leftMargin: 3
                    rightMargin: 3
                    topMargin: 0
                    bottomMargin: 0
                }
                color: Qt.rgba(0.0, 0.0, 0.0, 0.0)
                bottomLeftRadius: 20
                bottomRightRadius: 20
                topLeftRadius: 20
                topRightRadius: 20
                border.color: Qt.rgba(0.0, 0.0, 0.0, 0.0)
                border.width: 3

                RowLayout {
                    anchors.fill: parent

                    RowLayout {
                        id: leftModules
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: false
                        Layout.leftMargin: 8
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
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 50
                            onClicked: launchFuzzel.running = true

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
                                border.color: Qt.rgba(1.0, 1.0, 1.0, 1.0)
                                border.width: misc.buttonBorderWidth
                                color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                            }
                        }
                    }

                    RowLayout {
                        id: centerModules
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
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
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 250
                            onClicked: clockPopup.visible = !clockPopup.visible
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
                                border.color: Qt.rgba(1.0, 1.0, 1.0, 1.0)
                                border.width: misc.buttonBorderWidth
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
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 50
                            Layout.alignment: Qt.AlignRight
                            onClicked: settingsPopup.visible = !settingsPopup.visible
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
                                border.color: Qt.rgba(1.0, 1.0, 1.0, 1.0)
                                border.width: misc.buttonBorderWidth
                                color: parent.down ? colors.buttonClickedColor :
                                    parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                            }
                        }
                    }

                    RowLayout {
                        id: rightModules
                        Layout.alignment: Qt.AlignRight
                        Layout.fillWidth: false
                        Layout.rightMargin: 8
                        spacing: 10

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
                            anchors.rightMargin: 8
                            Layout.preferredHeight: 25
                            Layout.preferredWidth: 35
                            onClicked: trayPopup.visible = !trayPopup.visible
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
                                border.color: Qt.rgba(1.0, 1.0, 1.0, 1.0)
                                border.width: misc.buttonBorderWidth
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
                        //Button {
                        //    id: checkRamUsage
                        //    Layout.margins: 25
                        //    Layout.fillWidth: true
                        //    Layout.fillHeight: true
                        //    Layout.preferredHeight: 35
                        //    Layout.preferredWidth: 35
                        //    //onClicked: getTotalMemory.running = true
                        //    background: Rectangle {
                        //        radius: misc.button2Radius
                        //        color: parent.down ? colors.buttonClickedColor :
                        //        parent.hovered ? colors.buttonHoverColor : colors.buttonColor
                        //    }
                        //}

                        Button {
                            id: openSettingsApp
                            Layout.alignment: Qt.AlignTop
                            Layout.margins: 25
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            Layout.preferredHeight: 35
                            Layout.preferredWidth: 35
                            onClicked: openSettings.running = true
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
                            //spacing: 15

                            Repeater {
                                function getFilePath(relativePath) {
                                    return "file://" + Qt.application.path + "/../" + relativePath;
                                }

                                model: [
                                    { path: "file://" + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/Daisies.jpg", name: "Daisies", command: "swaybg -m fill -i " + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/Daisies.jpg" },
                                    { path: "file://" + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/arch_rainbow.png", name: "Arch", command: "swaybg -m fill -i "  + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/arch_rainbow.png" },
                                    { path: "file://" + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/fall.jpg", name: "Fall", command: "swaybg -m fill -i "  + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/fall.jpg" },
                                    { path: "file://" + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/halloween.jpg", name: "Graveyard", command: "swaybg -m fill -i "  + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/halloween.jpg" },
                                    { path: "file://" + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/magic.jpg", name: "Magic", command: "swaybg -m fill -i "  + homePath + "/TacOS/TacOS/.TacOS_Stuff/swaybg/magic.jpg" },
                                    { path: "file://" + homePath + "/TacOS/TacOS/.TacOS_Stuff/custom_wallpaper_engine/space_with_eyes.png", name: "Eyes (interactive)", command: "python3 " + homePath + "/TacOS/TacOS/.TacOS_Stuff/custom_wallpaper_engine/parallax_wallpaper_engine.py" },
                                    { path: "file://" + homePath + "/TacOS/TacOS/.TacOS_Stuff/custom_wallpaper_engine/space_background_2.jpg", name: "Eyes (interactive)", command: "python3 " + homePath + "/TacOS/TacOS/.TacOS_Stuff/custom_wallpaper_engine/parallax_wallpaper_engine_2.py" },
                                ]

                                Button {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.margins: 5

                                    background: Rectangle {
                                        radius: misc.button2Radius
                                        border.color: parent.down ? colors.secondaryColor :
                                        parent.hovered ? Qt.rgba(0.092, 0.586, 0, 1) : colors.secondaryColor
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
                                        "bash", "-c", "pkill -x swaybg; " + modelData.command + " >> /home/carlisle/test_log.log"
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
                                "bash", "-c", "python3 ~/TacOS/TacOS/.TacOS_Stuff/wallpaper_creator_app/wallpaper_creator.py"
                            ])
                            background: Rectangle {
                                bottomLeftRadius: misc.buttonRadius
                                bottomRightRadius: misc.buttonRadius
                                topLeftRadius: misc.buttonRadius
                                topRightRadius: misc.buttonRadius
                                color: parent.down ? colors.secondaryColor :
                                    parent.hovered ? Qt.rgba(0.092, 0.586, 0, 1) : colors.secondaryColor
                            }
                        }
                    }
                }
            }
        }
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
        command: ["bash", "-c", "fuzzel --config /etc/xdg/fuzzel/daisies_fuzzel_app_drawer.ini"]
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}