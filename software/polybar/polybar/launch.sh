# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start polybar
polybar main 2>&1 -r | tee -a /tmp/polybar1.log & disown