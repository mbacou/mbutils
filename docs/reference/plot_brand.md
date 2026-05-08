# Wrapper for base plot()

Simply assign default arguments to base R `plot` method. This function
is exported but not meant to be called directly in most cases. Use
[`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)
to apply complete plot customizations (fonts and colors) using
`_brand.yml` features.

## Usage

``` r
plot_brand(
  x,
  side = getOption("axes.side"),
  main = NA,
  sub = NA,
  main.line = 5.5,
  axes = FALSE,
  ann = axes,
  ...
)
```

## Arguments

- side:

  which ide(s) to plot axes (0 to supress all axes), default to
  `getOption("axes.side")` else `c(1, 2)` (left and bottom)

- main:

  a main title for the plot, see also
  [`title`](https://rdrr.io/r/graphics/title.html).

- sub:

  a subtitle for the plot.

- main.line:

  margin line to draw plot title and subtitle, used to adjust plot
  margins (default: 5.5)

- axes:

  a logical value indicating whether both axes should be drawn on the
  plot. Use [graphical parameter](https://rdrr.io/r/graphics/par.html)
  `"xaxt"` or `"yaxt"` to suppress just one of the axes.

- ann:

  a logical value indicating whether the default annotation (title and x
  and y axis labels) should appear on the plot.

- ...:

  Arguments passed on to
  [`graphics::plot.default`](https://rdrr.io/r/graphics/plot.default.html)

  `x,y`

  :   the `x` and `y` arguments provide the x and y coordinates for the
      plot. Any reasonable way of defining the coordinates is
      acceptable. See the function
      [`xy.coords`](https://rdrr.io/r/grDevices/xy.coords.html) for
      details. If supplied separately, they must be of the same length.

  `type`

  :   1-character string giving the type of plot desired. The following
      values are possible, for details, see
      [`plot`](https://rdrr.io/r/base/plot.html): `"p"` for points,
      `"l"` for lines, `"b"` for both points and lines, `"c"` for empty
      points joined by lines, `"o"` for overplotted points and lines,
      `"s"` and `"S"` for stair steps and `"h"` for histogram-like
      vertical lines. Finally, `"n"` does not produce any points or
      lines.

  `xlim`

  :   the x limits (x1, x2) of the plot. Note that `x1 > x2` is allowed
      and leads to a ‘reversed axis’.

      The default value, `NULL`, indicates that the range of the
      [finite](https://rdrr.io/r/base/is.finite.html) values to be
      plotted should be used.

  `ylim`

  :   the y limits of the plot; see `xlim` for default and details.

  `log`

  :   a character string which contains `"x"` if the x axis is to be
      logarithmic, `"y"` if the y axis is to be logarithmic and `"xy"`
      or `"yx"` if both axes are to be logarithmic.

  `lim2`

  :   logical, relevant only when at least one of `xlim` or `ylim` are
      `NULL` and hence corresponding axis limits are computed from
      [`range`](https://rdrr.io/r/base/range.html)`(<x/y-coord>[<finite-coord>])`.
      When true, *both* x- and y-values need to be finite to be used in
      the `range(.)` computation.

  `xlab`

  :   a label for the x axis, defaults to a description of `x`.

  `ylab`

  :   a label for the y axis, defaults to a description of `y`.

  `frame.plot`

  :   a logical indicating whether a box should be drawn around the
      plot.

  `panel.first`

  :   an ‘expression’ to be evaluated after the plot axes are set up but
      before any plotting takes place. This can be useful for drawing
      background grids or scatterplot smooths. Note that this works by
      lazy evaluation: passing this argument from other `plot` methods
      may well not work since it may be evaluated too early.

  `panel.last`

  :   an expression to be evaluated after plotting has taken place but
      before the axes, title and box are added. See the comments about
      `panel.first`.

  `asp`

  :   the \\y/x\\ aspect ratio, see
      [`plot.window`](https://rdrr.io/r/graphics/plot.window.html).

  `xgap.axis,ygap.axis`

  :   the \\x/y\\ axis gap factors, passed as `gap.axis` to the two
      [`axis()`](https://rdrr.io/r/graphics/axis.html) calls (when
      `axes` is true, as per default).

## Details

Use `side = c(1,2)` etc. to control axis visibility. For more granular
control over axis display use `side=0` and this package
[`axes()`](https://mbacou.github.io/mbutils/reference/axes.md) or base R
[`axis()`](https://rdrr.io/r/graphics/axis.html).

## See also

[`axes()`](https://mbacou.github.io/mbutils/reference/axes.md)

## Examples

``` r
set.seed(1)
x <- runif(100, min = -5, max = 5)
y <- x ^ 3 + rnorm(100, mean = 0, sd = 5)

# Standard plot
plot_brand(x, y, col=4, side=1:2, main.line=2.5,
  main="Custom Plot", sub="no legend", axes=TRUE, ann=TRUE)


# Standard plot
plot_brand(x, y, col=4, side=0, main.line=2.5,
  main="Custom Plot", sub="no axis")
#> Error in if (axes) {    localAxis(if (is.null(y))         xy$x    else x, side = 1, gap.axis = xgap.axis, ...)    localAxis(if (is.null(y))         x    else y, side = 2, gap.axis = ygap.axis, ...)}: the condition has length > 1

# Branded defaults
plot_brand(x, y, type="h", col=(y>0)+4, side=c(1,4), nx=NULL,
  main="Custom Plot", sub="Histogram with top legend")
#> Warning: longer object length is not a multiple of shorter object length
#> Error in par(mar = par.brand()$mar + 3 * (1:4 %in% side) + c(0, 0, main.line,     0), mgp = par.brand()$mgp, bty = par.brand()$bty, no.readonly = TRUE): graphical parameter "mar" has the wrong length
abline(h=0, col=pal("red"), lwd=2)

legend_brand(names(pal())[4:5], lty=1, lwd=2, col=4:5)
#> Error in legend_brand(names(pal())[4:5], lty = 1, lwd = 2, col = 4:5): could not find function "legend_brand"
```
