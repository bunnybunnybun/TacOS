import gi
import os
import time
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class GeneralSettingsPage(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        label_1 = Gtk.Label(label="Choose a theme:")
        theme_grid = Gtk.Grid()

        theme_button_1 = Gtk.Button(label="Daisies")
        theme_button_1.connect("clicked", self.Set_Theme_Daisies)
        theme_button_1.get_style_context().add_class("button_theme_daisies")
        theme_button_2 = Gtk.Button(label="Minimal")
        theme_button_2.connect("clicked", self.Set_Theme_Minimal)
        theme_button_2.get_style_context().add_class("button_theme_minimal")
        theme_button_3 = Gtk.Button(label="Magic")
        theme_button_3.connect("clicked", self.Set_Theme_Magic)
        theme_button_3.get_style_context().add_class("button_theme_magic")
        theme_button_4 = Gtk.Button(label="Fall/Autumn")
        theme_button_4.get_style_context().add_class("button_theme_fall")
        self.add(label_1)
        self.add(theme_grid)
        theme_grid.attach(theme_button_1, 1, 0, 1, 1)
        theme_grid.attach_next_to(theme_button_2, theme_button_1, Gtk.PositionType.RIGHT, 1, 1)
        theme_grid.attach_next_to(theme_button_3, theme_button_1, Gtk.PositionType.BOTTOM, 1, 1)
        theme_grid.attach_next_to(theme_button_4, theme_button_3, Gtk.PositionType.RIGHT, 1, 1)

    def Set_Theme_Daisies(self, widget):
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/daisies_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/daisies_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/daisy_config.kdl ~/.config/niri/config.kdl")

    def Set_Theme_Minimal(self, widget):
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/minimal_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/minimal_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/minimal_config.kdl ~/.config/niri/config.kdl")

    def Set_Theme_Magic(self, widget):
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/magic_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/magic_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/magic_config.kdl ~/.config/niri/config.kdl")
