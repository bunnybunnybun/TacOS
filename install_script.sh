#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sudo pacman -Syu
sudo pacman -S --needed --noconfirm nemo fastfetch base-devel git sddm niri kitty mako fuzzel swaybg swayidle swaylock waybar xdg-desktop-portal-gnome python-pip tk xwayland-satellite hyprpaper ttf-jetbrains-mono-nerd vim starship gtk3 gtk4 libadwaita python-gobject
sudo systemctl enable sddm
pip install FreeSimpleGUI --break-system-packages
pip install kdl-py --break-system-packages
cp $SCRIPT_DIR/.TacOS_Stuff ~/ -r
sudo cp $SCRIPT_DIR/Theme\ Switcher.desktop /usr/share/applications/Theme\ Switcher.desktop
cp ~/.TacOS_Stuff/assets/niri/ ~/.config/ -r
cp ~/.TacOS_Stuff/assets/kitty/ ~/.config/ -r
cp ~/.TacOS_Stuff/assets/starship/starship.toml ~/.config/
sudo cp ~/.TacOS_Stuff/assets/fastfetch ~/.config/ -r
sudo cp ~/.TacOS_Stuff/assets/icons /usr/share/ -r
sudo cp -r ~/.TacOS_Stuff/assets/fuzzel /etc/xdg/
echo 'eval "$(starship init bash)"' >> ~/.bashrc
if [ -f "/home/carlisle/.yay_has_been_installed" ]; then
    echo "Yay has already been installed"
else
    cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && touch ~/.yay_has_been_installed && rm -rf yay
fi
yay -S --needed --noconfirm ungoogled-chromium-bin fluent-gtk-theme material-black-colors-theme

echo "TacOS setup finished! It is recommend that you reboot now. (You can reboot by typing reboot and then pressing enter)"