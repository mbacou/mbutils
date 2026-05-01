# Built-in default Bootstrap brand

Branding is read from a user-specified `_brand.yml` file or from this
package if no file is found in the working tree.

## Usage

``` r
BRAND
```

## Format

List of default branding elements (colors, fonts)

## References

[brand.yml](https://posit-dev.github.io/brand-yml/)

## Examples

``` r
names(BRAND)
#> [1] "meta"       "color"      "typography"
```
