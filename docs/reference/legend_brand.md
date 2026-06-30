# Wrapper for graphics::legend()

Simply assign default arguments to base R
[`legend()`](https://rdrr.io/r/graphics/legend.html). This function is
exported but is not meant to be called directly, use
[`brand_on()`](https://mbacou.github.io/mbutils/reference/brand_on.md)
instead.

## Usage

``` r
legend_brand(
  x = "topright",
  y = NULL,
  legend,
  bty = "n",
  horiz = TRUE,
  xpd = TRUE,
  inset = c(-0.05, -0.4),
  par = par.brand(),
  ...
)
```

## Arguments

- x, y:

  the x and y co-ordinates to be used to position the legend. They can
  be specified by keyword or in any way which is accepted by
  [`xy.coords`](https://rdrr.io/r/grDevices/xy.coords.html): See
  ‘Details’.

- legend:

  a character or [expression](https://rdrr.io/r/base/expression.html)
  vector of length \\\ge 1\\ to appear in the legend. Other objects will
  be coerced by
  [`as.graphicsAnnot`](https://rdrr.io/r/grDevices/as.graphicsAnnot.html).

- bty:

  the type of box to be drawn around the legend. The allowed values are
  `"o"` (the default) and `"n"`.

- horiz:

  logical; if `TRUE`, set the legend horizontally rather than vertically
  (specifying `horiz` overrides the `ncol` specification).

- xpd:

  if supplied, a value of the [graphical
  parameter](https://rdrr.io/r/graphics/par.html) `xpd` to be used while
  the legend is being drawn.

- inset:

  inset distance(s) from the margins as a fraction of the plot region
  when legend is placed by keyword.

- ...:

  Arguments passed on to
  [`graphics::legend`](https://rdrr.io/r/graphics/legend.html)

  `x,y`

  :   the x and y co-ordinates to be used to position the legend. They
      can be specified by keyword or in any way which is accepted by
      [`xy.coords`](https://rdrr.io/r/grDevices/xy.coords.html): See
      ‘Details’.

  `fill`

  :   if specified, this argument will cause boxes filled with the
      specified colors (or shaded in the specified colors) to appear
      beside the legend text.

  `col`

  :   the color of points or lines appearing in the legend.

  `border`

  :   the border color for the boxes (used only if `fill` is specified).

  `lty,lwd`

  :   the line types and widths for lines appearing in the legend. One
      of these two *must* be specified for line drawing.

  `pch`

  :   the plotting symbols appearing in the legend, as numeric vector or
      a vector of 1-character strings (see
      [`points`](https://rdrr.io/r/graphics/points.html)). Unlike
      `points`, this can all be specified as a single multi-character
      string. *Must* be specified for symbol drawing.

  `angle`

  :   angle of shading lines.

  `density`

  :   the density of shading lines, if numeric and positive. If `NULL`
      or negative or `NA` color filling is assumed.

  `bg`

  :   the background color for the legend box. (Note that this is only
      used if `bty != "n"`.)

  `box.lty,box.lwd,box.col`

  :   the line type, width and color for the legend box (if
      `bty = "o"`).

  `pt.bg`

  :   the background color for the
      [`points`](https://rdrr.io/r/graphics/points.html), corresponding
      to its argument `bg`.

  `cex`

  :   character expansion factor **relative** to current `par("cex")`.
      Used for text, and provides the default for `pt.cex`.

  `pt.cex`

  :   expansion factor(s) for the points.

  `pt.lwd`

  :   line width for the points, defaults to the one for lines, or if
      that is not set, to `par("lwd")`.

  `xjust`

  :   how the legend is to be justified relative to the legend x
      location. A value of 0 means left justified, 0.5 means centered
      and 1 means right justified.

  `yjust`

  :   the same as `xjust` for the legend y location.

  `x.intersp`

  :   character interspacing factor for horizontal (x) spacing between
      symbol and legend text.

  `y.intersp`

  :   vertical (y) distances (in lines of text shared above/below each
      legend entry). A vector with one element for each row of the
      legend can be used.

  `adj`

  :   numeric of length 1 or 2; the string adjustment for legend text.
      Useful for y-adjustment when `labels` are
      [plotmath](https://rdrr.io/r/grDevices/plotmath.html) expressions.

  `text.width`

  :   the width of the legend text in x (`"user"`) coordinates. (Should
      be positive even for a reversed x axis.) Can be a single positive
      numeric value (same width for each column of the legend), a vector
      (one element for each column of the legend), `NULL` (default) for
      computing a proper maximum value of
      [`strwidth`](https://rdrr.io/r/graphics/strwidth.html)`(legend)`),
      or `NA` for computing a proper column wise maximum value of
      [`strwidth`](https://rdrr.io/r/graphics/strwidth.html)`(legend)`).

  `text.col`

  :   the color used for the legend text.

  `text.font`

  :   the font used for the legend text, see
      [`text`](https://rdrr.io/r/graphics/text.html).

  `merge`

  :   logical; if `TRUE`, merge points and lines but not filled boxes.
      Defaults to `TRUE` if there are points and lines.

  `trace`

  :   logical; if `TRUE`, shows how `legend` does all its magical
      computations.

  `plot`

  :   logical. If `FALSE`, nothing is plotted but the sizes are
      returned.

  `ncol`

  :   the number of columns in which to set the legend items (default is
      1, a vertical legend).

  `title`

  :   a character string or length-one expression giving a title to be
      placed at the top of the legend. Other objects will be coerced by
      [`as.graphicsAnnot`](https://rdrr.io/r/grDevices/as.graphicsAnnot.html).

  `title.col`

  :   color for `title`, defaults to `text.col[1]`.

  `title.adj`

  :   horizontal adjustment for `title`: see the help for
      [`par`](https://rdrr.io/r/graphics/par.html)`("adj")`.

  `title.cex`

  :   expansion factor(s) for the title, defaults to `cex[1]`.

  `title.font`

  :   the font used for the legend title, defaults to `text.font[1]`,
      see [`text`](https://rdrr.io/r/graphics/text.html).

  `seg.len`

  :   the length of lines drawn to illustrate `lty` and/or `lwd` (in
      units of character widths).

## Value

Branded legend for base R plots

## See also

[`axes()`](https://mbacou.github.io/mbutils/reference/axes.md)

## Examples

``` r
set.seed(1)
x = runif(100, min = -5, max = 5)
y = x ^ 3 + rnorm(100, mean = 0, sd = 5)

opar = par(par.brand())

plot(x, y, type="h", col=(y>0)+4)
axes(nx=NULL,
  main="Bootstrap Branded Plot", sub="My Subtitle",
  xlab="X Units", ylab="Y Units")
abline(h=0, col=pal("red"), lwd=2)
legend_brand(legend=names(pal())[4:5], lty=1, lwd=2, col=4:5)


plot(x, type="h", col=pal())
axes(side=c(1,4),
  main="My Bootstrap Branded Plot",
  sub="Histogram, dummy legend", ylab="Frequency")
legend_brand(legend=paste("cat", 1:3), fill=pal(1:3))


par(opar)
```
