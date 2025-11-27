import gi
import os
import subprocess
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

script_dir = os.path.dirname(os.path.abspath(__file__))

css_provider = Gtk.CssProvider()
css_provider.load_from_path(f"{script_dir}/wallpaper_creator_style.css")

screen = Gdk.Screen.get_default()
style_context = Gtk.StyleContext()
style_context.add_provider_for_screen(
    screen,
    css_provider,
    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
)

class MainWindow(Gtk.Window):
    def __init__(self):
        super().__init__(title="Wallpaper creator")
        self.set_default_size(500, 500)

        self.file_paths = {
            "background": None,
            "foreground_1": None,
            "foreground_2": None
        }

        self.main_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        self.main_box.get_style_context().add_class("main")
        self.left_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        self.left_box.get_style_context().add_class("left")
        self.left_box.set_size_request(200,200)
        self.left_box.set_valign(Gtk.Align.START)

        self.background_settings = self.BackgroundSettings(self)
        self.foreground_1_settings = self.Foreground1Settings(self)
        self.foreground_2_settings = self.Foreground2Settings(self)

        self.stack = Gtk.Stack()
        self.stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT)
        self.stack.set_transition_duration(500)
        self.stack.add_titled(self.background_settings, "Background", "Background (layer 1)")
        self.stack.add_titled(self.foreground_1_settings, "Foreground 1", "Foreground 1 (layer 2)")
        self.stack.add_titled(self.foreground_2_settings, "Foreground 2", "Foreground 2 (layer 3)")
        self.switcher = Gtk.StackSidebar()
        self.switcher.set_stack(self.stack)
        self.switcher.set_size_request(200,200)

        self.set_as_wallpaper_button = Gtk.Button(label="Set as wallpaper")
        self.set_as_wallpaper_button.set_halign(Gtk.Align.START)
        self.set_as_wallpaper_button.connect("clicked", self.set_as_wallpaper)
        
        self.left_box.pack_start(self.switcher, False, False, 0)
        self.left_box.pack_start(self.set_as_wallpaper_button, False, False, 0)
        self.main_box.pack_start(self.left_box, False, False, 0)
        self.main_box.pack_start(self.stack, False, False, 0)
        self.add(self.main_box)

    def on_file_selected(self, file_chooser):
        button_id = file_chooser.get_name()
        self.file_paths[button_id] = file_chooser.get_filename()
        #self.filename = file_chooser.get_filename()
        print(f"[{button_id}] {self.file_paths[button_id]}")

    def set_as_wallpaper(self, widget):
        print("Setting the wallpaper...")
        background = self.file_paths.get("background", "")
        foreground1 = self.file_paths.get("foreground_1", "")
        foreground2 = self.file_paths.get("foreground_2", "")
        foreground_1_offset_x = self.foreground_1_settings.foreground_1_offset_entry_x.get_text()
        foreground_1_offset_y = self.foreground_1_settings.foreground_1_offset_entry_y.get_text()
        foreground_2_offset_x = self.foreground_2_settings.foreground_2_offset_entry_x.get_text()
        foreground_2_offset_y = self.foreground_2_settings.foreground_2_offset_entry_y.get_text()
        foreground_1_intensity = self.foreground_1_settings.fg_1_intensity_slider.get_value()
        foreground_2_intensity = self.foreground_2_settings.fg_2_intensity_slider.get_value()
        subprocess.Popen([
            "pkill",  "-f", "wallpaper_engine.py",
        ], start_new_session=True)
        subprocess.Popen([
            "python3",
            os.path.expanduser("~/Idk-yet/Idk-yet/wallpaper_creator_app/parallax_wallpaper.py"),
            background,
            foreground1,
            foreground2,
            str(foreground_1_offset_x),
            str(foreground_1_offset_y),
            str(foreground_2_offset_x),
            str(foreground_2_offset_y),
            str(foreground_1_intensity),
            str(foreground_2_intensity),
        ], start_new_session=True)

    def open_file_chooser(self, button, file_type):
        dialog = Gtk.FileChooserDialog(
            title="Select Image",
            parent=self,
            action=Gtk.FileChooserAction.OPEN
        )
        dialog.add_buttons(
            Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
            Gtk.STOCK_OPEN, Gtk.ResponseType.ACCEPT
        )
        response = dialog.run()
        if response == Gtk.ResponseType.ACCEPT:
            self.file_paths[file_type] = dialog.get_filename()
            button.set_label(f"{os.path.basename(dialog.get_filename())} ")
        dialog.destroy()

    class BackgroundSettings(Gtk.Box):
        def __init__(self, parent):
            super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)
            self.get_style_context().add_class("settings")

            self.background_label = Gtk.Label(label="Choose the background image:")
            self.background_label.get_style_context().add_class("header")
            self.background_label.set_halign(Gtk.Align.START)

            self.choose_background_image_button = Gtk.Button(label="Select image ")
            self.choose_background_image_button.connect("clicked", parent.open_file_chooser, "background")
            self.choose_background_image_button.set_name("background")
            self.choose_background_image_button.set_halign(Gtk.Align.START)

            self.pack_start(self.background_label, False, False, 0)
            self.pack_start(self.choose_background_image_button, False, False, 0)

    class Foreground1Settings(Gtk.Box):
        def __init__(self, parent):
            super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)
            self.get_style_context().add_class("settings")

            self.foreground_1_label = Gtk.Label(label="Choose the first foreground image:")
            self.foreground_1_label.get_style_context().add_class("header")
            self.foreground_1_label.set_halign(Gtk.Align.START)

            self.choose_foreground_1_image_button = Gtk.Button(label="Select image ")
            self.choose_foreground_1_image_button.connect("clicked", parent.open_file_chooser, "foreground_1")
            self.choose_foreground_1_image_button.set_name("foreground_1")
            self.choose_foreground_1_image_button.set_halign(Gtk.Align.START)

            self.fg_1_intensity_slider_label = Gtk.Label(label="Set how intensely this layer reacts to cursor movement:")
            self.fg_1_intensity_slider_label.get_style_context().add_class("explainer")
            self.fg_1_intensity_slider = Gtk.Scale.new_with_range(
                orientation=Gtk.Orientation.HORIZONTAL,
                min=-2,
                max=2,
                step=0.01
            )
            self.fg_1_intensity_slider.set_value(-0.4)

            self.fg_1_offset_x_label = Gtk.Label(label="Choose how the image should be offset, in pixels,\nfrom the center of the screen in the X axis:")
            self.fg_1_offset_x_label.set_halign(Gtk.Align.START)
            self.fg_1_offset_x_label.get_style_context().add_class("explainer")
            self.foreground_1_offset_entry_x = Gtk.Entry()
            self.foreground_1_offset_entry_x.set_halign(Gtk.Align.START)
            self.foreground_1_offset_entry_x.set_text("0")

            self.fg_1_offset_y_label = Gtk.Label(label="Choose how the image should be offset, in pixels,\nfrom the center of the screen in the Y axis:")
            self.fg_1_offset_y_label.set_halign(Gtk.Align.START)
            self.fg_1_offset_y_label.get_style_context().add_class("explainer")
            self.foreground_1_offset_entry_y = Gtk.Entry()
            self.foreground_1_offset_entry_y.set_halign(Gtk.Align.START)
            self.foreground_1_offset_entry_y.set_text("0")

            self.pack_start(self.foreground_1_label, False, False, 0)
            self.pack_start(self.choose_foreground_1_image_button, False, False, 0)
            self.pack_start(self.fg_1_intensity_slider_label, False, False, 0)
            self.pack_start(self.fg_1_intensity_slider, False, False, 0)
            self.pack_start(self.fg_1_offset_x_label, False, False, 0)
            self.pack_start(self.foreground_1_offset_entry_x, False, False, 0)
            self.pack_start(self.fg_1_offset_y_label, False, False, 0)
            self.pack_start(self.foreground_1_offset_entry_y, False, False, 0)

    class Foreground2Settings(Gtk.Box):
        def __init__(self, parent):
            super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)
            self.get_style_context().add_class("settings")

            self.foreground_2_label = Gtk.Label(label="Choose the second foreground image:")
            self.foreground_2_label.get_style_context().add_class("header")
            self.foreground_2_label.set_halign(Gtk.Align.START)

            self.choose_foreground_2_image_button = Gtk.Button(label="Select image ")
            self.choose_foreground_2_image_button.connect("clicked", parent.open_file_chooser, "foreground_2")
            self.choose_foreground_2_image_button.set_name("foreground_2")
            self.choose_foreground_2_image_button.set_halign(Gtk.Align.START)

            self.fg_2_intensity_slider_label = Gtk.Label(label="Set how intensely this layer reacts to cursor movement:")
            self.fg_2_intensity_slider_label.get_style_context().add_class("explainer")
            self.fg_2_intensity_slider = Gtk.Scale.new_with_range(
                orientation=Gtk.Orientation.HORIZONTAL,
                min=-2,
                max=2,
                step=0.01
            )
            self.fg_2_intensity_slider.set_value(0.4)

            self.fg_2_offset_x_label = Gtk.Label(label="Choose how the image should be offset, in pixels,\nfrom the center of the screen in the X axis:")
            self.fg_2_offset_x_label.set_halign(Gtk.Align.START)
            self.fg_2_offset_x_label.get_style_context().add_class("explainer")
            self.foreground_2_offset_entry_x = Gtk.Entry()
            self.foreground_2_offset_entry_x.set_halign(Gtk.Align.START)
            self.foreground_2_offset_entry_x.set_text("0")

            self.fg_2_offset_y_label = Gtk.Label(label="Choose how the image should be offset, in pixels,\nfrom the center of the screen in the Y axis:")
            self.fg_2_offset_y_label.set_halign(Gtk.Align.START)
            self.fg_2_offset_y_label.get_style_context().add_class("explainer")
            self.foreground_2_offset_entry_y = Gtk.Entry()
            self.foreground_2_offset_entry_y.set_halign(Gtk.Align.START)
            self.foreground_2_offset_entry_y.set_text("0")

            self.pack_start(self.foreground_2_label, False, False, 0)
            self.pack_start(self.choose_foreground_2_image_button, False, False, 0)
            self.pack_start(self.fg_2_intensity_slider_label, False, False, 0)
            self.pack_start(self.fg_2_intensity_slider, False, False, 0)
            self.pack_start(self.fg_2_offset_x_label, False, False, 0)
            self.pack_start(self.foreground_2_offset_entry_x, False, False, 0)
            self.pack_start(self.fg_2_offset_y_label, False, False, 0)
            self.pack_start(self.foreground_2_offset_entry_y, False, False, 0)

win = MainWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()