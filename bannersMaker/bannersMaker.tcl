# Tcl script to create menu banner images for Xash3D FWGS engine

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

set banners [list \
    [dict create "name" "head_advanced" "text" "Advanced controls"] \
    [dict create "name" "head_advoptions" "text" "Advanced options"] \
    [dict create "name" "head_audio" "text" "Audio"] \
    [dict create "name" "head_config" "text" "Configuration"] \
    [dict create "name" "head_controls" "text" "Controls"] \
    [dict create "name" "head_creategame" "text" "Create game"] \
    [dict create "name" "head_customize" "text" "Customize"] \
    [dict create "name" "head_custom" "text" "Custom game"] \
    [dict create "name" "head_gameopts" "text" "Game options"] \
    [dict create "name" "head_gamepad" "text" "Gamepad"] \
    [dict create "name" "head_inetgames" "text" "Internet games"] \
    [dict create "name" "head_lan" "text" "LAN game"] \
    [dict create "name" "head_load" "text" "Load game"] \
    [dict create "name" "head_multi" "text" "Multiplayer"] \
    [dict create "name" "head_newgame" "text" "New game"] \
    [dict create "name" "head_saveload" "text" "Save/load game"] \
    [dict create "name" "head_save" "text" "Save"] \
    [dict create "name" "head_touch_buttons" "text" "Touch buttons"] \
    [dict create "name" "head_touch_options" "text" "Touch options"] \
    [dict create "name" "head_touch" "text" "Touch"] \
    [dict create "name" "head_video" "text" "Video"] \
    [dict create "name" "head_vidmodes" "text" "Video modes"] \
    [dict create "name" "head_vidoptions" "text" "Video options"] \
]

set bannerW 460
set bannerH 80
set fontPath "./PTSans-Regular.ttf"
set fontSize 12 ;# in points
set x 5

foreach banner $banners {
    set name [dict get $banner "name"]
    set text [dict get $banner "text"]

    set bannerImg [GD create_truecolor "#auto" $bannerW $bannerH]
    set color [$bannerImg allocate_color 0 255 0]

    set textBounds [$bannerImg text_bounds $color $fontPath $fontSize 0 0 0 "# $text"]
    set textH [expr {[lindex $textBounds 1] - [lindex $textBounds 7]}]
    set textYOffset [expr {abs([lindex $textBounds 5])}]

    set y [expr {($bannerH - $textH) / 2 + $textYOffset}]

    $bannerImg text $color $fontPath $fontSize 0 $x $y "# $text"
    saveImg $bannerImg "${name}.png"
}

