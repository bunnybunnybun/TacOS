import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class DisplaySettingsPage(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        label_1 = Gtk.Label(label="This is the Display Settings page.")
        self.add(label_1)