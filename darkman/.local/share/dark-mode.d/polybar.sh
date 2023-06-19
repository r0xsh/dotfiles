sed -i 's/latte.ini/mocha.ini/g' $HOME/.config/polybar/config
killall -USR1 polybar
