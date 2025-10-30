import gi
import os
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk, GLib
gi.require_version('GtkLayerShell', '0.1')
from gi.repository import GtkLayerShell

css = '''
box {
    margin: 10px;
    background-color: @theme_bg_color;
    border-radius: 20px;
}

button {
    margin: 10px;
    border-radius: 10px;
    font-weight: bold;
    padding-left: 20px;
    padding-right: 20px;
    padding-top: 7px;
    padding-bottom: 7px;
}

button.nevermind {
    margin: 20px;
    margin-top: 0px;
}

label.label {
    margin: 10px;
    margin-bottom: 0px;
    margin-top: 15px;
}

window {
    background-color: rgba(0, 0, 0, 0)
}
'''

css_provider = Gtk.CssProvider()
css_provider.load_from_data(css.encode())

screen = Gdk.Screen.get_default()
style_context = Gtk.StyleContext()
style_context.add_provider_for_screen(
    screen,
    css_provider,
    Gtk.STYLE_PROVIDER_PRIORITY_USER
)

class MainWindow(Gtk.Window):
    def __init__(self, vertical_offset=100):
        super().__init__(title="End Session Dialog")
        self.set_default_size(200, 500)
        GtkLayerShell.init_for_window(self)

        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.LEFT, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.BOTTOM, False)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, False)

        GLib.idle_add(self.position_window, vertical_offset)

        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        buttons_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        label = Gtk.Label(label="You're leaving already? Well, come again soon!")
        label.get_style_context().add_class("label")
        logout_button = Gtk.Button(label="Logout")
        logout_button.connect("clicked", self.on_logout_clicked)
        reboot_button = Gtk.Button(label="Reboot")
        reboot_button.connect("clicked", self.on_reboot_clicked)
        power_off_button = Gtk.Button(label="Power off")
        power_off_button.connect("clicked", self.on_power_off_clicked)
        nevermind_button = Gtk.Button(label="Nevermind...")
        nevermind_button.connect("clicked", self.on_nevermind_clicked)
        nevermind_button.get_style_context().add_class("nevermind")
        buttons_box.add(logout_button)
        buttons_box.add(reboot_button)
        buttons_box.add(power_off_button)
        main_box.add(label)
        main_box.add(buttons_box)
        main_box.add(nevermind_button)
        self.add(main_box)

    def position_window(self, vertical_offset):
        """Center horizontally, position slightly above vertical center"""
        display = Gdk.Display.get_default()
        monitor = display.get_monitor(0)
        geometry = monitor.get_geometry()

        # Get actual window dimensions (after realization)
        win_width = self.get_allocated_width()
        win_height = self.get_allocated_height()

        # Calculate centered position with upward offset
        x = (geometry.width - win_width) // 2
        # 40% from top = slightly above center (0.4 = 40%, lower values = higher position)
        y = (geometry.height - win_height) * 0.35

        # Apply positioning
        GtkLayerShell.set_margin(self, GtkLayerShell.Edge.LEFT, x)
        GtkLayerShell.set_margin(self, GtkLayerShell.Edge.TOP, y)

        return GLib.SOURCE_REMOVE  # Prevent repeated calls

    def on_logout_clicked(self, widget):
        print("teeest")
        os.system("niri msg action quit")

    def on_reboot_clicked(self, widget):
        os.system("reboot")

    def on_power_off_clicked(self, widget):
        os.system("poweroff")

    def on_nevermind_clicked(self, widget):
        self.destroy()

win = MainWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()