Config { font = "-*-Fixed-Bold-R-Normal-*-16-*-*-*-*-*-*-*"
        , borderColor = "#212121"
        , border = TopB
        , bgColor = "#222222"
        , fgColor = "grey"
        , position = Top L 100
        , commands = [ 
                        Run Swap [] 1000
                      , Run Battery        [ "--template" , "<acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkgreen"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#dAA520>charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>charged</fc>"
                             ] 50
                        , Run Com "/bin/bash" ["-c", "~/bin/get-volume.sh"]  "myvolume" 1
                        , Run Com "whoami" [] "" 36000
                        , Run Date "%H:%M:%S" "date" 10
                        , Run Kbd [ ( "us", "<fc=grey>en</fc>")
                                   ,( "ru", "<fc=grey>ru</fc>")
                                  ]
                        , Run StdinReader
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%StdinReader% }{ <fc=#4f4f4f>%myvolume% %whoami%</fc> <fc=#4f4f4f>[</fc>%battery%<fc=#4f4f4f>]</fc> %kbd% <fc=grey>%date%</fc> "
        }	
