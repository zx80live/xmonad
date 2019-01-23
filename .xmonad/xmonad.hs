import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Layout.Tabbed
import XMonad.Actions.SpawnOn
import System.IO
import XMonad.Util.Run
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Layout.Spacing
import XMonad.Hooks.EwmhDesktops

myManageHook = composeAll
  [
    className =? "Pidgin"   --> doFloat <+> doShift "3"
  , className =? "Skype"    --> doFloat <+> doShift "3"
  , resource  =? "calendar" --> doFloat
  ]


main = do
    -- autorun
    xmproc <- spawnPipe "setxkbmap -layout us,ru -option 'grp:shifts_toggle'"
    xmproc <- spawnPipe "stalonetray &"
    xmproc <- spawnPipe "feh --bg-scale /usr/share/wallpapers/openSUSEdefault/screenshot.jpg"
    xmproc <- spawnPipe "/home/pav/.cabal/bin/xmobar /home/pav/.xmonad/xmobar.hs"
    
    
    xmonad $ ewmh $  desktopConfig
        { terminal = "urxvt"
        --, modMask = mod4Mask
        , modMask = controlMask
        , workspaces = myWorkspaces
        , normalBorderColor = "#212121"
        , focusedBorderColor = "#3e3e3e"
        , borderWidth = 2
        , manageHook = myManageHook <+> manageSpawn <+> manageDocks <+> manageHook desktopConfig
        -- , layoutHook = avoidStruts  $  layoutHook desktopConfig
        , layoutHook = spacingRaw True (Border 2 2 2 2) True (Border 2 2 2 2) True $ avoidStruts  $  layoutHook desktopConfig

        , startupHook = do
            startupHook desktopConfig
            docksStartupHook

            spawnOn "1" "google-chrome-stable"
            spawnOn "1" "urxvt"
            spawnOn "3" "skypeforlinux"
            spawnOn "3" "pidgin"
            spawnOn "3" "urxvt -name calendar --hold -e cal -3"
            
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppCurrent = xmobarColor "#8bc08b" "" . wrap "<fc=black,#8bc08b> " " </fc>"
                        , ppTitle = xmobarColor "grey" "" . shorten 150 .wrap "   <fc=#3e3e3e>" "</fc>   "
                        , ppOrder = \(ws:l:t:_) -> [ws, t]
                        }

        } `additionalKeysP` myKeys

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace workspace program = do
                                      spawn program
                                      windows $ W.greedyView workspace

myWorkspaces = ["1", "2", "3", "4", "5", "6"]

myKeys = [
           ("<XF86AudioMute>",          spawn "pactl set-sink-volume 0 0%; test-volume")
         , ("<XF86AudioRaiseVolume>",   spawn "pactl set-sink-volume 0 +10%; test-volume")
         , ("<XF86AudioLowerVolume>",   spawn "pactl set-sink-volume 0 -10%; test-volume")
         , ("M1-<F2>", spawn "rofi -show run")
         , ("M1-<Tab>", spawn "rofi -show window")
         ]
                  
