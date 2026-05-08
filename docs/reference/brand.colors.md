# Bootstrap color ramp

Qualitative color ramp derived from active branding. This ramp excludes
Bootstrap's **white**, **black**, **light** and **gray** colors, which
are typically used for textual elements.

## Usage

``` r
brand.colors(x = NULL, omit = c("white", "black", "gray"), ...)
```

## Arguments

- x:

  Brand color name(s), skip to return the entire color palette

- omit:

  Brand colors to exclude from color ramp

- ...:

  Arguments passed on to
  [`grDevices::colorRampPalette`](https://rdrr.io/r/grDevices/colorRamp.html)

  `colors`

  :   colors to interpolate; must be a valid argument to
      [`col2rgb()`](https://rdrr.io/r/grDevices/col2rgb.html).

  `bias`

  :   a positive number. Higher values give more widely spaced colors at
      the high end.

  `space`

  :   a character string; interpolation in RGB or Lab color spaces.

  `interpolate`

  :   use spline or linear interpolation.

  `alpha`

  :   logical: should alpha channel (opacity) values be returned? It is
      an error to give a true value if `space` is specified.

## Value

color palette function

## Examples

``` r
scales::show_col(brand.colors()(6))

scales::show_col(brand.colors(interpolate="spline")(12))

scales::show_col(brand.colors(c("orange", "light"))(12))

s
#> Error: object 's' not found
```
