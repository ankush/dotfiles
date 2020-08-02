Config { font = "xft:JetBrains Mono:pixelsize=14:antialias=true:hinting=true"
       , additionalFonts = []
       , borderColor = "black"
       , bgColor = "#282A36"
       , fgColor = "#4D4D4D"
       , alpha = 255
       , position = Bottom
       , lowerOnStart = True
       , pickBroadest = False
       , iconRoot = "/home/s4m/.xmonad/xpm" -- default: "."
       , persistent = False
       , hideOnStart = False
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run Network "enp1s0" ["-L","0","-H","32",
                                          "--normal","#8BE9FD","--high","#FF5555"] 50
                    , Run Cpu ["-t", "c: <total>%","-H","70","--high","#FF5555"] 50
                    , Run Memory ["-t","m: <usedratio>%"] 50
                    , Run Swap [] 10
                    , Run Com "uname" ["-s","-r"] "" 36000
                    , Run Date "%a %b %_d %Y %I:%M" "date" 300
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " <icon=haskell.xpm/>  %StdinReader% }\
                    \{ <fc=#F1FA8C>%cpu%</fc> | <fc=#FF6E67>%memory%</fc> |<fc=#8BE9FD> %enp1s0%</fc> | <fc=#50FA7B>%date%</fc> "
       }
