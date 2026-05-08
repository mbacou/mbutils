# Internal helper: name of temporary attached environment
# This approach also used in thematic package
options(axes.side = c(3, 4))
.globals = "mbutils:masks"


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
#' Refer to [brand.yml](https://posit-dev.github.io/brand-yml/) for documentation.
#'
#' Typically there is no need to call `brand()` directly. Instead use [brand_on()] to apply plot branding across your active session.
#'
#' TODO search more file locations
#'
#' @param file path to `_brand.yml` configuration file, normally this file is auto-detected in the working tree, but may be specified here to swap branding dynamically.
#' @param font one of `_brand.yml` font families (currently only `base`, `monospace`, or `headings`).
#' @importFrom yaml read_yaml
#' @importFrom sysfonts font_add_google font_families
#' @returns List of branding elements similar in structure to `_brand.yml`
#' @seealso [brand_on()]
#' @references [brand.yml](https://posit-dev.github.io/brand-yml/)
#' @examples
#' brand(font="monospace")
#' scales::show_col(unlist(brand()$color$palette))
#'
#' @export
brand <- function(
  file = "_brand.yml",
  font = c("base", "monospace", "headings")
) {
  file = if (missing(file)) "_brand.yml" else file
  font = match.arg(font)

  b = if (file.exists(file)) {
    read_yaml(file)
  } else {
    message(
      "No `",
      file,
      "` found in the working tree.
      Loaded built-in `",
      BRAND$meta$name,
      "` theme instead."
    )
    BRAND
  }

  if (!all(c("color", "typography") %in% names(b))) {
    stop("Boostrap branding needs color and font definitions.")
  }

  font = b$typography[[font]]$family
  # Get font if not found, assume Google font
  if (!font %in% font_families()) {
    font_add_google(font)
    #showtext_auto()
  }

  b$font = font
  return(b)
}


#' Apply Boostrap brand to graphic devices and plots
#'
#' This function is inspired by [thematic::thematic_on()]. It modifies base R graphics, lattice, and ggplot colors and fonts to match a user-specified Bootstrap theme (using `_brand.yml`) features. It also modifies the appearance of plot axes and legends (see examples).
#'
#' Calling `brand_on()` has a few side effects in that it modifies global `par()` parameters, ggplot theme and color palette, and it will silently mask generic functions `graphics::plot`, `ggplot2::ggplot()` and `graphics::legend()'.
#'
#' Use in combination with [brand_off()] to restore the environment to its original state.
#'
#' @inheritDotParams brand
#' @importFrom ggplot2 theme_set
#' @references [brand.yml](https://posit-dev.github.io/brand-yml/)
#' @returns (invisible) list of branding elements similar in structure to `_brand.yml`
#'
#' @examples
#' require(ggplot2)
#' brand_on(font="monospace")
#' scales::show_col(pal())
#'
#' set.seed(1)
#' x <- runif(100, min = -5, max = 5)
#' y <- x ^ 3 + rnorm(100, mean = 0, sd = 5)
#'
#' plot(x, y, col=4)
#' axes(main="Bootstrap Branded Plot", sub="Scatter plot")
#'
#' plot(x, y, type="h", col=(y>0)+4)
#' axes(nx=NULL,
#'   main="Bootstrap Branded Plot", sub="My Subtitle",
#'   xlab="X Units", ylab="Y Units")
#' abline(h=0, col=pal("red"), lwd=2)
#' legend(names(pal())[4:5], lty=1, lwd=2, col=4:5)
#'
#' plot(x, type="h", col=pal())
#' axes(side=c(1,4),
#'   main="My Bootstrap Branded Plot",
#'   sub="Histogram, dummy legend", ylab="Frequency")
#' legend(paste("cat", 1:3), fill=pal(1:3))
#'
#' # Plot ecdf
#' plot(ecdf(rnorm(10)))
#' axes(
#'   main="My Bootstrap Branded Plot",
#'   sub="Histogram, dummy legend",
#'   side=c(1,4), ylab="Frequency", nx=NULL)
#'
#' ggplot(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
#'   geom_col() +
#'   labs(
#'     title = "Branded plot with custom fonts and color palette",
#'     subtitle = "My very long subtitle with many units",
#'     caption = "My very long plot caption with many references.")
#'
#' brand_off()
#' par("fg")
#'
#' # Back to default ggplot
#' ggplot(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
#'   geom_col() +
#'   labs(
#'     title = "Branded plot with custom fonts and color palette",
#'     subtitle = "My very long subtitle with many units",
#'     caption = "My very long plot caption with many references.")
#'
#' @export
brand_on <- function(...) {
  # Clean up to prevent chained call side effects
  brand_off()

  # Load _brand.yml config
  b = brand(...)

  # Set session color palette
  opal = palette(unlist(b$color$palette))

  # Set graphic parameters
  opar = par(par.brand())

  # Set global ggplot theme
  otheme = ggplot2::theme_set(theme_brand())

  # Create new env
  e <- new.env(parent = emptyenv())

  # Mask generic plot functions
  #e$plot.default = plot_brand
  e$legend = legend_brand
  e$ggplot = ggbrand

  # Set globals so we can restore state
  e$brand = b
  e$par = opar
  e$palette = opal
  e$theme = otheme

  # Attach env just after mbutils on the search path
  attach(e, name = .globals, warn.conflicts = FALSE)
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
  # # Close graphic devices
  # if (!is.null(dev.list())) {
  #   dev.off()
  # }

  # Restore state
  if (.globals %in% search()) {
    e = as.environment(.globals)
    par(e$par)
    palette(e$palette)
    ggplot2::theme_set(e$theme)
    detach(.globals, character.only = TRUE)
  } else {
    palette("default")
    ggplot2::theme_set(ggplot2::theme_gray())
  }
  invisible(TRUE)
}


#' Bootstrap color palette
#'
#' Color palette extracted from the active Bootstrap theme. By default colors are read from an external `_brand.yml` configuration file (or uses this package built-in brand).
#'
#' @param x Color index or name(s), skip to return the entire color palette
#' @param alpha transparency (default: 0.85)
#' @param named keep color names (default: TRUE)
#'
#' @return A vector of (named) hex color codes extracted from Bootstrap branding
#' @references [brand.yml](https://posit-dev.github.io/brand-yml/)
#' @examples
#' scales::show_col(pal())
#' scales::show_col(pal(c("orange", "red")))
#'
#' @export
pal <- function(x = NULL, alpha = .85, named = TRUE) {
  b = if (.globals %in% search()) {
    # Search the environment
    as.environment(.globals)$brand
  } else {
    # Or call `brand()`
    suppressMessages(brand())
  }

  p = if (missing(x)) b$color$palette else b$color$palette[x]
  n = names(p)
  p = adjustcolor(unlist(p), alpha.f = alpha)
  if (named) {
    names(p) = n
  }
  return(p)
}


#' Bootstrap color ramp
#'
#' Qualitative color ramp derived from active branding. This ramp excludes Bootstrap's
#' **white**, **black**, **light** and **gray** colors, which are typically used for
#' textual elements.
#'
#' @param x Brand color name(s), skip to return the entire color palette
#' @param omit Brand colors to exclude from color ramp
#' @inheritDotParams grDevices::colorRampPalette
#' @return color palette function
#' @examples
#' scales::show_col(brand.colors()(6))
#' scales::show_col(brand.colors(interpolate="spline")(12))
#' scales::show_col(brand.colors(c("orange", "light"))(12))
#'s
#' @export
brand.colors <- function(x = NULL, omit = c("white", "black", "gray"), ...) {
  x = if (missing(x)) names(pal()) else x
  x = setdiff(x, omit)
  x = pal(x)
  colorRampPalette(unname(x), ...)
}
