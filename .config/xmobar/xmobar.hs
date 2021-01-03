Config { font = "xft:JetBrainsMono Nerd Font:pixelsize=14:antialias=true:hinting=true"
       , additionalFonts = []
       , borderColor = "black"
       , bgColor = "#282A36"
       , fgColor = "#4D4D4D"
       , alpha = 255
       , position = Top
       , lowerOnStart = True
       , pickBroadest = False
       , iconRoot = "/home/ankush/.xmonad/xpm" -- default: "."
       , persistent = False
       , hideOnStart = False
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run Network "enp1s0" ["-t", " <rx>  <tx>"] 50
                    , Run Cpu ["-t", " <total>%","-H","70","--high","#FF5555"] 50
                    , Run Memory ["-t"," <usedratio>%"] 50
                    , Run Com "/home/ankush/.config/cmus/now-playing.sh" [] "cmus" 50
                    , Run Date "<fc=#50FA7B>%a %d-%m %I:%M</fc>" "date" 600
                    , Run Com "/home/ankush/.config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 200
                    , Run UnsafeStdinReader
                    , Run Com "/home/ankush/.config/custom-scripts/mic-status.sh" [] "microphone" 20
                    , Run Com "/home/ankush/.config/custom-scripts/memento-mori.sh" [] "memento" 600
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=haskell.xpm/> %UnsafeStdinReader% }\
                    \{ %memento%|<fc=#FF79C6>%cmus%</fc>|%microphone%|<fc=#F1FA8C>%cpu%</fc>|<fc=#FF6E67>%memory%</fc>|<fc=#8BE9FD>%enp1s0%</fc>|%date%%trayerpad%"
       }
