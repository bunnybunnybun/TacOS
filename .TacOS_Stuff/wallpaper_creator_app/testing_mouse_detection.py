import os
import gi
import cairo
gi.require_version('Gtk', '3.0')
gi.require_version('GtkLayerShell', '0.1')
from gi.repository import Gtk, Gdk, GtkLayerShell, GLib

script_dir = os.path.dirname(os.path.abspath(__file__))

css_provider = Gtk.CssProvider()
css_provider.load_from_path(f"{script_dir}/testing_mouse_detection_style.css")

screen = Gdk.Screen.get_default()
style_context = Gtk.StyleContext()
style_context.add_provider_for_screen(
    screen,
    css_provider,
    Gtk.STYLE_PROVIDER_PRIORITY_USER
)

class ClickDetection(Gtk.Window):
    def __init__(self):
        super().__init__(title="Testing click detection")
        self.set_app_paintable(False)

        empty_region = cairo.Region(cairo.RectangleInt(0, 0, 0, 0))
        self.input_shape_combine_region(empty_region)

        GtkLayerShell.init_for_window(self)
        GtkLayerShell.set_layer(self, GtkLayerShell.Layer.OVERLAY)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.BOTTOM, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.LEFT, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, True)

        self.add_events(Gdk.EventMask.POINTER_MOTION_MASK)
        #self.connect("motion-notify-event", self.on_mouse_move)
        self.show_all()

        GLib.timeout_add(50, self.print_cursor_position)

    def on_mouse_move(self, widget, event):
        self.print_cursor_position()
        #print(f"TESTT: {event.x_root}, {event.y_root}")

    def print_cursor_position(self):
        display = Gdk.Display.get_default()
        seat = display.get_default_seat()
        pointer = seat.get_pointer()

        _, x, y = pointer.get_position()
        print(f"Cursor pos: {x}, {y}")
        return True

win = ClickDetection()
win.connect("destroy", Gtk.main_quit)
Gtk.main()