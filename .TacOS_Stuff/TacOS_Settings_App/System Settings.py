import sys
import gi

gi.require_version("Gtk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Adw, Gdk

css_provider = Gtk.CssProvider()
css_provider.load_from_path('style.css')
Gtk.StyleContext.add_provider_for_display(Gdk.Display.get_default(), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)

class MainWindow(Gtk.ApplicationWindow):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.set_default_size(700, 500)
        self.set_title("TacOS Settings")

        self.main_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        self.main_box.set_css_classes(['main_box'])
        self.set_child(self.main_box)

        self.box_1 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        self.box_2 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)

        General_Settings = Gtk.Box()
        Display_Settings = Gtk.Box()

        label_1 = Gtk.Label(label="This is the General Settings page.")
        label_2 = Gtk.Label(label="This is the Display Settings page.")
        General_Settings.append(label_1)
        Display_Settings.append(label_2)

        self.stack = Gtk.Stack()
        self.stack.set_transition_type(Gtk.StackTransitionType.CROSSFADE)
        self.stack.set_transition_duration(500)
        self.stack.add_titled(General_Settings, "General_Settings", "General Settings")
        self.stack.add_titled(Display_Settings, "Display_Settings", "Display Settings")
        self.switcher = Gtk.StackSwitcher()
        self.switcher.set_orientation(Gtk.Orientation.VERTICAL)
        self.switcher.set_stack(self.stack)

        self.box_1.append(self.switcher)
        self.box_2.append(self.stack)

        self.main_box.append(self.box_1)
        self.main_box.append(self.box_2)

class MyApp(Adw.Application):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.connect('activate', self.on_activate)
        

    def on_activate(self, app):
        self.win = MainWindow(application=app)
        self.win.present()

app = MyApp()
app.run(sys.argv)