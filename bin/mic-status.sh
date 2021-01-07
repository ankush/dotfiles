#!/bin/bash

pactl list sources | grep -qi 'Mute: yes' && echo -n "<fc=#50FA7B> </fc>" || echo -n "<fc=#FF6E67> </fc>"
