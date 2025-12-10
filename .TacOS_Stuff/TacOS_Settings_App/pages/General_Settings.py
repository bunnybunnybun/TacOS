import gi
import os
import time
from pathlib import Path
from pages.General_Settings_Subfiles.set_focus_ring_width import set_focus_ring_width_daisies
from pages.General_Settings_Subfiles.set_focus_ring_width import set_focus_ring_width_minimal
from pages.General_Settings_Subfiles.set_focus_ring_width import set_focus_ring_width_magic
from pages.General_Settings_Subfiles.set_focus_ring_width import set_focus_ring_width_fall
from pages.General_Settings_Subfiles.set_focus_ring_color import set_focus_ring_color_daisies
from pages.General_Settings_Subfiles.set_focus_ring_color import set_focus_ring_color_minimal
from pages.General_Settings_Subfiles.set_focus_ring_color import set_focus_ring_color_magic
from pages.General_Settings_Subfiles.set_focus_ring_color import set_focus_ring_color_fall
import pathlib
project_root = pathlib.Path.home() / 'TacOS'

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class GeneralSettingsPage(Gtk.Box):
    def __init__(self, main_window=None):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.get_style_context().add_class("right_box")
        self.main_window = main_window

        label_1 = Gtk.Label(label="Choose a theme:")
        theme_grid = Gtk.Grid()

        self.script_dir = os.path.dirname(os.path.abspath(__file__))

        theme_button_1 = Gtk.Button(label="Daisies")
        theme_button_1.connect("clicked", self.Set_Theme_Daisies)
        theme_button_1.get_style_context().add_class("button_theme_daisies")
        theme_button_2 = Gtk.Button(label="Minimal")
        theme_button_2.connect("clicked", self.Set_Theme_Minimal)
        theme_button_2.get_style_context().add_class("button_theme_minimal")
        theme_button_3 = Gtk.Button(label="Winter")
        theme_button_3.connect("clicked", self.Set_Theme_Winter)
        theme_button_3.get_style_context().add_class("button_theme_winter")
        theme_button_4 = Gtk.Button(label="Halloween")
        theme_button_4.connect("clicked", self.Set_Theme_Fall)
        theme_button_4.get_style_context().add_class("button_theme_fall")
        light_mode_button = Gtk.Button(label="Light mode")
        light_mode_button.connect("clicked", self.Light_Mode)
        dark_mode_button = Gtk.Button(label="Dark mode")
        dark_mode_button.connect("clicked", self.Dark_Mode)
        black_mode_button = Gtk.Button(label="Black mode")
        black_mode_button.connect("clicked", self.Black_Mode)
        color_chooser_label = Gtk.Label(label="Set the focus ring color:")
        color_chooser_button = Gtk.ColorButton()
        color_chooser_button.connect("color-set", self.on_color_set)


        label_2 = Gtk.Label(label="Set focus ring width:")
        self.focus_ring_width_scale = Gtk.Scale.new_with_range(
            orientation=Gtk.Orientation.HORIZONTAL,
            min=0,
            max=25,
            step=1
        )

        self.focus_ring_width_scale.set_value(5)
        self.focus_ring_width_scale.add_mark(5, Gtk.PositionType.TOP, "Default")
        self.focus_ring_width_scale.connect("value-changed", self.on_scale_changed)

        self.add(label_1)
        self.add(theme_grid)
        self.add(light_mode_button)
        self.add(dark_mode_button)
        self.add(black_mode_button)
        self.add(color_chooser_label)
        self.add(color_chooser_button)
        self.add(label_2)
        self.add(self.focus_ring_width_scale)
        theme_grid.attach(theme_button_1, 1, 0, 1, 1)
        theme_grid.attach_next_to(theme_button_2, theme_button_1, Gtk.PositionType.RIGHT, 1, 1)
        theme_grid.attach_next_to(theme_button_3, theme_button_1, Gtk.PositionType.BOTTOM, 1, 1)
        theme_grid.attach_next_to(theme_button_4, theme_button_3, Gtk.PositionType.RIGHT, 1, 1)

    def on_color_set(self, color_button):
        rgba = color_button.get_rgba()

        r = int(rgba.red * 255)
        g = int(rgba.green * 255)
        b = int(rgba.blue * 255)
        a = int(rgba.alpha * 255)

        color_value = f"#{r:02x}{g:02x}{b:02x}{a:02x}"
        print(f"Color = {color_value}")

        if os.path.exists(str(Path.home() / ".TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_daisies")):
            set_focus_ring_color_daisies(None, color_value)
        elif os.path.exists(str(Path.home() / ".TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_minimal")):
            set_focus_ring_color_minimal(None, color_value)
        elif os.path.exists(str(Path.home() / ".TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_magic")):
            set_focus_ring_color_magic(None, color_value)
        elif os.path.exists(str(Path.home() / ".TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_fall")):
            set_focus_ring_color_fall(None, color_value)

    def Light_Mode(self, widget):
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Fluent-pink-Light"')

    def Dark_Mode(self, widget):
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Fluent-pink-Dark"')
    
    def Black_Mode(self, widget):
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Material-Black-Plum-3.38"')

    def on_scale_changed(self, scale):
        value = scale.get_value()
        if os.path.exists(str(Path.home() / ".TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_daisies")):
            set_focus_ring_width_daisies(None, value)
        elif os.path.exists(str(Path.home() / ".TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_minimal")):
            set_focus_ring_width_minimal(None, value)
        elif os.path.exists(str(Path.home() / ".TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_magic")):
            set_focus_ring_width_magic(None, value)
        elif os.path.exists(str(Path.home() / ".TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_fall")):
            set_focus_ring_width_fall(None, value)

    def Set_Theme_Daisies(self, widget):
        os.system(f"killall quickshell; quickshell -p {self.script_dir}/../../quickshell/daisies_quickshell & disown")
        os.system("killall swaybg; swaybg -m fill -i ~/.TacOS_Stuff/swaybg/Daisies.jpg & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/daisy_config.kdl ~/.config/niri/config.kdl")
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Fluent-yellow-Light"')
        os.system("gsettings set org.gnome.desktop.interface icon-theme Adwaita")
        os.system("cp ~/.TacOS_Stuff/assets/starship/starship.toml ~/.config/starship.toml")
        os.system("cp ~/.config/kitty/general-theme.conf ~/.config/kitty/current-theme.conf")
        os.system("rm ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_daisies ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_minimal ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_magic ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_fall")
        os.system("touch ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_daisies")
        if self.main_window and hasattr(self.main_window, 'switch_to_theme_1'):
            self.main_window.switch_to_theme_1(widget)

    def Set_Theme_Minimal(self, widget):
        os.system(f"killall quickshell; quickshell -p {self.script_dir}/../../quickshell/minimal_quickshell & disown")
        os.system("killall swaybg; swaybg -m fill -i ~/.TacOS_Stuff/swaybg/arch_rainbow.png & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/minimal_config.kdl ~/.config/niri/config.kdl")
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Fluent-pink-Dark"')
        os.system("gsettings set org.gnome.desktop.interface icon-theme Adwaita")
        os.system("cp ~/.TacOS_Stuff/assets/starship/starship.toml ~/.config/starship.toml")
        os.system("cp ~/.config/kitty/general-theme.conf ~/.config/kitty/current-theme.conf")
        os.system("rm ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_daisies ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_minimal ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_magic ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_fall")
        os.system("touch ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_minimal")
        if self.main_window and hasattr(self.main_window, 'switch_to_theme_1'):
            self.main_window.switch_to_theme_1(widget)

    def Set_Theme_Winter(self, widget):
        os.system(f"killall quickshell; quickshell -p {self.script_dir}/../../quickshell/winter_quickshell & disown")
        os.system("killall swaybg; swaybg -m fill -i ~/.TacOS_Stuff/swaybg/winter_background.jpg & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/magic_config.kdl ~/.config/niri/config.kdl")
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Fluent-pink-Light"')
        os.system("gsettings set org.gnome.desktop.interface icon-theme Adwaita")
        os.system("cp ~/.TacOS_Stuff/assets/starship/starship.toml ~/.config/starship.toml")
        os.system("cp ~/.config/kitty/general-theme.conf ~/.config/kitty/current-theme.conf")
        os.system("rm ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_daisies ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_minimal ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_magic ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_fall")
        os.system("touch ~/.TacOS_Stuff/TacOS_Settings_App/pages//General_Settings_Subfiles/current_theme_is_magic")
        if self.main_window and hasattr(self.main_window, 'switch_to_theme_2'):
            self.main_window.switch_to_theme_2(widget)

    def Set_Theme_Fall(self, widget):
        os.system(f"killall quickshell; quickshell -p {self.script_dir}/../../quickshell/halloween_quickshell & disown")
        os.system("killall swaybg; swaybg -m fill -i ~/.TacOS_Stuff/swaybg/halloween.jpg & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/fall_config.kdl ~/.config/niri/config.kdl")
        os.system("cp ~/.config/kitty/halloween-theme.conf ~/.config/kitty/current-theme.conf")
        os.system("cp ~/.TacOS_Stuff/assets/starship/halloween-starship.toml ~/.config/starship.toml")
        os.system("rm ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_daisies ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_minimal ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_magic ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_fall")
        os.system("touch ~/.TacOS_Stuff/TacOS_Settings_App/pages/General_Settings_Subfiles/current_theme_is_fall")
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Material-Black-Cherry-3.38"')
        os.system("gsettings set org.gnome.desktop.interface icon-theme ACYLS")
        if self.main_window and hasattr(self.main_window, 'switch_to_theme_1'):
            self.main_window.switch_to_theme_1(widget)
