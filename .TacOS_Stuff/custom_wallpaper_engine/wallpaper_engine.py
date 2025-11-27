import cairo
import gi
import subprocess
import os
import threading
gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
gi.require_version("GdkPixbuf", "2.0")
gi.require_version("GtkLayerShell", "0.1")
from gi.repository import Gtk, Gdk, GdkPixbuf, GtkLayerShell, GLib

def set_wallpaper(background_path, foreground_path):
    windows = []
    display = Gdk.Display.get_default()
    screen = Gdk.Screen.get_default()

    css = "window { background-color: transparent; }"
    provider = Gtk.CssProvider()
    provider.load_from_data(css.encode())
    Gtk.StyleContext.add_provider_for_screen(
        screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )

    # Background window:

    for i in range(display.get_n_monitors()):
        monitor = display.get_monitor(i)
        monitor_geometry = monitor.get_geometry()

        window = Gtk.Window()
        GtkLayerShell.init_for_window(window)
        GtkLayerShell.set_layer(window, GtkLayerShell.Layer.BACKGROUND)
        GtkLayerShell.set_monitor(window, monitor)
        GtkLayerShell.set_exclusive_zone(window, 0) # Makes other apps render above the wallpaper
        panel_height = 50

        pixbuf = GdkPixbuf.Pixbuf.new_from_file(background_path)
        img_width, img_height = pixbuf.get_width(), pixbuf.get_height()
        screen_width, screen_height = monitor_geometry.width, monitor_geometry.height + panel_height

        img_ratio = img_width / img_height
        screen_ratio = screen_width / screen_height

        if img_ratio > screen_ratio:
            crop_height = img_height
            crop_width = int(img_height * screen_ratio)

        else:
            crop_width = img_width
            crop_height = int(img_width / screen_ratio)

        x = (img_width - crop_width) // 2
        y = (img_height - crop_height) // 2

        cropped = pixbuf.new_subpixbuf(x, y, crop_width, crop_height)

        scaled = cropped.scale_simple(
            monitor_geometry.width,
            monitor_geometry.height + panel_height,
            GdkPixbuf.InterpType.BILINEAR
        )

        image = Gtk.Image.new_from_pixbuf(scaled)
        window.add(image)
        window.fullscreen()
        window.show_all()
        windows.append(window)

    # Foreground window:

    fg_window = Gtk.Window()
    visual = screen.get_rgba_visual()
    if visual and screen.is_composited():
        fg_window.set_visual(visual)
    
    GtkLayerShell.init_for_window(fg_window)
    GtkLayerShell.set_layer(fg_window, GtkLayerShell.Layer.BOTTOM)
    GtkLayerShell.set_exclusive_zone(fg_window, -1)
    fg_window.set_accept_focus(False)

    drawing_area = Gtk.DrawingArea()
    drawing_area.set_size_request(1920*4, 1080*4)
    fg_window.add(drawing_area)
    fg_window.realize()
    drawing_area.realize()
    fg_window.fullscreen()
    fg_window.show_all()
    drawing_area.queue_draw()
    windows.append(fg_window)

    def size_check():
        alloc = drawing_area.get_allocation()
        print(f"size: {alloc.width}x{alloc.height}")
        return False
    GLib.idle_add(size_check)

    mouse_x, mouse_y = -1000, -1000
    offset = 20

    def on_draw(widget, ctx):
        if mouse_x < 0 or mouse_y < 0:
            return False

        if not hasattr(on_draw, "pixbuf"):
            on_draw.pixbuf = GdkPixbuf.Pixbuf.new_from_file(foreground_path)
        
        Gdk.cairo_set_source_pixbuf(ctx, on_draw.pixbuf, mouse_x + offset, mouse_y + offset)
        ctx.paint()
        return True

    drawing_area.connect("draw", on_draw)

    def update_mouse_position():
        global mouse_x, mouse_y

        try:
            coords = subprocess.check_output(
                [os.path.expanduser("~/wl-find-cursor/wl-find-cursor"), "-p"],
                text=True,
                timeout=1.0
            ).strip()

            mouse_x, mouse_y = map(int, coords.split())
            drawing_area.queue_draw()

            print(f"pos{mouse_x}, {mouse_y}")
        
        except Exception as e:
            print(f"Mouse tracking error: {e}")

        return True
    
    GLib.timeout_add(200, update_mouse_position)

    Gtk.main()

if __name__ == "__main__":
    set_wallpaper("/home/carlisle/Idk-yet/Idk-yet/swaybg/Daisies.jpg", "/home/carlisle/Idk-yet/Idk-yet/custom_wallpaper_engine/hmm.png")