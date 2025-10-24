import gi
import os
import time
from pages.General_Settings_Subfiles.set_focus_ring_width import set_focus_ring_width_daisies
from pages.General_Settings_Subfiles.set_focus_ring_width import set_focus_ring_width_minimal
from pages.General_Settings_Subfiles.set_focus_ring_width import set_focus_ring_width_magic
from pages.General_Settings_Subfiles.set_focus_ring_width import set_focus_ring_width_fall
from pages.General_Settings_Subfiles.set_focus_ring_color import set_focus_ring_color_daisies
from pages.General_Settings_Subfiles.set_focus_ring_color import set_focus_ring_color_minimal
from pages.General_Settings_Subfiles.set_focus_ring_color import set_focus_ring_color_magic
from pages.General_Settings_Subfiles.set_focus_ring_color import set_focus_ring_color_fall

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class GeneralSettingsPage(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        label_1 = Gtk.Label(label="Choose a theme:")
        theme_grid = Gtk.Grid()

        self.script_dir = os.path.dirname(os.path.abspath(__file__))

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
        theme_button_4.connect("clicked", self.Set_Theme_Fall)
        theme_button_4.get_style_context().add_class("button_theme_fall")
        light_mode_button = Gtk.Button(label="Light mode")
        light_mode_button.connect("clicked", self.Light_Mode)
        dark_mode_button = Gtk.Button(label="Dark mode")
        dark_mode_button.connect("clicked", self.Dark_Mode)
        black_mode_button = Gtk.Button(label="Black mode")
        black_mode_button.connect("clicked", self.Black_Mode)
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

        if os.path.exists(f"{self.script_dir}/General_Settings_Subfiles/current_theme_is_daisies"):
            set_focus_ring_color_daisies(None, color_value)
        elif os.path.exists(f"{self.script_dir}/General_Settings_Subfiles/current_theme_is_minimal"):
            set_focus_ring_color_minimal(None, color_value)
        elif os.path.exists(f"{self.script_dir}/General_Settings_Subfiles/current_theme_is_magic"):
            set_focus_ring_color_magic(None, color_value)
        elif os.path.exists(f"{self.script_dir}/General_Settings_Subfiles/current_theme_is_fall"):
            set_focus_ring_color_fall(None, color_value)

    def Light_Mode(self, widget):
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Emacs"')

    def Dark_Mode(self, widget):
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Fluent-pink"')
    
    def Black_Mode(self, widget):
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Material-Black-Plum-3.38"')

    def on_scale_changed(self, scale):
        value = scale.get_value()
        if os.path.exists(f"{self.script_dir}/General_Settings_Subfiles/current_theme_is_daisies"):
            set_focus_ring_width_daisies(None, value)
        elif os.path.exists(f"{self.script_dir}/General_Settings_Subfiles/current_theme_is_minimal"):
            set_focus_ring_width_minimal(None, value)
        elif os.path.exists(f"{self.script_dir}/General_Settings_Subfiles/current_theme_is_magic"):
            set_focus_ring_width_magic(None, value)
        elif os.path.exists(f"{self.script_dir}/General_Settings_Subfiles/current_theme_is_fall"):
            set_focus_ring_width_fall(None, value)

    def Set_Theme_Daisies(self, widget):
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/daisies_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/daisies_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/daisy_config.kdl ~/.config/niri/config.kdl")
        os.system(f"rm {self.script_dir}/General_Settings_Subfiles/current_theme_is_daisies {self.script_dir}/General_Settings_Subfiles/current_theme_is_minimal {self.script_dir}/General_Settings_Subfiles/current_theme_is_magic {self.script_dir}/General_Settings_Subfiles/current_theme_is_fall")
        os.system(f"touch {self.script_dir}/General_Settings_Subfiles/current_theme_is_daisies")

    def Set_Theme_Minimal(self, widget):
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/minimal_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/minimal_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/minimal_config.kdl ~/.config/niri/config.kdl")
        os.system(f"rm {self.script_dir}/General_Settings_Subfiles/current_theme_is_daisies {self.script_dir}/General_Settings_Subfiles/current_theme_is_minimal {self.script_dir}/General_Settings_Subfiles/current_theme_is_magic {self.script_dir}/General_Settings_Subfiles/current_theme_is_fall")
        os.system(f"touch {self.script_dir}/General_Settings_Subfiles/current_theme_is_minimal")

    def Set_Theme_Magic(self, widget):
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/magic_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/magic_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/magic_config.kdl ~/.config/niri/config.kdl")
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Material-Black-Plum-3.38"')
        os.system(f"rm {self.script_dir}/General_Settings_Subfiles/current_theme_is_daisies {self.script_dir}/General_Settings_Subfiles/current_theme_is_minimal {self.script_dir}/General_Settings_Subfiles/current_theme_is_magic {self.script_dir}/General_Settings_Subfiles/current_theme_is_fall")
        os.system(f"touch {self.script_dir}/General_Settings_Subfiles/current_theme_is_magic")

    def Set_Theme_Fall(self, widget):
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/fall_config.jsonc -s ~/.TacOS_Stuff/assets/waybar/fall_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/fall_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/fall_config.kdl ~/.config/niri/config.kdl")
        os.system(f"rm {self.script_dir}/General_Settings_Subfiles/current_theme_is_daisies {self.script_dir}/General_Settings_Subfiles/current_theme_is_minimal {self.script_dir}/General_Settings_Subfiles/current_theme_is_magic {self.script_dir}/General_Settings_Subfiles/current_theme_is_fall")
        os.system(f"touch {self.script_dir}/General_Settings_Subfiles/current_theme_is_fall")
        os.system('gsettings set org.gnome.desktop.interface gtk-theme "Material-Black-Mango-3.38"')
