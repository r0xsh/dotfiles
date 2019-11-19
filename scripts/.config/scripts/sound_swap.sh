get_sinks()
{
  pacmd list-sinks |\
    grep -E 'index:|device.description' |\
    sed -e 's/^ *//;s/ *$//' -e 's/^\t*//;s/ *$//' -e 's/^* //'|\
    sed -r -e 's/index: ([0-9]+)/[\1] /g' -e 's/device.description = "(.*)"/\1/g' |\
    sed -ze 's/] \n/] /g'
}

switch_sink_default()
{
  pacmd set-default-sink $1 || echo failed
}

switch_sink_applications()
{
  pacmd list-sink-inputs |
    awk '/index:/{print $2}' |
    xargs -r -I{} pacmd move-sink-input {} $1 ||
      echo failed
}

switch_sink()
{
  switch_sink_default      "$@"
  switch_sink_applications "$@"
}

switch_gui()
{


  sink=$(get_sinks | rofi -dmenu)

  switch_sink $(echo $sink | sed -re 's/^\[([0-9]+)\]/\1/' | cut -d' ' -f1 );


}

switch_gui
