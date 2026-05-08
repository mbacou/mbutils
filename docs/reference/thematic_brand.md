# Thematic-ally apply Bootstrap brand to base, lattice and ggplot2 graphics

Applies Bootstrap branding to R graphics using `thematic` R package
utilities. This function behaves like
[`thematic::thematic_on()`](https://rstudio.github.io/thematic/reference/thematic_on.html)
but instead of passing individual colors and fonts, the user can provide
an external `_brand.yml` configuration file. `brand_on` takes color and
font variable names per Boostrap branding (hence, do not provide hex
color codes, edit `_brand.yml` instead).

## Usage

``` r
thematic_brand(
  file = NULL,
  font = NULL,
  bg = "background",
  fg = "foreground",
  accent = c("primary", "secondary"),
  sequential = NULL,
  qualitative = NULL,
  gradient = c("orange", "light", "green"),
  n = 20,
  alpha = 0.9,
  ...
)
```

## Arguments

- file:

  path to `_brand.yml` configuration file, normally this file is
  auto-detected in the working tree, but may be specified here to swap
  branding dynamically.

- font:

  one of `_brand.yml` font families (currently only `base`, `monospace`,
  or `headings`).

- bg:

  a background color.

- fg:

  a foreground color.

- accent:

  a color for making certain graphical markers 'stand out' (e.g., the
  fitted line color for
  [`ggplot2::geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html)).
  Can be 2 colors for lattice (stroke vs fill accent).

- sequential:

  a color palette for graphical markers that encode numeric values. Can
  be a vector of color codes or a
  [`sequential_gradient()`](https://rstudio.github.io/thematic/reference/sequential_gradient.html)
  object.

- qualitative:

  a color palette for graphical markers that encode qualitative values
  (won't be used in ggplot2 when the number of data levels exceeds the
  max allowed colors). Defaults to
  [`okabe_ito()`](https://rstudio.github.io/thematic/reference/okabe_ito.html).

- gradient:

  Vector of Bootstrap color (names) to use in plot gradients

- n:

  Number of colors to interpolate in plot gradients (default: 20)

- alpha:

  Transparency for color scales between 0 and 1 (default: .9)

## Value

a thematic theme object (list)

## Details

Typically charts will use Boostrap **sans-serif** font, but as of
compiling that variable is not available in `brand.yml` schema, so
`brand_theme` will take the **first** font declared in the
**typography** tree.

## Examples

``` r
require(ggplot2)
thematic::thematic_with_theme(thematic_brand(), {

# base
hist(rchisq(100, df=4), freq=FALSE, ylim=c(0, 0.2),
col=1:11, border="white", xlab=NA)
grid(NA, NULL, col="white")
curve(dchisq(x, df=4), col=3, lty=2, lwd=2, add=TRUE)

# lattice
lattice::show.settings()

# ggplot2
ggplot(mtcars, aes(factor(carb), mpg, fill=carb)) +
  geom_col() +
  labs(
    x = "carb", y = NULL,
    title = "Default Plot with Bootstrap Branding",
    subtitle = "My very long subtitle with many units",
    caption = "My very long plot caption with many references.")

ggplot(mtcars, aes(factor(carb), mpg, fill=carb)) +
  geom_col()

ggplot(mtcars, aes(factor(carb), mpg, fill=carb)) +
  geom_col() +
  guides(y=guide_axis(position="right")) +
  theme_brand(base_bg="light")

})

#> Error : thematic doesn't (yet) support the 'agg_record_6d9b2a42d707' graphics device. Please report this error to https://github.com/rstudio/thematic/issues/new

#> Error : thematic doesn't (yet) support the 'agg_record_6d9b2a42d707' graphics device. Please report this error to https://github.com/rstudio/thematic/issues/new
```
