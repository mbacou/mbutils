# Bootstrap color ramp

Qualitative color ramp derived from active branding. This ramp excludes
Bootstrap's **white**, **black**, **light** and **gray** colors, which
are typically used for textual elements. By default the color ramp is
90% transparent.

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

## Value

vector of n interpolated colors

## Examples

``` r
scales::show_col(brand.colors()(6))

scales::show_col(brand.colors(interpolate="spline")(12))

scales::show_col(brand.colors(c("orange", "light"))(12))

s
#> Error: object 's' not found
```
