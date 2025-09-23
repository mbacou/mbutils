# This approach also used in thematic package
options(use.brand = TRUE, axes.side = c(3, 4))
.globals <- new.env(parent = emptyenv())


#' Built-in default Bootstrap brand
#'
#' Branding is read from a user-specified `_brand.yml` file or from this package if
#' no file is found in the working tree.
#'
#' @name BRAND
#' @docType data
#' @keywords dataset
#' @references [brand.yml](https://posit-dev.github.io/brand-yml/)
#' @format List of default branding elements (colors, fonts)
#' @examples
#' names(BRAND)
#'
"BRAND"


#' Fetch Bootstrap branding
#'
#' Make this package compatible with `brand.yml` unified branding features. Branding can be read from a configuration file provided at run-time, else it will use this package built-in theme.
#'
#' Refer to [brand.yml](https://posit-dev.github.io/brand-yml/) documentation.
#'
#' Typically there is no need to call `brand()` directly. Instead use [brand_on()] to apply plot branding to your active session.
#'
#' TODO search more file locations
#'
#' @param file path to `_brand.yml` configuration file, normally this file is auto-detected in the working tree, but may be specified here to swap branding dynamically.
#' @param font one of `_brand.yml` font families (currently only `base`, `monospace`, or `headings`).
#' @importFrom yaml read_yaml
#' @returns List of branding elements similar in structure to `_brand.yml`
#' @seealso [brand_on()]
#' @references [brand.yml](https://posit-dev.github.io/brand-yml/)
#' @examples
#' brand(font="monospace")
#' scales::show_col(unlist(brand()$color$palette))
#'
#' @export
brand <- function(file = "_brand.yml", font = c("base", "monospace", "headings")) {
  file = if (missing(file)) "_brand.yml" else file
  font = match.arg(font)

  b = if (file.exists(file)) {
    read_yaml(file)
  } else {
    message(
      "No `",
      file,
      "` config found in the working tree. Loaded built-in `",
      BRAND$meta$name,
      "` theme instead."
    )
    BRAND
  }

  if (!all(c("color", "typography") %in% names(b))) {
    stop("Boostrap branding needs color and font definitions.")
  }

  font = b$typography[[font]]
  # Get font if not found, assume Google font
  if (!font %in% font_families()) {
    font_add_google(font)
    showtext_auto()
  }

  b$font = font
  b
}


#' Apply Boostrap brand to graphic devices and plots
#'
#' This function is inspired by [thematic::thematic_on()]. It modifies base R graphics, lattice, and ggplot colors and fonts to match a user-specified Bootstrap theme (using `_brand.yml`) features. It also further modifies the appearance of plot axes and legends (see examples).
#'
#' Calling `brand_on()` has a few side effects in that it modifies global `par()` parameters, ggplot theme and color palette, and it will silently **mask functions `ggplot2::ggplot()` and `graphics::legend()'**.
#'
#' The base generic `plot()` function is not masked but axes are turned off by `par()` and need to be added to plots explicitely with `mbutils::axes()` (shorthand for plotting multiple axes at once) or `graphics::axis()`.
#'
#' Use in combination with [brand_off()] to restore the environment to its original state.
#'
#' @inheritParams brand
#' @importFrom ggplot2 theme_set
#' @references [brand.yml](https://posit-dev.github.io/brand-yml/)
#' @returns (invisible) list of branding elements similar in structure to `_brand.yml`
#'
#' @examples
#' brand_on(font="monospace")
#'
#' scales::show_col(pal.brand())
#'
#' set.seed(1)
#' x <- runif(100, min = -5, max = 5)
#' y <- x ^ 3 + rnorm(100, mean = 0, sd = 5)
#'
#' plot(x, y, col=4)
#' axis(main="Bootstrap Branded Plot", sub="Scatter plot")
#'
#' plot(x, y, type="h", col=(y>0)+4)
#' axes(nx=NULL, col.sub=pal.brand("red"),
#'   main="Bootstrap Branded Plot", sub="Subtitle",
#'   xlab="X Units", ylab="Y Units")
#' abline(h=0, col=pal.brand("red"), lwd=2)
#' legend(names(pal.brand())[4:5], lty=1, lwd=2, col=4:5)
#'
#' hist(x, col=pal.brand())
#' axes(c(1,4),
#'   main="My Bootstrap Branded Plot",
#'   sub="Histogram, dummy legend", ylab="Frequency", lty=1)
#' legend(paste("cat", 1:3), fill=pal.brand(1:3))
#'
#' # Plot ecdf
#' F10 <- ecdf(rnorm(10))
#' plot(F10)
#' axes(c(1,4),
#'   main="My Bootstrap Branded Plot",
#'   sub="Histogram, dummy legend", ylab="Frequency", nx=NULL)
#'
#' ggplot(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
#'   geom_col() +
#'   labs(
#'     title = "Branded plot with fonts and color palette",
#'     subtitle = "My very long subtitle with many units",
#'     caption = "My very long plot caption with many references.")
#'
#' brand_off()
#' par("fg")
#' par("bg")
#'
#' @export
brand_on <- function(file, font) {
  # Load _brand.yml config
  b = brand(file, font)

  # Set color palette
  opal = palette(unlist(b$color$palette))

  # Set graphic parameters
  opar = par(par.brand())

  # Turn off default plot axes and labels
  assign("plot.default", plot.brand, pos = "package:mbutils")
  assign("legend", legend.brand, pos = "package:mbutils")
  assign("ggplot", ggbrand, pos = "package:mbutils")

  # Set global ggplot theme
  otheme = ggplot2::theme_set(theme_brand())

  # Set globals so we can restore state
  assign("brand", b, envir = .globals)
  assign("par", opar, envir = .globals)
  assign("palette", opal, envir = .globals)
  assign("theme", otheme, envir = .globals)
  invisible(b)
}


#' Turn Bootstrap brand off
#'
#' Restore R session to its original state, discarding all color, font and plot customizations.
#'
#' @seealso [brand_on()]
#' @returns TRUE (invisibly)
#' @export
brand_off <- function() {
  if (!is.null(dev.list())) {
    dev.off()
  }

  # Clean up
  rm(plot.default, legend, ggplot, pos = "package:mbutils")

  if (is.null(.globals$palette)) {
    palette("default")
    ggplot2::theme_set(ggplot2::theme_gray())
  } else {
    par(.globals$par)
    palette(.globals$palette)
    ggplot2::theme_set(.globals$theme)
  }

  rm(brand, par, palette, envir = .globals)
  invisible(TRUE)
}


#' Bootstrap color palette
#'
#' Color palette extracted from the active Bootstrap theme. By default colors are read from an external `_brand.yaml` configuration file (or uses this package built-in brand).
#'
#' @param x Color index or name(s), skip to return the entire color palette
#' @param named keep color names (default: TRUE)
#'
#' @return A vector of (named) hex color codes extracted from Bootstrap branding
#' @references [brand.yml](https://posit-dev.github.io/brand-yml/)
#' @examples
#' scales::show_col(pal.brand())
#' scales::show_col(pal.brand(c("orange", "red")))
#'
#' @export
pal.brand <- function(x = NULL, named = TRUE) {
  b = .globals$brand
  b = if (is.null(b)) suppressMessages(brand()) else b
  e = if (missing(x)) b$color$palette else b$color$palette[x]
  e = if (named) e else unname(e)
  unlist(e)
}


#' Bootstrap color ramp
#'
#' Qualitative color ramp derived from active branding. This ramp excludes Bootstrap's
#' **white**, **black**, **light** and **gray** colors, which are typically used for
#' textual elements. By default the color ramp is 90% transparent.
#'
#' @param n number of colors to interpolate
#' @param alpha transparency [0,1]
#' @inheritParams grDevices::colorRampPalette
#' @inheritDotParams grDevices::colorRampPalette
#' @importFrom grDevices adjustcolor
#' @return vector of n interpolated colors
#' @examples
#' scales::show_col(brand.colors(alpha=1))
#' scales::show_col(brand.colors(11, alpha=1, interpolate="spline"))
#' scales::show_col(brand.colors(16))
#' scales::show_col(brand.colors(4, alpha=.5))
#'
#' @export
brand.colors <- function(n = NULL, colors = pal.brand(), alpha = .9, ...) {
  omit = c("white", "black", "gray")
  if (missing(n)) {
    return(colors[!names(colors) %in% omit])
  }
  colors = colors[!names(colors) %in% omit]
  adjustcolor(colorRampPalette(unname(colors), ...)(n), alpha.f = alpha)
}
