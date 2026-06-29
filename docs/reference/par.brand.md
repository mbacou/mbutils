# Graphical parameters for Bootstrap branded plots

Opinionated mods to base R plots compatible with new `_brand.yml`
feature. Does not load any brand by itself, explicitely call
[`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)
if needed instead.

## Usage

``` r
par.brand(fg = NULL, bg = NULL, font = "base", ...)
```

## Arguments

- fg:

  Bootstrap color **name** for text and line elements, or color code

- bg:

  Bootstrap color **name** for plot, panel background, or color code

- ...:

  Arguments passed on to
  [`graphics::par`](https://rdrr.io/r/graphics/par.html)

  `no.readonly`

  :   logical; if `TRUE` and there are no other arguments, only
      parameters are returned which can be set by a subsequent
      [`par()`](https://rdrr.io/r/graphics/par.html) call *on the same
      device*.

- family:

  one of `_brand.yml` font families (currently only `base`, `monospace`,
  or `headings`), else a valid System or Google font family name

## Value

a list of graphical parameters

## Examples

``` r
opar <- par(par.brand())
par()
#> $xlog
#> [1] FALSE
#> 
#> $ylog
#> [1] FALSE
#> 
#> $adj
#> [1] 0.5
#> 
#> $ann
#> [1] FALSE
#> 
#> $ask
#> [1] FALSE
#> 
#> $bg
#> [1] "#FDFCF9"
#> 
#> $bty
#> [1] "n"
#> 
#> $cex
#> [1] 1
#> 
#> $cex.axis
#> [1] 1
#> 
#> $cex.lab
#> [1] 1
#> 
#> $cex.main
#> [1] 1.5
#> 
#> $cex.sub
#> [1] 1.15
#> 
#> $cin
#> [1] 0.15 0.20
#> 
#> $col
#> [1] "#505050"
#> 
#> $col.axis
#> [1] "black"
#> 
#> $col.lab
#> [1] "#FDFCF9"
#> 
#> $col.main
#> [1] "#505050"
#> 
#> $col.sub
#> [1] "#50505080"
#> 
#> $cra
#> [1] 10.8 14.4
#> 
#> $crt
#> [1] 0
#> 
#> $csi
#> [1] 0.2
#> 
#> $cxy
#> [1] 0.02869898 0.04398827
#> 
#> $din
#> [1] 6.666667 6.666667
#> 
#> $err
#> [1] 0
#> 
#> $family
#> [1] "Roboto Condensed"
#> 
#> $fg
#> [1] "#505050"
#> 
#> $fig
#> [1] 0 1 0 1
#> 
#> $fin
#> [1] 6.666667 6.666667
#> 
#> $font
#> [1] 1
#> 
#> $font.axis
#> [1] 1
#> 
#> $font.lab
#> [1] 3
#> 
#> $font.main
#> [1] 1
#> 
#> $font.sub
#> [1] 1
#> 
#> $lab
#> [1] 5 5 7
#> 
#> $las
#> [1] 1
#> 
#> $lend
#> [1] "round"
#> 
#> $lheight
#> [1] 1
#> 
#> $ljoin
#> [1] "round"
#> 
#> $lmitre
#> [1] 10
#> 
#> $lty
#> [1] "solid"
#> 
#> $lwd
#> [1] 1
#> 
#> $mai
#> [1] 0.82 0.82 1.30 0.62
#> 
#> $mar
#> [1] 4.1 4.1 6.5 3.1
#> 
#> $mex
#> [1] 1
#> 
#> $mfcol
#> [1] 1 1
#> 
#> $mfg
#> [1] 1 1 1 1
#> 
#> $mfrow
#> [1] 1 1
#> 
#> $mgp
#> [1] 1.0 0.5 0.0
#> 
#> $mkh
#> [1] 0.001
#> 
#> $new
#> [1] FALSE
#> 
#> $oma
#> [1] 0 0 0 0
#> 
#> $omd
#> [1] 0 1 0 1
#> 
#> $omi
#> [1] 0 0 0 0
#> 
#> $page
#> [1] TRUE
#> 
#> $pch
#> [1] 1
#> 
#> $pin
#> [1] 5.226667 4.546667
#> 
#> $plt
#> [1] 0.123 0.907 0.123 0.805
#> 
#> $ps
#> [1] 12
#> 
#> $pty
#> [1] "m"
#> 
#> $smo
#> [1] 1
#> 
#> $srt
#> [1] 0
#> 
#> $tck
#> [1] 0.025
#> 
#> $tcl
#> [1] NA
#> 
#> $usr
#> [1] 0 1 0 1
#> 
#> $xaxp
#> [1] 0 1 5
#> 
#> $xaxs
#> [1] "r"
#> 
#> $xaxt
#> [1] "n"
#> 
#> $xpd
#> [1] FALSE
#> 
#> $yaxp
#> [1] 0 1 5
#> 
#> $yaxs
#> [1] "r"
#> 
#> $yaxt
#> [1] "n"
#> 
#> $ylbias
#> [1] 0.2
#> 
# Restore plotting device to default state
par(opar)
```
