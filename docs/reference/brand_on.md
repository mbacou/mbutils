# Apply Boostrap brand to graphic devices and plots

This function is inspired by
[`thematic::thematic_on()`](https://rstudio.github.io/thematic/reference/thematic_on.html).
It modifies base R graphics, lattice, and ggplot colors and fonts to
match a user-specified Bootstrap theme (using `_brand.yml`) features. It
also further modifies the appearance of plot axes and legends (see
examples).

## Usage

``` r
brand_on(file, font)
```

## Arguments

- file:

  path to `_brand.yml` configuration file, normally this file is
  auto-detected in the working tree, but may be specified here to swap
  branding dynamically.

- font:

  one of `_brand.yml` font families (currently only `base`, `monospace`,
  or `headings`).

## Value

(invisible) list of branding elements similar in structure to
`_brand.yml`

## Details

Calling `brand_on()` has a few side effects in that it modifies global
[`par()`](https://rdrr.io/r/graphics/par.html) parameters, ggplot theme
and color palette, and it will silently **mask functions
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)
and \`graphics::legend()'**.

The base generic
[`plot()`](https://rdrr.io/r/graphics/plot.default.html) function is not
masked but axes are turned off by
[`par()`](https://rdrr.io/r/graphics/par.html) and need to be added to
plots explicitely with
[`mbutils::axes()`](https://mbacou.github.io/mbutils/reference/axes.md)
(shorthand for plotting multiple axes at once) or
[`graphics::axis()`](https://rdrr.io/r/graphics/axis.html).

Use in combination with
[`brand_off()`](https://mbacou.github.io/mbutils/reference/brand_off.md)
to restore the environment to its original state.

## References

[brand.yml](https://posit-dev.github.io/brand-yml/)

## Examples

``` r
brand_on(font="monospace")
#> No `_brand.yml` config found in the working tree. Loaded built-in `Mel B. Labs` theme instead.
#> Error in assign("plot.default", plot.brand, pos = "package:mbutils"): cannot add bindings to a locked environment

scales::show_col(pal.brand())


set.seed(1)
x <- runif(100, min = -5, max = 5)
y <- x ^ 3 + rnorm(100, mean = 0, sd = 5)

plot(x, y, col=4)

axis(main="Bootstrap Branded Plot", sub="Scatter plot")
#> Error in axis(main = "Bootstrap Branded Plot", sub = "Scatter plot"): argument "side" is missing, with no default

plot(x, y, type="h", col=(y>0)+4)
axes(nx=NULL, col.sub=pal.brand("red"),
  main="Bootstrap Branded Plot", sub="Subtitle",
  xlab="X Units", ylab="Y Units")
#> Error in axes(nx = NULL, col.sub = pal.brand("red"), main = "Bootstrap Branded Plot",     sub = "Subtitle", xlab = "X Units", ylab = "Y Units"): unused argument (col.sub = pal.brand("red"))
abline(h=0, col=pal.brand("red"), lwd=2)

legend(names(pal.brand())[4:5], lty=1, lwd=2, col=4:5)
#> Error in legend(names(pal.brand())[4:5], lty = 1, lwd = 2, col = 4:5): argument "legend" is missing, with no default

hist(x, col=pal.brand())

axes(c(1,4),
  main="My Bootstrap Branded Plot",
  sub="Histogram, dummy legend", ylab="Frequency", lty=1)
#> Error in axes(c(1, 4), main = "My Bootstrap Branded Plot", sub = "Histogram, dummy legend",     ylab = "Frequency", lty = 1): unused argument (lty = 1)
legend(paste("cat", 1:3), fill=pal.brand(1:3))
#> Error in legend(paste("cat", 1:3), fill = pal.brand(1:3)): argument "legend" is missing, with no default

# Plot ecdf
F10 <- ecdf(rnorm(10))
plot(F10)
axes(c(1,4),
  main="My Bootstrap Branded Plot",
  sub="Histogram, dummy legend", ylab="Frequency", nx=NULL)


ggplot(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
  geom_col() +
  labs(
    title = "Branded plot with fonts and color palette",
    subtitle = "My very long subtitle with many units",
    caption = "My very long plot caption with many references.")
#> Error in ggplot(mtcars, aes(factor(carb), mpg, fill = factor(carb))): could not find function "ggplot"

brand_off()
#> Error in rm(plot.default, legend, ggplot, pos = "package:mbutils"): cannot remove bindings from a locked environment
par("fg")
#> [1] "black"
par("bg")
#> [1] "transparent"
```
