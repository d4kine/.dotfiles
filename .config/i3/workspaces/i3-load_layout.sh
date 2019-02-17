#!/bin/bash

i3-msg 'workspace 1; append_layout ~/.config/i3/workspaces/layout-1.json'
#i3-msg "workspace 2; append_layout ~/.config/i3/workspaces/layout-2.json"
i3-msg "workspace 5; append_layout ~/.config/i3/workspaces/layout-3.json"

sleep 0.5

i3-msg 'workspace 1; exec /usr/bin/nemo'
i3-msg 'workspace 1; exec /usr/bin/subl3'
i3-msg 'workspace 1; exec /usr/local/bin/st'

i3-msg 'workspace 2; exec /usr/bin/chromium'

i3-msg 'workspace 4; exec /usr/bin/mailspring'

i3-msg 'workspace 5; exec /usr/bin/telegram-desktop'
i3-msg 'workspace 5; exec /usr/bin/franz'
i3-msg 'workspace 5; exec /usr/bin/spotify --force-device-scale-factor=1.35'
i3-msg 'workspace 5; exec /usr/bin/nextcloud'
