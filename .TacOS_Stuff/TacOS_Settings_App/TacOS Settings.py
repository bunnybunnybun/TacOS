import sys
import gi
from pages.General_Settings import GeneralSettingsPage
from pages.Display_Settings import DisplaySettingsPage
from pages.Other_Settings import OtherSettingsPage
from pages.Audio_Settings import AudioSettingsPage

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

css_provider = Gtk.CssProvider()
css_provider.load_from_path("style.css")

screen = Gdk.Screen.get_default()
style_context = Gtk.StyleContext()
style_context.add_provider_for_screen(
    screen,
    css_provider,
    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
)

class MainWindow(Gtk.Window):
    def __init__(self):
        super().__init__(title="TacOS Settings")
        self.set_default_size(600, 400)

        self.main_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        self.main_box.get_style_context().add_class("main_box")

        self.box_1 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        self.box_1.get_style_context().add_class("box_1")
        self.box_2 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        
        self.general_settings_page = GeneralSettingsPage()
        self.audio_settings_page = AudioSettingsPage()
        self.display_settings_page = DisplaySettingsPage()
        self.other_settings_page = OtherSettingsPage()

        self.stack = Gtk.Stack()
        self.stack.set_transition_type(Gtk.StackTransitionType.CROSSFADE)
        self.stack.set_transition_duration(500)
        self.stack.add_titled(self.general_settings_page, "General_Settings", "General Settings")
        self.stack.add_titled(self.audio_settings_page, "Audo_Settings", "Audio Settings")
        self.stack.add_titled(self.display_settings_page, "Display_Settings", "Display Settings")
        self.stack.add_titled(self.other_settings_page, "Other_Settings", "Other Settings")
        self.switcher = Gtk.StackSidebar()
        self.switcher.set_stack(self.stack)

        self.box_1.pack_start(self.switcher, True, True, 0)
        self.box_2.add(self.stack)

        self.main_box.add(self.box_1)
        self.main_box.add(self.box_2)

        self.add(self.main_box)

win = MainWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()