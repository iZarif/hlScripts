# Tcl script to create HD menu background image for Half-Life

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

set tileW [expr {int($inImgW / 15)}]
set tileH [expr {int($inImgH / 6.25)}]
set tileH2 [expr {int($inImgH / 25)}]

set rowsCount 7
set colsCount 15
set alphabet {"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"}
set x 0
set y 0

for {set row 1} {$row <= $rowsCount} {incr row} {
    for {set col 1} {$col <= $colsCount} {incr col} {
        set x [expr {($col - 1) * $tileW}]
        set y [expr {($row - 1) * $tileH}]

        set curTileH $tileH

        if {$row == $rowsCount} {
            set curTileH $tileH2
        }

        set letter [lindex $alphabet [expr {$col - 1}]]
        set tileName "21_9_${row}_${letter}_loading"

        set tileImg [GD create_truecolor "#auto" $tileW $curTileH]
        $tileImg copy $inImg 0 0 $x $y $tileW $curTileH
        saveImg $tileImg "${tileName}.png"
    }
}
