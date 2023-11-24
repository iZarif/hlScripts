# Tcl script to create btns_main image for Xash3D FWGS engine

set scriptPath [file normalize [info script]]
set scriptDirPath [file dirname $scriptPath]
set libsDirPath [file join $scriptDirPath "libs"]
lappend auto_path $libsDirPath

package require "tclgd"

proc saveImg {img path} {
    set file [open $path "w"]
    fconfigure $file -translation "binary" -encoding "binary"

    set extension [file extension $path]
    set loweredExtension [string tolower $extension]

    switch $loweredExtension {
        ".jpeg" -
        ".jpg" {
            $img write_jpeg $file 100
        }
        ".png" {
            $img write_png $file 9
        }
        ".gif" {
            $img write_gif $file
        }
    }

    close $file
}

set btns { \
    "New game" \
    "Resume game" \
    "Hazard course" \
    "Configuration" \
    "Load game" \
    "Save\\load game" \
    "View readme" \
    "Quit" \
    "Multiplayer" \
    "Easy" \
    "Medium" \
    "Difficult" \
    "Save game" \
    "Load game" \
    "Cancel" \
    "Game options" \
    "Video" \
    "Audio" \
    "Controls" \
    "Done" \
    "Quickstart" \
    "Use defaults" \
    "Ok" \
    "Video options" \
    "Video modes" \
    "Adv controls" \
    "Order Half-Life" \
    "Delete" \
    "Internet games" \
    "Chat rooms" \
    "LAN game" \
    "Customize" \
    "Skip" \
    "Exit" \
    "Connect" \
    "Refresh" \
    "Filter" \
    "Filter" \
    "Create" \
    "Create game" \
    "Chat rooms" \
    "List rooms" \
    "Search" \
    "Servers" \
    "Join" \
    "Find" \
    "Create room" \
    "Join game" \
    "Search games" \
    "Find game" \
    "Start game" \
    "View game info" \
    "Update" \
    "Add server" \
    "Disconnect" \
    "Console" \
    "Content control" \
    "Update" \
    "Visit WON" \
    "Previews" \
    "Adv options" \
    "3D info site" \
    "Custom game" \
    "Activate" \
    "Install" \
    "Visit web site" \
    "Refresh list" \
    "Deactivate" \
    "Adv options" \
    "Spectate game" \
    "Spectate games" \
}

set btnsCount [llength $btns]
set btnW 156
set btnPartH 26
set btnH [expr {$btnPartH * 3}]
set btnsImgH [expr {$btnH * $btnsCount}]
set fontPath "./PTSans-Regular.ttf"
set fontSize 12 ;# in points
set btnNum 1

set btnsImg [GD create_truecolor "#auto" $btnW $btnsImgH]

foreach btn $btns {
    set btnPartImg [GD create_truecolor "#auto" $btnW $btnPartH]
    set color [$btnPartImg allocate_color 0 255 0]
    set textBounds [$btnPartImg text_bounds $color $fontPath $fontSize 0 0 0 $btn]
    set textH [expr {[lindex $textBounds 1] - [lindex $textBounds 7]}]
    set textYOffset [expr {abs([lindex $textBounds 5])}]
    set x 5
    set y [expr {($btnPartH - $textH) / 2 + $textYOffset}]
    $btnPartImg text $color $fontPath $fontSize 0 $x $y $btn

    set x 0
    set y 0
    set btnImg [GD create_truecolor "#auto" $btnW $btnH]
    $btnImg copy $btnPartImg $x $y 0 0 $btnW $btnPartH

    set btnPartImg [GD create_truecolor "#auto" $btnW $btnPartH]
    set color [$btnPartImg allocate_color 0 0 255]
    set x 5
    set y [expr {($btnPartH - $textH) / 2 + $textYOffset}]
    $btnPartImg text $color $fontPath $fontSize 0 $x $y $btn

    set x 0
    set y $btnPartH
    $btnImg copy $btnPartImg $x $y 0 0 $btnW $btnPartH

    set btnPartImg [GD create_truecolor "#auto" $btnW $btnPartH]
    set color [$btnPartImg allocate_color 0 0 255]
    set x 5
    set y [expr {($btnPartH - $textH) / 2 + $textYOffset}]
    $btnPartImg text $color $fontPath $fontSize 0 $x $y $btn

    set x 0
    set y [expr {$btnPartH * 2}]
    $btnImg copy $btnPartImg $x $y 0 0 $btnW $btnPartH

    saveImg $btnImg "btn${btnNum}.png"

    set y [expr {$btnH * ($btnNum - 1)}]
    $btnsImg copy $btnImg $x $y 0 0 $btnW $btnH

    incr btnNum
}

saveImg $btnsImg "btns_main.png"
