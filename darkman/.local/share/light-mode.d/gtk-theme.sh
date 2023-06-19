#gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Latte-Standard-Blue-Light
#gsettings set org.gnome.desktop.interface color-scheme prefer-light
#sed -i 's/"Catppuccin-Latte-Standard-Blue-Light"/"Arc-Dark"/g' $HOME/.config/.gtkrc-2.0
sed -i 's/Catppuccin-Mocha-Standard-Blue-Dark/Catppuccin-Latte-Standard-Blue-Light/g' $HOME/.config/gtk-3.0/settings.ini
sed -i 's/Catppuccin-Mocha-Standard-Blue-Dark/Catppuccin-Latte-Standard-Blue-Light/g' $HOME/.gtkrc-2.0
#sed -i 's/style=Catppuccin-Latte-Standard-Blue-Light/style=Adwaita-Dark/g' $HOME/.dotfiles/.config/qt5ct/qt5ct.conf
