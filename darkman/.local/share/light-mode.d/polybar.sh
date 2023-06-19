sed -i 's/mocha.ini/latte.ini/g' $HOME/.config/polybar/config
killall -USR1 polybar
