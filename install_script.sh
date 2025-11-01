#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sudo pacman -Syu
sudo pacman -S --needed --noconfirm nemo fastfetch base-devel git sddm niri kitty mako fuzzel swaybg swayidle swaylock waybar xdg-desktop-portal-gnome python-pip tk xwayland-satellite hyprpaper ttf-jetbrains-mono-nerd vim starship gtk3 gtk4 libadwaita python-gobject
sudo systemctl enable sddm
pip install FreeSimpleGUI --break-system-packages
pip install kdl-py --break-system-packages
cp $SCRIPT_DIR/.TacOS_Stuff ~/ -r
sudo cp $SCRIPT_DIR/Theme\ Switcher.desktop /usr/share/applications/Theme\ Switcher.desktop
sudo cp $SCRIPT_DIR/TacOS_Settings_App/TacOS_Settings /usr/local/bin/
cp ~/.TacOS_Stuff/assets/niri/ ~/.config/ -r
cp ~/.TacOS_Stuff/assets/kitty/ ~/.config/ -r
cp ~/.TacOS_Stuff/assets/starship/starship.toml ~/.config/
sudo cp ~/.TacOS_Stuff/assets/fastfetch ~/.config/ -r
sudo cp ~/.TacOS_Stuff/assets/icons /usr/share/ -r
sudo cp -r ~/.TacOS_Stuff/assets/fuzzel /etc/xdg/
echo 'eval "$(starship init bash)"' >> ~/.bashrc
if [ -f "$HOME/.TacOS_Stuff/.yay_has_been_installed" ]; then
    echo "Yay has already been installed"
else
    cd ~/ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && touch ~/.TacOS_Stuff/.yay_has_been_installed && rm -rf yay
fi
yay -S --needed --noconfirm ungoogled-chromium-bin
yay -S --needed --noconfirm fluent-gtk-theme
yay -S --needed --noconfirm material-black-colors-theme
yay -S --needed --noconfirm gtk-layer-shell
if [ -f "$HOME/.TacOS_Stuff/.ACYLS_has_been_installed" ]; then
    echo "ACYLS theme has already been installed"
else
    git clone https://github.com/worron/ACYLS.git ~/.icons/ACYLS && touch ~/.TacOS_Stuff/.ACYLS_has_been_installed
fi

echo "TacOS setup finished! It is recommend that you reboot now. (You can reboot by typing reboot and then pressing enter)"