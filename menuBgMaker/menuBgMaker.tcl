# Tcl script to create menu background image for Half-Life

set scriptPath [file normalize [info script]]
set scriptDirPath [file dirname $scriptPath]
set libsDirPath [file join $scriptDirPath "libs"]
lappend auto_path $libsDirPath

package require "tclgd"

proc loadImg {path} {
    set file [open $path]
    fconfigure $file -translation "binary" -encoding "binary"

    set extension [file extension $path]
    set loweredExtension [string tolower $extension]

    switch $loweredExtension {
        ".jpeg" -
        ".jpg" {
            set img [GD create_from_jpeg "#auto" $file]
        }
        ".png" {
            set img [GD create_from_png "#auto" $file]
        }
        ".gif" {
            set img [GD create_from_gif "#auto" $file]
        }
    }

    close $file
    return $img
}

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

set inImgPath "input.png"
set inImg [loadImg $inImgPath]
set inImgW [$inImg width]
set inImgH [$inImg height]

set tileW [expr {int($inImgW / 3.125)}]
set tileH [expr {int($inImgH / 2.34375)}]
set tileW2 [expr {int($inImgW / 25)}]
set tileH2 [expr {int($inImgH / 6.81818181818)}]

set rowsCount 3
set colsCount 4
set alphabet {"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"}
set x 0
set y 0

for {set row 1} {$row <= $rowsCount} {incr row} {
    for {set col 1} {$col <= $colsCount} {incr col} {
        set x [expr {($col - 1) * $tileW}]
        set y [expr {($row - 1) * $tileH}]

        set curTileW $tileW
        set curTileH $tileH

        if {$row == $rowsCount} {
            set curTileH $tileH2
        }

        if {$col == $colsCount} {
            set curTileW $tileW2
        }

        set letter [lindex $alphabet [expr {$col - 1}]]
        set tileName "800_${row}_${letter}_loading"

        set tileImg [GD create_truecolor "#auto" $curTileW $curTileH]
        $tileImg copy $inImg 0 0 $x $y $curTileW $curTileH
        saveImg $tileImg "${tileName}.png"
    }
}
