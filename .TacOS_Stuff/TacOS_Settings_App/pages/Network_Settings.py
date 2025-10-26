import gi
from .view_networks import view_networks_ig

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class NetworkSettingsPage(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        label_1 = Gtk.Label(label="WIP...")
        self.add(label_1)

        view_networks_button = Gtk.Button(label="View available networks")
        view_networks_button.connect("clicked", self.view_networks)
        ssid_input = Gtk.Entry()
        ssid_input.set_placeholder_text("SSID")
        pass_input = Gtk.Entry()
        pass_input.set_placeholder_text("Password")
        connect_button = Gtk.Button(label="Connect")
        self.add(view_networks_button)
        self.add(ssid_input)
        self.add(pass_input)
        self.add(connect_button)

    def view_networks(self, widget):
        view_networks_window = view_networks_ig()
        view_networks_window.show_all()
        print("test")