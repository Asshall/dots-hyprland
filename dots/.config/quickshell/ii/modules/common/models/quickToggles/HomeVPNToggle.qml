import qs.modules.common
import qs.modules.common.widgets
import qs.services
import QtQuick
import Quickshell.Io
import Quickshell

QuickToggleModel {
    id: root
    name: Translation.tr("Home VPN")

    toggled: toggled
    icon: 'key'

    mainAction: () => {
        root.toggled = !root.toggled
        if (root.toggled) {
            Quickshell.execDetached(["nmcli", "connection", "up", "Home VPN"])
        } else {
            Quickshell.execDetached(["nmcli", "connection", "down", "Home VPN"])
        }
    }

    Process {
        id: fetchActiveState
        running: true
        command: ["bash", "-c", "nmcli con show --active | grep 'Home VPN'"]
        onExited: (exitCode, exitStatus) => {
            root.toggled = exitCode === 0
        }
    }

    StyledToolTip {
        text: Translation.tr("Home VPN")
    }
}
