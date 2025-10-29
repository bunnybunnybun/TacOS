import gi
import subprocess
import os
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk, GLib
gi.require_version('GtkLayerShell', '0.1')
from gi.repository import GtkLayerShell

css_provider = Gtk.CssProvider()

css = """
window {
    background-color: rgba(0, 0, 0, 0.0);
}
"""
css_provider.load_from_data(css.encode())

settings = Gtk.Settings.get_default()
settings.set_property("gtk-theme-name", "Adwaita")
settings.set_property("gtk-application-prefer-dark-theme", True)

screen = Gdk.Screen.get_default()
style_context = Gtk.StyleContext()
style_context.add_provider_for_screen(
    screen,
    css_provider,
    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
)

class MainWindow(Gtk.Window):
    def __init__(self):
        super().__init__(title="Jumpscare!!!")
        self.set_default_size(600, 400)

        GtkLayerShell.init_for_window(self)
        self.script_dir = os.path.dirname(os.path.abspath(__file__))
        print(self.script_dir)
        image = Gtk.Image.new_from_file(f"{self.script_dir}/jumpscare_image.png")
        image.set_opacity(1)
        self.add(image)

        self.show_all()
        self.play_audio()

        GLib.timeout_add_seconds(2, self.destroy)

    def play_audio(self):
        subprocess.Popen(
        ["mpv", f"{self.script_dir}/taco-crunch.mp3"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
        )
win = MainWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()