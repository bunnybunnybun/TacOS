# ScrollingDE
This is a Desktop Environment for Arch Linux with automatic window management (Thanks to Niri!), intended for power users and power user wannabe's like me.

## Demo
Before you watch the demo, please read this so you understand what exactly this is. This is a desktop environment (DE). But what is that? Well, take for example Windows and MacOS. They have a lot of differences, but the most obvious one is that they look different. Everything that you see on your screen, except for the individual apps that you downloaded, is thanks to the desktop environment. That's why Windows and MacOS look so different; they have different DEs. On Linux however, there are many different DE's that you can choose from, allowing it to look however you want. I decided to make my own DE, and that's what this project is.

Also, please keep in mind that:
 - This is a very early prototype, and not anywhere near finished
 - I did not write this entirely from scratch, as that would take, maybe... years?

This DE only works on Arch Linux (and probably it's derivatives, such as CachyOS. But those have not been tested.), and I do not expect anyone to download a new operating system onto their computer just to test my DE. So, you can just watch the demo/showcase video. Go to the repository files and look for a file called ScrollingDEShowcaseVid.mov and watch that. (I could not figure out how to embed the video into this README)

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
 - And SO MUCH MORE :) :) 

## How to install
First of all, to anyone who has come to review/demo this, you don't need to install it, just watch the video. That being said, if you really want to install it (or if I forget how lol), heres how:
 - First of all, make sure you are working on a fresh base installation of Arch Linux.
 - Next, clone the contents of this repository onto your machine.
 - Then, cd into the folder you just cloned from this repo.
 - Run ./install_script. This will begin the installation process. You may be asked to enter your sudo password. Don't worry, I'm not trying to hack into your computer (you can check the source code if you want), it's just required by the package manager in order to install some of the base applications. It may also prompt you a few times to ask if you want to perform certain operations. Just click yes in order to get a proper installation.
 - You may have to manually install drivers for your device, ScrollingDE does not install them automaticaly. (Atleast not yet.)
 - And finaly, enjoy your new desktop!!!
