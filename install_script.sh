#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sudo pacman -Syu
sudo pacman -S --needed --noconfirm nemo fastfetch base-devel git sddm niri kitty mako fuzzel swaybg swayidle swaylock waybar xdg-desktop-portal-gnome python-pip tk xwayland-satellite hyprpaper ttf-jetbrains-mono-nerd vim starship
sudo systemctl enable sddm
pip install FreeSimpleGUI --break-system-packages
sudo cp $SCRIPT_DIR/.scrolling_de_stuff ~/ -r
sudo cp $SCRIPT_DIR/Theme\ Switcher.desktop /usr/share/applications/Theme\ Switcher.desktop
cp ~/.scrolling_de_stuff/assets/niri/ ~/.config/ -r
cp ~/.scrolling_de_stuff/assets/kitty/ ~/.config/ -r
cp ~/.scrolling_de_stuff/assets/starship/starship.toml ~/.config/
sudo cp ~/.scrolling_de_stuff/assets/fastfetch ~/.config/ -r
sudo cp ~/.scrolling_de_stuff/assets/icons /usr/share/ -r
echo 'eval "$(starship init bash)"' >> ~/.bashrc
if [ -f "/home/carlisle/.yay_has_been_installed" ]; then
    echo "Yay has already been installed"
else
    cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && touch ~/.yay_has_been_installed && rm -rf yay
fi
yay -S --needed ungoogled-chromium-bin --noconfirm

echo "ScrollingDE setup finished! It is recommend that you reboot now. (You can reboot by typing reboot and then pressing enter)"