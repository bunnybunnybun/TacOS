import math

import cairo
import gi

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, GLib

gi.require_version('GtkLayerShell', '0.1')
from gi.repository import GtkLayerShell

def on_draw(widget, cr):
    cr.set_source_rgba(0, 0, 0, 0.2)
    cr.paint()
    return True

def main():
    win = Gtk.Window()
    win.connect('destroy', Gtk.main_quit)

    # allow the background to be painted transparent
    win.set_app_paintable(True)

    # enable pass-through for click events
    null_region = cairo.Region(cairo.RectangleInt(0, 0, 0, 0))
    win.input_shape_combine_region(null_region)

    drawingarea = Gtk.DrawingArea()
    drawingarea.set_size_request(1920, 1200)
    drawingarea.connect('draw', on_draw)
    win.add(drawingarea)

    GtkLayerShell.init_for_window(win)
    GtkLayerShell.set_layer(win, GtkLayerShell.Layer.OVERLAY)
    GtkLayerShell.set_anchor(win, GtkLayerShell.Edge.TOP, 0)
    GtkLayerShell.set_anchor(win, GtkLayerShell.Edge.RIGHT, 0)

    drawingarea.queue_draw()

    win.show_all()
    Gtk.main()

if __name__ == '__main__':
    main()