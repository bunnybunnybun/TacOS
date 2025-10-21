# TacOS
This is an operating system based on Arch Linux, designed for power users and power user wannabe's like me!

Also, please keep in mind that:
 - This is a very early prototype, and not anywhere near finished
 - I did not write this entirely from scratch, as that would take, maybe... years?

## Features
 - Auto tiling window management, with the ability to scroll through your windows. Watch the demo video to see what I mean.
 - Dynamic workspaces. Use different workspaces to stay organized!
 - Keyboard driven; you can operate the system completely without a mouse, if you are inclined to do so :)
 - Preset themes. Use the Theme Switcher application to switch between beautiful, premade themes!
 - Smooth animations to please your eyes...
 - Extremely customizable; If you don't like any of the premade themes, you can customize everything to exactly how you like it!

 ## Todos/coming soon
 - A simple unified settings app, to be able to change all the basic system settings (like wallpaper, panel configuration, bluetooth settings etc) from one app.
 - Actually create the demo video :(
 - Add more preset themes!
 - Support for logging in with a fingerprint reader
 - Improve the way notifications are handled
 - Add a polkit authentification agent
 - And SO MUCH MORE :) :) 

## How to install
First of all, to anyone who has come to review/demo this, you don't need to install it, just watch the video. That being said, if you really want to install it (or if I forget how lol), heres how:
 - First of all, make sure you are working on a fresh base installation of Arch Linux.
 - Next, clone the contents of this repository onto your machine.
 - Then, cd into the folder you just cloned from this repo.
 - Run ./install_script. This will begin the installation process. You may be asked to enter your sudo password. Don't worry, I'm not trying to hack into your computer (you can check the source code if you want), it's just required by the package manager in order to install some of the base applications. It may also prompt you a few times to ask if you want to perform certain operations. Just click yes in order to get a proper installation.
 - You may have to manually install drivers for your device, TacOS does not install them automaticaly. (Atleast not yet.)
 - And finaly, enjoy your new desktop!!!
