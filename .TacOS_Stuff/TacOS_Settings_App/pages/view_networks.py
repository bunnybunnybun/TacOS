import gi
import subprocess

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class view_networks_ig(Gtk.Window):
    def __init__(self):
        super().__init__(title="View available networks")
        self.set_default_size(300, 400)
        main_box = Gtk.Box()

        available_networks = subprocess.run(
            "nmcli dev wifi list",
            shell=True,
            capture_output=True,
            text=True
        )

        self.networks = available_networks.stdout.strip()

        self.networks_label = Gtk.Label(self.networks)
        main_box.add(self.networks_label)

        self.add(main_box)
