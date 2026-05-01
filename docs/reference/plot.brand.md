# Wrapper for base plot()

Simply assign new default arguments to base R `plot` method. This
function is exported but not meant to be called directly in most cases.
Use
[`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)
instead to apply plot customizations.

## Usage

``` r
# S3 method for class 'brand'
plot(
  ...,
  frame.plot = FALSE,
  side = getOption("axes.side"),
  use.brand = getOption("use.brand")
)
```

## Arguments

- ...:

  Arguments passed on to
  [`axes`](https://mbacou.github.io/mbutils/reference/axes.md),
  [`graphics::plot`](https://rdrr.io/r/graphics/plot.default.html)

  `at`

  :   length-2 list of x/y points at which tickmarks are to be drawn,
      default `list(x=NA, y=NA)`

  `axes.lty`

  :   length-2 type of axis line (depends on `nx` value, c(0,1) if
      vertical gridlines are drawn) but can be modified here

  `gap.axis`

  :   length-2 minimal gap between axis labels

  `grid.col`

  :   gridline color

  `grid.lty`

  :   gridline type

  `grid.lwd`

  :   gridline width

  `main`

  :   The main title (on top) using font, size (character expansion) and
      color `par(c("font.main", "cex.main", "col.main"))`.

  `sub`

  :   Sub-title (at bottom) using font, size and color
      `par(c("font.sub", "cex.sub", "col.sub"))`.

  `xlab`

  :   X axis label using font, size and color
      `par(c("font.lab", "cex.lab", "col.lab"))`.

  `ylab`

  :   Y axis label, same font attributes as `xlab`.

  `line`

  :   specifying a value for `line` overrides the default placement of
      labels, and places them this many lines outwards from the plot
      edge.

  `nx,ny`

  :   number of cells of the grid in x and y direction. When `NULL`, as
      per default, the grid aligns with the tick marks on the
      corresponding *default* axis (i.e., tickmarks as computed by
      [`axTicks`](https://rdrr.io/r/graphics/axTicks.html)). When
      [`NA`](https://rdrr.io/r/base/NA.html), no grid lines are drawn in
      the corresponding direction.

  `x,y`

  :   the `x` and `y` arguments provide the x and y coordinates for the
      plot. Any reasonable way of defining the coordinates is
      acceptable. See the function
      [`xy.coords`](https://rdrr.io/r/grDevices/xy.coords.html) for
      details. If supplied separately, they must be of the same length.

- side:

  position of axes, up to 4 (1-bottom, 2-left, 3-top, 4-right)

- use.brand:

  whether to use mofidied plot layout, default `TRUE`

## Details

Note that when package option `getOption(use.brand=FALSE)` then
`plot.brand()` is entirely equivalent to
[`base::plot()`](https://rdrr.io/r/base/plot.html).

## See also

[`axes()`](https://mbacou.github.io/mbutils/reference/axes.md)

## Examples

``` r
set.seed(1)
x <- runif(100, min = -5, max = 5)
y <- x ^ 3 + rnorm(100, mean = 0, sd = 5)

# Standard plot
options(use.brand = FALSE)
plot.brand(x, y, col=4,
  main="Bootstrap Branded Plot", sub="Scatter plot")
#> Error in plot.brand(x, y, col = 4, main = "Bootstrap Branded Plot", sub = "Scatter plot"): could not find function "plot.brand"

# Branded defaults
options(use.brand = TRUE)
plot.brand(x, y, col=4,
  main="Bootstrap Branded Plot", sub="Scatter plot with moded axes")
#> Error in plot.brand(x, y, col = 4, main = "Bootstrap Branded Plot", sub = "Scatter plot with moded axes"): could not find function "plot.brand"

plot.brand(x, y, type="h", col=(y>0)+4, side=c(1,4), nx=NULL,
  main="Bootstrap Branded Plot", sub="Histogram with dummy legend")
#> Error in plot.brand(x, y, type = "h", col = (y > 0) + 4, side = c(1, 4),     nx = NULL, main = "Bootstrap Branded Plot", sub = "Histogram with dummy legend"): could not find function "plot.brand"
abline(h=0, col=pal.brand("red"), lwd=2)
#> Error in int_abline(a = a, b = b, h = h, v = v, untf = untf, ...): plot.new has not been called yet
legend.brand(names(pal.brand())[4:5], lty=1, lwd=2, col=4:5)
#> Error in legend.brand(names(pal.brand())[4:5], lty = 1, lwd = 2, col = 4:5): could not find function "legend.brand"
```
