import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class OtherSettingsPage(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        label_1 = Gtk.Label(label="This is the Other Settings page.")
        self.add(label_1)