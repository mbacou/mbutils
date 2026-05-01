# Bootstrap-branded ggplot with custom axis and legend

Shorthand to generate branded ggplots. Uses
[`theme_brand()`](https://mbacou.github.io/mbutils/reference/theme_brand.md)
to control colors and fonts, and has Y-axis on the right. Axis placement
can be quickly modified with argument `axes`.

## Usage

``` r
ggbrand(
  data = NULL,
  mapping = aes(),
  axes = c("bottomright", "topright", "bottomleft", "topleft"),
  ...
)
```

## Arguments

- data:

  Default dataset to use for plot. If not already a data.frame, will be
  converted to one by
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html).
  If not specified, must be supplied in each layer added to the plot.

- mapping:

  Default list of aesthetic mappings to use for plot. If not specified,
  must be supplied in each layer added to the plot.

- axes:

  position of X (`bottom` or `top`) and Y (`left` or `right`) primary
  axes (default: `bottomright`)

- ...:

  Arguments passed on to
  [`theme_brand`](https://mbacou.github.io/mbutils/reference/theme_brand.md)

  `base_color`

  :   Bootstrap color name for text and line elements, or color code

  `base_bg`

  :   Bootstrap color name for plot, panel background, or color code

  `base_family`

  :   one of `_brand.yml` font families (currently only `base`,
      `monospace`, or `headings`), else a valid system or Google font
      family name

  `grid`

  :   show gridlines `XY`, `X`, `Y` (default) or `n` for no gridline

  `legend`

  :   shorthand for `theme(legend.position="...")` (default: `top`)

  `base_size`

  :   base font size, given in pts.

## Value

A `ggplot2` object with themef elements

## Examples
