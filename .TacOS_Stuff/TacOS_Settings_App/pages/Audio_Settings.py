import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class AudioSettingsPage(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        self.audio_slider = Gtk.Scale.new_with_range(
            orientation=Gtk.Orientation.VERTICAL,
            min=0,
            max=100,
            step=1
        )