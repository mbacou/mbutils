# Changelog

## mbutils (development version)

#### v2.3.0

- More flexible
  [`plot_brand()`](https://mbacou.github.io/mbutils/reference/plot_brand.md)
  implementation

#### v1.0.0

- Dropped `thematic` dependency entirely
- Renamed package from `mblabs` to `mbuils`
- Added [`axes()`](https://mbacou.github.io/mbutils/reference/axes.md)
  shorthand plotting utility for base R
- Implemented
  [`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)
  and
  [`brand_off()`](https://mbacou.github.io/mbutils/reference/brand_off.md)
  to use in reports and notebooks
- Experimental
  [`thematic_brand()`](https://mbacou.github.io/mbutils/reference/thematic_brand.md)
  theme to use in combination with `thematic` package (but optional)

#### v0.1.0

- Renamed
  [`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)
  to [`brand()`](https://mbacou.github.io/mbutils/reference/brand.md)
  (returns a thematic theme)
- Fixed color definition bugs in
  [`brand()`](https://mbacou.github.io/mbutils/reference/brand.md)

#### v0.0.2

- Added `ggplot2` scales and custom axes and legend to use Bootstrap
  branding
- Added
  [`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)
  (similar to `[thematic::thematic_on()` but reads from `_brand.yml`
  config files instead.

#### v0.0.1

- Initial commit
