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
                anchors {
                    fill: parent
                    leftMargin: 20
                    rightMargin: 20
                    topMargin: 10
                    bottomMargin: 0
                }
                color: Qt.rgba(1, 0, 0.788, 0.6)
                bottomLeftRadius: 20
                bottomRightRadius: 20
                topLeftRadius: 20
                topRightRadius: 20
                border.color: Qt.rgba(1.0, 0.7, 0.988, 1.0)
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
                                bottomLeftRadius: 20
                                bottomRightRadius: 20
                                topLeftRadius: 20
                                topRightRadius: 20
                                color: parent.down ? Qt.rgba(1.0, 0.7, 0.988, 1.0) :
                                    parent.hovered ? Qt.rgba(1.0, 0.85, 1.0, 1.0) : Qt.rgba(1.0, 0.7, 0.988, 1.0)
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
                                bottomLeftRadius: 20
                                bottomRightRadius: 20
                                topLeftRadius: 20
                                topRightRadius: 20
                                color: parent.down ? Qt.rgba(1.0, 0.7, 0.988, 1.0) :
                                    parent.hovered ? Qt.rgba(1.0, 0.85, 1.0, 1.0) : Qt.rgba(1.0, 0.7, 0.988, 1.0)
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
                                bottomLeftRadius: 20
                                bottomRightRadius: 20
                                topLeftRadius: 20
                                topRightRadius: 20
                                color: parent.down ? Qt.rgba(1.0, 0.7, 0.988, 1.0) :
                                    parent.hovered ? Qt.rgba(1.0, 0.85, 1.0, 1.0) : Qt.rgba(1.0, 0.7, 0.988, 1.0)
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
                                bottomLeftRadius: 20
                                bottomRightRadius: 20
                                topLeftRadius: 20
                                topRightRadius: 20
                                color: parent.down ? Qt.rgba(1.0, 0.7, 0.988, 1.0) :
                                    parent.hovered ? Qt.rgba(1.0, 0.85, 1.0, 1.0) : Qt.rgba(1.0, 0.7, 0.988, 1.0)
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
                    color: Qt.rgba(1.0, 0.0, 0.788, 0.8)
                    border.color: Qt.rgba(1.0, 0.7, 0.988, 1.0)
                border.width: 3
                    anchors {
                        fill: parent
                        topMargin: 10
                    }
                    radius: 20
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
                anchor.rect.x: 58
                implicitWidth: 300
                implicitHeight: 500
                visible: false
                color: "transparent"
                Rectangle {
                    color: Qt.rgba(1.0, 0.0, 0.788, 0.8)
                    border.color: Qt.rgba(1.0, 0.7, 0.988, 1.0)
                    border.width: 3
                    anchors {
                        fill: parent
                        topMargin: 10
                    }
                    radius: 20
                    Text {
                        text: "Tray thingy"
                        anchors.centerIn: parent
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
                    color: Qt.rgba(1.0, 0.0, 0.788, 0.8)
                    border.color: Qt.rgba(1.0, 0.7, 0.988, 1.0)
                    border.width: 3
                    anchors {
                        fill: parent
                        topMargin: 10
                    }
                    radius: 20
                    
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
                                    { path: "file://" + homePath + "/TacOS/TacOS/.TacOS_Stuff/custom_wallpaper_engine/space_with_eyes.png", name: "Eyes (interactive)", command: "python3 " + homePath + "/TacOS/TacOS/.TacOS_Stuff/custom_wallpaper_engine/parallax_wallpaper_engine_2.py" },
                                ]

                                Button {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.margins: 5

                                    background: Rectangle {
                                        radius: 3
                                        border.color: Qt.rgba(1.0, 0.7, 0.988, 1.0)
                                        border.width: 3

                                        Image {
                                            source: modelData.path
                                            anchors.fill: parent
                                            anchors.margins: 3
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
                                bottomLeftRadius: 20
                                bottomRightRadius: 20
                                topLeftRadius: 20
                                topRightRadius: 20
                                color: parent.down ? Qt.rgba(1.0, 0.7, 0.988, 1.0) :
                                    parent.hovered ? Qt.rgba(1.0, 0.85, 1.0, 1.0) : Qt.rgba(1.0, 0.7, 0.988, 1.0)
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
        command: ["bash", "-c", "fuzzel --config /etc/xdg/fuzzel/fuzzel_app_drawer.ini"]
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}