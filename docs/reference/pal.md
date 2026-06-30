# Bootstrap color palette

Color palette extracted from the active Bootstrap theme. By default
colors are extracted from an external `_brand.yml` configuration file
(or uses this package built-in branding).

## Usage

``` r
pal(
  x = NULL,
  alpha = 0.85,
  named = TRUE,
  omit = c("white", "black", "gray", "grid"),
  ...
)
```

## Arguments

- x:

  Color index or name(s), skip to return the entire color palette

- alpha:

  transparency (default: 0.85)

- named:

  keep color names (default: TRUE)

- omit:

  Brand colors to exclude from color ramp

- ...:

  Arguments passed on to
  [`brand`](https://mbacou.github.io/mbutils/reference/brand.md)

  `file`

  :   path to `_brand.yml` configuration file, normally this file is
      auto-detected in the working tree, but may be specified here to
      swap branding dynamically.

  `font`

  :   one of `_brand.yml` font families (currently only `base`,
      `monospace`, or `headings`).

## Value

A vector of (named) hex color codes extracted from Bootstrap branding

## References

[brand.yml](https://posit-dev.github.io/brand-yml/)

## Examples

``` r
scales::show_col(pal())

scales::show_col(pal(c("orange", "red")))

```
