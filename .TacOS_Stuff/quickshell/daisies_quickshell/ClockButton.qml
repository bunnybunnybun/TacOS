import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

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