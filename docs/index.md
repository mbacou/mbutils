# mbutils

R package with Mel’s utilities for data science projects and (Quarto)
web publishing.

In particular this package includes Boostrap themes and color scales for
**base R graphics**, **lattice** and **ggplot**, implementing the
(recent) [brand.yml](https://posit-dev.github.io/brand-yml/) flexible
branding system.

This new Quarto feature allows for logos, primary colors, color
palettes, fonts, etc. to be specified and swapped across projects and
clients using external YAML config files and well-known Bootstrap Sass
variables. This package includes my custom themes and additional
utilities to turn theme features on/off.

## Installation

You can install this package from the development version on GitHub:

``` r

if (!require("remotes")) install.packages("remotes")
remotes::install_github("mbacou/mbutils")
```

## Documentation

For complete R package documentation and technical guides, see the
[package vignette](https://mbacou.github.io/mbutils/).

## License

This package is licensed under the terms of the [GNU General Public
License](https://www.gnu.org/licenses/gpl-3.0.html) version 3 or later.

Copyright 2021-2026 Melanie Bacou.
