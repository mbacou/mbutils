# Bootstrap color palette

Color palette extracted from the active Bootstrap theme. By default
colors are read from an external `_brand.yml` configuration file (or
uses this package built-in brand).

## Usage

``` r
pal.brand(x = NULL, named = TRUE)
```

## Arguments

- x:

  Color index or name(s), skip to return the entire color palette

- named:

  keep color names (default: TRUE)

## Value

A vector of (named) hex color codes extracted from Bootstrap branding

## References

[brand.yml](https://posit-dev.github.io/brand-yml/)

## Examples

``` r
scales::show_col(pal.brand())

scales::show_col(pal.brand(c("orange", "red")))

```
