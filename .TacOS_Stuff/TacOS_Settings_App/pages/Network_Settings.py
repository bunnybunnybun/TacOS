import gi
import os
from .view_networks import view_networks_ig

gi.require_version("NM", "1.0")
from gi.repository import GLib, NM

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class NetworkSettingsPage(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        label_1 = Gtk.Label(label="WIP...")
        self.add(label_1)

        view_networks_button = Gtk.Button(label="View available networks")
        view_networks_button.connect("clicked", self.view_networks)
        self.ssid_input = Gtk.Entry()
        self.ssid_input.set_placeholder_text("SSID")
        pass_input = Gtk.Entry()
        pass_input.set_placeholder_text("Password")
        connect_button = Gtk.Button(label="Connect")
        connect_button.connect("clicked", self.testing)
        self.add(view_networks_button)
        self.add(self.ssid_input)
        self.add(pass_input)
        self.add(connect_button)

    def view_networks(self, widget):
        view_networks_window = view_networks_ig()
        view_networks_window.show_all()
        print("test")

    def testing(self, widget):
        client = NM.Client.new(None)
        print("version ", client.get_version())
        devices = client.get_devices()
        print("Devices:")
        for device in devices:
            print("    name:", device.get_iface())
            print("    type:", device.get_type_description())
            print("    state:", device.get_state().value_nick)

    def connect(self, widget):
        ssid = self.ssid_input.get_text().strip()
        print(ssid)
        os.system(f'nmcli device wifi connect "{ssid}" --ask')
