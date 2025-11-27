import FreeSimpleGUI as sg
import os
import time

sg.theme('Dark Blue 1')
def create_layout():
    return [
        [sg.Text('Choose a theme:')],
        [sg.Button('Daisies', key = 'Daisies'), sg.Button('Minimal', key = 'Minimal'), sg.Button('Magic', key = "Magic")]
    ]

window = sg.Window('Theme Switcher', create_layout(), resizable = False)

while True:
    event, values = window.read()

    if event == 'Daisies':
        sg.theme('Light Blue')
        window.close()
        window = sg.Window('Theme Switcher', create_layout(), resizable = False)
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/daisies_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/daisies_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/daisy_config.kdl ~/.config/niri/config.kdl")

    if event == 'Minimal':
        sg.theme('Python')
        window.close()
        window = sg.Window('Theme Switcher', create_layout(), resizable = False)
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/minimal_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/minimal_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/minimal_config.kdl ~/.config/niri/config.kdl")

    if event == "Magic":
        sg.theme('Dark Blue 1')
        window.close()
        window = sg.Window('Theme Switcher', create_layout(), resizable = False)
        os.system("killall waybar; waybar -c ~/.TacOS_Stuff/assets/waybar/config.jsonc -s ~/.TacOS_Stuff/assets/waybar/magic_style.css & disown")
        os.system("killall hyprpaper")
        time.sleep(0.1)
        os.system("hyprpaper --config ~/.TacOS_Stuff/assets/hyprpaper/magic_hyprpaper.conf & disown")
        os.system("cp ~/.TacOS_Stuff/assets/niri/magic_config.kdl ~/.config/niri/config.kdl")

    if event == sg.WIN_CLOSED:
        break

window.close()
