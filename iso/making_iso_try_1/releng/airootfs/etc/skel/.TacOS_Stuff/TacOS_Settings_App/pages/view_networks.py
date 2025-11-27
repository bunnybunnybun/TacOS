import gi
import subprocess

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class view_networks_ig(Gtk.Window):
    def __init__(self):
        super().__init__(title="View available networks")
        self.set_default_size(300, 400)
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        button_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)

        available_networks = subprocess.run(
            "nmcli dev wifi list",
            shell=True,
            capture_output=True,
            text=True
        )

        refresh_button = Gtk.Button(label="Refresh")
        refresh_button.connect("clicked", self.on_refresh_clicked)
        close_button = Gtk.Button(label="Close")
        close_button.connect("clicked", self.on_close_clicked)

        self.networks = available_networks.stdout.strip()

        self.networks_label = Gtk.Label(self.networks)
        main_box.add(self.networks_label)
        main_box.add(button_box)
        button_box.pack_start(refresh_button, True, False, 0)
        button_box.pack_start(close_button, True, False, 0)

        self.add(main_box)
    def on_close_clicked(self, widget):
        self.destroy()

    def on_refresh_clicked(self, widget):
        available_networks = subprocess.run(
            "nmcli dev wifi list",
            shell=True,
            capture_output=True,
            text=True
        )

        self.networks = available_networks.stdout.strip()

        self.networks_label.set_label(self.networks)