# Apply Boostrap brand to graphic devices and plots

This function is inspired by
[`thematic::thematic_on()`](https://rstudio.github.io/thematic/reference/thematic_on.html).
It modifies base R graphics, lattice, and ggplot colors and fonts to
match a user-specified Bootstrap theme (using `_brand.yml`) features. It
also modifies the appearance of plot axes and legends (see examples).

## Usage

``` r
brand_on(...)
```

## Arguments

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

(invisible) list of branding elements similar in structure to
`_brand.yml`

## Details

Calling `brand_on()` has a few side effects in that it modifies global
[`par()`](https://rdrr.io/r/graphics/par.html) parameters, ggplot theme
and color palette, and it will silently mask generic functions
[`graphics::plot`](https://rdrr.io/r/graphics/plot.default.html),
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)
and \`graphics::legend()'.

Use in combination with
[`brand_off()`](https://mbacou.github.io/mbutils/reference/brand_off.md)
to restore the environment to its original state.

## References

[brand.yml](https://posit-dev.github.io/brand-yml/)

## Examples

``` r
require(ggplot2)
brand_on(font="monospace")
#> No `_brand.yml` config found in the working tree. Loaded built-in `Mel B. Labs` theme instead.
scales::show_col(pal.brand())


set.seed(1)
x <- runif(100, min = -5, max = 5)
y <- x ^ 3 + rnorm(100, mean = 0, sd = 5)

plot(x, y, col=4,
 main="Bootstrap Branded Plot", sub="Scatter plot")


plot(x, y, type="h", col=(y>0)+4, nx=NULL,
  main="Bootstrap Branded Plot", sub="My Subtitle",
  xlab="X Units", ylab="Y Units")
abline(h=0, col=pal.brand("red"), lwd=2)
legend(names(pal.brand())[4:5], lty=1, lwd=2, col=4:5)


plot(x, type="h", col=pal.brand(), side=c(1,4),
  main="My Bootstrap Branded Plot",
  sub="Histogram, dummy legend", ylab="Frequency")
legend(paste("cat", 1:3), fill=pal.brand(1:3))


# Plot ecdf
plot(ecdf(rnorm(10)),
  main="My Bootstrap Branded Plot",
  sub="Histogram, dummy legend",
  side=c(1,4), ylab="Frequency", nx=NULL)


ggplot(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
  geom_col() +
  labs(
    title = "Branded plot with custom fonts and color palette",
    subtitle = "My very long subtitle with many units",
    caption = "My very long plot caption with many references.")


brand_off()
par("fg")
#> [1] "black"
par("bg")
#> [1] "white"

# BAck to default ggplot
ggplot(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
  geom_col() +
  labs(
    title = "Branded plot with custom fonts and color palette",
    subtitle = "My very long subtitle with many units",
    caption = "My very long plot caption with many references.")

```
