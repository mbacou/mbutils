# Fetch Bootstrap branding

Make this package compatible with `brand.yml` unified branding features.
Branding can be read from a configuration file provided at run-time,
else it will use this package built-in theme.

## Usage

``` r
brand(file = "_brand.yml", font = c("base", "monospace", "headings"))
```

## Arguments

- file:

  path to `_brand.yml` configuration file, normally this file is
  auto-detected in the working tree, but may be specified here to swap
  branding dynamically.

- font:

  one of `_brand.yml` font families (currently only `base`, `monospace`,
  or `headings`).

## Value

List of branding elements similar in structure to `_brand.yml`

## Details

Refer to [brand.yml](https://posit-dev.github.io/brand-yml/) for
documentation.

Typically there is no need to call `brand()` directly. Instead use
[`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)
to apply plot branding across your active session.

TODO search more file locations

## References

[brand.yml](https://posit-dev.github.io/brand-yml/)

## See also

[`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)

## Examples

``` r
brand(font="monospace")
#> No `_brand.yml` config found in the working tree. Loaded built-in `Mel B. Labs` theme instead.
#> $meta
#> $meta$name
#> [1] "Mel B. Labs"
#> 
#> $meta$link
#> $meta$link$home
#> [1] "https://mbacou.github.io/mbutils"
#> 
#> $meta$link$github
#> [1] "https://github.com/mbacou/mbutils"
#> 
#> 
#> 
#> $color
#> $color$palette
#> $color$palette$cyan
#> [1] "#789494"
#> 
#> $color$palette$teal
#> [1] "#445e64"
#> 
#> $color$palette$dark
#> [1] "#222e32"
#> 
#> $color$palette$green
#> [1] "#27ae60"
#> 
#> $color$palette$blue
#> [1] "#3daee9"
#> 
#> $color$palette$purple
#> [1] "#9b59b6"
#> 
#> $color$palette$pink
#> [1] "#aea39a"
#> 
#> $color$palette$indigo
#> [1] "#98796f"
#> 
#> $color$palette$yellow
#> [1] "#eed04c"
#> 
#> $color$palette$orange
#> [1] "#ffac5e"
#> 
#> $color$palette$red
#> [1] "#da4453"
#> 
#> $color$palette$light
#> [1] "#fdfcf9"
#> 
#> $color$palette$gray
#> [1] "#505050"
#> 
#> 
#> $color$foreground
#> [1] "gray"
#> 
#> $color$background
#> [1] "light"
#> 
#> $color$primary
#> [1] "red"
#> 
#> $color$secondary
#> [1] "purple"
#> 
#> $color$info
#> [1] "blue"
#> 
#> 
#> $typography
#> $typography$fonts
#> $typography$fonts[[1]]
#> $typography$fonts[[1]]$family
#> [1] "Roboto Condensed"
#> 
#> $typography$fonts[[1]]$source
#> [1] "google"
#> 
#> $typography$fonts[[1]]$weight
#> [1] 400 500 600
#> 
#> 
#> $typography$fonts[[2]]
#> $typography$fonts[[2]]$family
#> [1] "M PLUS Code Latin"
#> 
#> $typography$fonts[[2]]$source
#> [1] "google"
#> 
#> $typography$fonts[[2]]$weight
#> [1] 400 500
#> 
#> 
#> $typography$fonts[[3]]
#> $typography$fonts[[3]]$family
#> [1] "Marck Script"
#> 
#> $typography$fonts[[3]]$source
#> [1] "google"
#> 
#> $typography$fonts[[3]]$weight
#> [1] 400
#> 
#> 
#> 
#> $typography$base
#> $typography$base$family
#> [1] "Roboto Condensed"
#> 
#> 
#> $typography$headings
#> $typography$headings$family
#> [1] "Marck Script"
#> 
#> 
#> $typography$monospace
#> $typography$monospace$family
#> [1] "M PLUS Code Latin"
#> 
#> 
#> 
#> $font
#> [1] "M PLUS Code Latin"
#> 
scales::show_col(unlist(brand()$color$palette))
#> No `_brand.yml` config found in the working tree. Loaded built-in `Mel B. Labs` theme instead.

```
