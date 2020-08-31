-- Imports

import XMonad
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers (doCenterFloat)
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal :: [Char]
myTerminal      = "konsole"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask :: KeyMask
myModMask       = mod4Mask


xmobarEscape :: [Char] -> [Char]
xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

-- workspace with click support. From DT's config: https://gitlab.com/dwt1/dotfiles/-/blob/master/.xmonad/xmonad.hs
myWorkspaceNames :: [[Char]]
myWorkspaceNames = ["www","code","work","vm"]
myWorkspaces :: [[Char]]
myWorkspaces = clickable . (map xmobarEscape)
               $ myWorkspaceNames
  where
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..4] l,
                      let n = i ]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor :: [Char]
myNormalBorderColor  = "#282A36"
myFocusedBorderColor :: [Char]
myFocusedBorderColor = "#BD93F9"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: XConfig l -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
    , ((modm,               xK_space     ), spawn "rofi -show drun -lines 5")

     -- launch rofi-TODO
    , ((modm,               xK_p         ), spawn "rofi -modi TODO:.config/rofi/rofi-todo.sh -show TODO")

   -- close focused window
    , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask, xK_space ), sendMessage NextLayout)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Reize windows in resizable tall mode
    , ((modm .|. shiftMask, xK_l), sendMessage MirrorShrink)
    , ((modm .|. shiftMask, xK_h), sendMessage MirrorExpand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_e     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Mute audio
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")

    -- Take screenshot
    , ((modm              , xK_Print ), spawn "flameshot gui -d 2000 -r | xclip -selection clipboard -t image/png")

    -- Decrease volume
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")

    -- Increase volume
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")

    -- Toggle microphone
    , ((0, xK_F10), spawn "amixer -D pulse sset Capture toggle")

    -- cmus-remote controls
    , ((0, xF86XK_AudioPlay), spawn "cmus-remote -u")
    , ((0, xF86XK_AudioStop), spawn "killall cmus")
    , ((0, xF86XK_AudioNext), spawn "cmus-remote --next")
    , ((0, xF86XK_AudioPrev), spawn "cmus-remote --prev")

    -- Open CMUS and vimwiki scratchpads
    , ((0, xK_F9), namedScratchpadAction myScratchPads "cmus")
    , ((0, xK_F8), namedScratchpadAction myScratchPads "wiki")
    ]
    ++

    --
    -- mod-[1..4], Switch to workspace N
    -- mod-shift-[1..4], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_4]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- F1-F4 Switch to first 4 workspaces
    [((0, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_F1 .. xK_F4]
        , (f, m) <- [(W.greedyView, 0)]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]


-- Scratchpads. They act like drop down terminals
myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "cmus" spawnCmus findCmus manageCmus
                , NS "wiki" spawnWiki findWiki manageWiki]
    where
        spawnCmus = "terminator --title \"cmus\" -e cmus"
        findCmus = title =? "cmus"
        manageCmus = customFloating $ W.RationalRect l t w h
            where
                h = 0.7
                w = 0.7
                t = (1 - h)/2
                l = (1 - w)/2
        spawnWiki = "terminator --title \"vimwiki\" -e \"nvim -c 'let g:startify_disable_at_vimenter = 1' +VimwikiMakeDiaryNote\""
        findWiki = title =? "vimwiki"
        manageWiki = customFloating $ W.RationalRect l t w h
            where
                h = 0.80
                w = 0.46 -- roughly 80 character + gutter
                t = (1 - h)/2
                l = (1 - w)/2

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

myLayout = avoidStruts $ (tall ||| Mirror tall ||| full )
  where
     tall = renamed [Replace "tall"]
            $ smartBorders $ mySpacing 2
            $ ResizableTall nmaster delta ratio []
     full = smartBorders $ Full

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--

myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
     [ resource  =? "desktop_window"     --> doIgnore
     , className =? "Firefox"            --> (shiftAndSwitch 0)
     , className =? "Google-chrome"      --> (shiftAndSwitch 2)
     , className =? "FreeCAD"            --> (shiftAndSwitch 2)
     , className =? "VirtualBox Manager" --> (shiftAndSwitch 3)
     , title     =? "OtoDecks"           --> doFloat
     ] <+> namedScratchpadManageHook myScratchPads
         where
             shiftAndSwitch ws = do
                 spawn $ "xdotool key Super+" ++ show(ws+1)
                 doShift(myWorkspaces !! ws)

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook :: Event -> X All
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: X ()
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "xset r rate 250 60"
  spawnOnce "unclutter"
  spawnOnce "safeeyes"
  spawnOnce "xsetroot -cursor_name left_ptr"
  spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x292d3e --height 20 &"
  spawnOnce "setxkbmap -option ctrl:nocaps"
  spawnOnce "xcape -e \'Control_L=Escape\'"
  spawnOnce "redshift &"
  spawnOnce "klipper &"


------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobar.hs"
  xmonad $ docks defaults {
      logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor "#FF79C6" "" . shorten 50
          , ppCurrent = xmobarColor "#BD93F9" "" . wrap "(" ")"
          , ppHidden = xmobarColor "#FF79C6" "" . wrap " " " "
          , ppUrgent = xmobarColor "#FF5555" "" . wrap "!" "!"
          , ppHiddenNoWindows = xmobarColor "#4D4D4D" "" . wrap " " " "
          , ppSep = " | "
      }
      , manageHook = manageDocks <+> myManageHook
      , handleEventHook = docksEventHook
  }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
}
