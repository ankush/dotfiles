Config { font = "xft:JetBrainsMono NL Nerd Font:pixelsize=14:antialias=true:hinting=true"
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
       , commands = [ Run Network "wlp2s0" ["-t", " <rx>  <tx>"] 50
                    , Run Cpu ["-t", " <total>%","-H","70","--high","#FF5555"] 50
                    , Run Memory ["-t"," <usedratio>%"] 50
                    , Run Volume "default" "Master" [ "-t", " 墳 <volume>%<status>" , "--", "-O", "", "-o", " (mute)" ] 50
                    , Run Battery [ "--template" , "  <acstatus>" , "--" , "-o", "<left>%" , "-O", "AC <left>%" , "-i", "Charged" ] 50
                    , Run Date "<fc=#50FA7B>%a %d-%m %I:%M</fc>" "date" 600
                    , Run Com "/home/ankush/.config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 200
                    , Run UnsafeStdinReader
                    -- , Run Com "/home/ankush/bin/mic-status.sh" [] "microphone" 20
                    , Run Com "/home/ankush/bin/memento-mori.sh" [] "memento" 3600
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=haskell.xpm/> %UnsafeStdinReader% }\
                    \{ %memento%| <fc=#8BE9FD>%default:Master%</fc> | <fc=#F1FA8C>%cpu%</fc> | <fc=#FF6E67>%memory%</fc> | <fc=#8BE9FD>%wlp2s0%</fc> |<fc=#FF79C6>%battery%</fc> | %date% %trayerpad%"
       }
