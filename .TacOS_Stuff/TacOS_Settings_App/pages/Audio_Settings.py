import gi
import os
import subprocess
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class AudioSettingsPage(Gtk.Box):
    def __init__(self):
        super().__init__(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        secondary_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)

        mute = subprocess.run(
            "pactl get-sink-mute @DEFAULT_SINK@",
            shell=True,
            capture_output=True,
            text=True
        )
        print(mute.stdout.strip())
        self.mute_value = mute.stdout.strip()
        if self.mute_value == "Mute: yes":
            self.mute_icon = ""
        else:
            self.mute_icon = ""

        current = subprocess.run(
            "pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1",
            shell=True,
            capture_output=True,
            text=True
        )

        current_volume = current.stdout.strip()
        volume_value = int(current_volume)

        self.label_ig = Gtk.Label(label="Adjust audio level")
        self.mute_button = Gtk.Button(label=self.mute_icon)
        self.mute_button.connect("clicked", self.on_mute_clicked)
        self.mute_button.set_valign(Gtk.Align.CENTER) 

        self.audio_slider = Gtk.Scale.new_with_range(
            orientation=Gtk.Orientation.VERTICAL,
            min=0,
            max=100,
            step=1
        )
        self.audio_slider.set_value(volume_value)
        self.audio_slider.set_inverted(True)
        self.audio_slider.get_style_context().add_class("audio_slider")
        self.audio_slider.connect("value-changed", self.on_value_changed)

        main_box.pack_start(self.label_ig, True, True, 0)
        secondary_box.pack_start(self.mute_button, False, False, 0)
        secondary_box.pack_start(self.audio_slider, True, True, 0)
        main_box.add(secondary_box)
        self.add(main_box)

    def on_value_changed(self, widget):
        value = self.audio_slider.get_value()
        os.system(f"pactl set-sink-volume @DEFAULT_SINK@ {value}%")

    def on_mute_clicked(self, widget):
        os.system("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        mute = subprocess.run(
            "pactl get-sink-mute @DEFAULT_SINK@",
            shell=True,
            capture_output=True,
            text=True
        )
        self.mute_value = mute.stdout.strip()
        if self.mute_value == "Mute: yes":
            self.mute_icon = ""
        else:
            self.mute_icon = ""
        self.mute_button.set_label(self.mute_icon)
