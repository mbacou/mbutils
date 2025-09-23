#' Discrete color scale with Bootstrap colors
#'
#' Custom `ggplot2` discrete color scale to match active Bootstrap brand.
#'
#' @inheritDotParams ggplot2::discrete_scale
#'
#' @importFrom ggplot2 discrete_scale
#' @seealso scale_labs_df
#' @return a color scale
#' @export
scale_brand_dc <- function(...) {
  discrete_scale("color", palette = brand.colors, ...)
}


#' Discrete fill scale with Bootstrap colors
#'
#' Custom `ggplot2` discrete fill color scale to match active Bootstrap brand.
#'
#' @inheritDotParams ggplot2::discrete_scale
#'
#' @importFrom ggplot2 discrete_scale
#' @seealso scale_labs_dc
#' @return a fill scale
#' @export
scale_brand_df <- function(...) {
  discrete_scale("fill", palette = brand.colors, ...)
}


#' Continuous color scale with Bootstrap colors
#'
#' Custom `ggplot2` continuous color scale to match active Bootstrap brand.
#'
#' @inheritParams pal.brand
#' @inheritDotParams ggplot2::scale_colour_gradientn
#' @importFrom ggplot2 scale_colour_gradientn
#' @seealso scale_labs_cf
#' @return a color scale
#' @export
scale_brand_cc <- function(x = c("orange", "light", "green"), ...) {
  scale_colour_gradientn(colours = pal.brand(x, FALSE), ...)
}


#' Continuous fill scale with Bootstrap colors
#'
#' Custom `ggplot2` continuous fill scale to match active Bootstrap brand.
#'
#' @inheritParams pal.brand
#' @inheritDotParams ggplot2::scale_fill_gradientn
#' @importFrom ggplot2 scale_fill_gradientn
#' @seealso scale_labs_cc
#' @return a fill scale
#' @export
scale_brand_cf <- function(x = c("orange", "light", "green"), ...) {
  scale_fill_gradientn(colours = pal.brand(x, FALSE), ...)
}


#' Thematic-ally apply Bootstrap brand to base, lattice and ggplot2 graphics
#'
#' Applies Bootstrap branding to R graphics using `thematic` R package utilities. This function behaves like `thematic::thematic_on()` but instead of passing individual colors and fonts, the user can provide an external `_brand.yml` configuration file. `brand_on` takes color and font variable names per Boostrap branding (hence, do not provide hex color codes, edit `_brand.yml` instead).
#'
#' Typically charts will use Boostrap **sans-serif** font, but as of compiling that variable is not available in `brand.yml` schema, so `brand_theme` will take the **first** font declared in the **typography** tree.
#'
#' @inheritParams brand
#' @param gradient Vector of Bootstrap color (names) to use in plot gradients
#' @param n Number of colors to interpolate in plot gradients (default: 20)
#' @param alpha Transparency for color scales between 0 and 1 (default: .9)
#' @inheritParams thematic::thematic_theme
#' @importFrom thematic font_spec thematic_theme
#' @return a thematic theme object (list)
#' @examples
#' thematic::thematic_set_theme(thematic_brand())
#'
#' # base
#' hist(rchisq(100, df=4), freq=FALSE, ylim=c(0, 0.2),
#' col=1:11, border="white", xlab=NA)
#' grid(NA, NULL, col="white")
#' curve(dchisq(x, df=4), col=3, lty=2, lwd=2, add=TRUE)
#'
#' # lattice
#' lattice::show.settings()
#'
#' # ggplot2
#' require(ggplot2)
#' ggplot(mtcars, aes(factor(carb), mpg, fill=carb)) +
#'   geom_col() +
#'   labs(
#'     x = "carb", y = NULL,
#'     title = "Default Plot with Bootstrap Branding",
#'     subtitle = "My very long subtitle with many units",
#'     caption = "My very long plot caption with many references.")
#'
#' ggplot(mtcars, aes(factor(carb), mpg, fill=carb)) +
#'   geom_col()
#'
#' ggplot(mtcars, aes(factor(carb), mpg, fill=carb)) +
#'   geom_col() +
#'   guides(y=guide_axis(position="right")) +
#'   theme_brand(base_bg="light")
#'
#' @export
thematic_brand <- function(
  file = NULL,
  font = NULL,
  bg = "background",
  fg = "foreground",
  accent = c("primary", "secondary"),
  sequential = NULL,
  qualitative = NULL,
  gradient = c("orange", "light", "green"),
  n = 20,
  alpha = .9,
  ...
) {
  # Load brand locally
  b = .globals$brand
  b = if (is.null(b)) brand() else b
  p = unlist(p$color$palette)

  # Set sensible arguments to thematic_theme
  bg = if (is.na(p[bg])) p[b$color[[bg]]] else p[bg]
  fg = if (is.na(p[fg])) p[b$color[[fg]]] else p[fg]
  accent = if (is.na(p[accent[1]])) p[unlist(b$color[accent])] else p[accent]
  bg = if (is.na(bg)) "transparent" else bg
  fg = if (is.na(fg)) "black" else fg

  # Gradient scale
  sequential = if (missing(sequential)) {
    adjustcolor(colorRampPalette(p[gradient])(n), alpha.f = alpha)
  } else {
    sequential
  }

  # Qualitative palette
  qualitative = if (missing(qualitative)) {
    brand.colors(alpha = alpha)
  } else {
    qualitative
  }

  args = list(
    bg = unname(bg),
    fg = unname(fg),
    accent = unname(accent),
    font = font_spec(b$font),
    sequential = sequential,
    qualitative = qualitative,
    ...
  )
  do.call(thematic_theme, args)
}


#' Bootsrap-branded ggplot theme
#'
#' Opinionated `ggplot2` theme, compatible with `_brand.yml` feature.
#'
#' By default will use this package's built-in `_brand.yml` to apply colors and fonts unless [`brand_on()`] is called first, or unless the user provides colors and fonts as function arguments.
#'
#' @param base_color Bootstrap color name for text and line elements, or color code
#' @param base_bg Bootstrap color name for plot, panel background, or color code
#' @param base_family one of `_brand.yml` font families (currently only `base`, `monospace`, or `headings`), else a valid system or Google font family name
#' @param grid show gridlines `XY`, `X`, `Y` (default) or `n` for no gridline
#' @param legend shorthand for `theme(legend.position="...")` (default: `top`)
#' @inheritParams ggthemes::theme_foundation
#' @inheritDotParams ggplot2::theme
#'
#' @return A ggplot2 theme
#' @importFrom ggthemes theme_foundation
#' @importFrom stringr str_detect
#' @importFrom sysfonts font_families font_add_google
#' @importFrom showtext showtext_auto
#' @examples
#' require(ggplot2)
#'
#' ggplot(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
#'   geom_col() +
#'   guides(y=guide_axis(position="right")) +
#'   labs(
#'     title = "Plot with default fonts and color palette",
#'     subtitle = "My very long subtitle with many units",
#'     caption = "My very long plot caption with many references.") +
#'     theme_brand()
#'
#' ggplot(mtcars, aes(factor(carb), mpg, fill=carb)) + geom_col() +
#'   guides(y=guide_axis(position="right")) +
#'   labs(
#'     title = "Same Plot with no Bootstrap Branding",
#'     subtitle = "My very long subtitle with many units",
#'     caption = "My very long plot caption with many references.") +
#'     theme_brand(grid="XY",
#'       base_color="gray", base_bg="white", base_family="Pacifico")
#'
#' ggplot(mtcars, aes(factor(carb), mpg, fill=carb)) + geom_col() +
#'   guides(y=guide_axis(position="right")) +
#'   labs(
#'     title = "Same plot with Bootstrap Branding",
#'     subtitle = "My very long subtitle with many units",
#'     caption = "My very long plot caption with many references.") +
#'     theme_brand(base_color="light", base_bg="dark")
#'
#' @export
theme_brand <- function(
  base_color = NULL,
  base_bg = NULL,
  base_family = "base",
  base_size = 12,
  grid = c("Y", "X", "XY", "n"),
  legend = c("top", "bottom", "right", "left"),
  ...
) {
  grid = match.arg(grid)
  legend = match.arg(legend)

  # Load brand locally
  b = .globals$brand
  b = if (is.null(b)) suppressMessages(brand()) else b
  p = unlist(b$color$palette)

  base_bg = if (missing(base_bg)) p[b$color$background] else base_bg
  base_color = if (missing(base_color)) p[b$color$foreground] else base_color
  base_family = if (missing(base_family)) b$font[[1]] else base_family
  base_family = if (base_family %in% names(b$typography)) {
    b$typography[[base_family]]
  } else {
    base_family
  }

  # Test if color names or codes
  base_bg = if (base_bg %in% names(p)) p[base_bg] else base_bg
  base_color = if (base_color %in% names(p)) p[base_color] else base_color

  # Get font if not found, assume Google font
  if (!is.null(base_family) && !base_family %in% font_families()) {
    font_add_google(base_family)
    showtext_auto()
  }

  theme_foundation(base_size = base_size, base_family = base_family) +
    theme(
      plot.margin = unit(c(1, 1, 1, 1), "lines"),
      text = element_text(color = base_color, lineheight = 0.9),
      line = element_line(linetype = 1, color = base_color),
      rect = element_rect(fill = NA, linetype = 0, color = NA),
      plot.background = element_rect(fill = base_bg, color = NA),
      panel.background = element_rect(fill = base_bg, color = NA),

      panel.grid = element_line(color = NULL, linetype = 3),
      panel.grid.major = element_line(color = base_color),
      panel.grid.minor = element_blank(),

      panel.grid.major.x = if (str_detect(grid, "X")) {
        element_line()
      } else {
        element_blank()
      },
      panel.grid.major.y = if (str_detect(grid, "Y")) {
        element_line()
      } else {
        element_blank()
      },

      plot.title = element_text(face = "plain", hjust = 0, size = base_size * 1.33),
      plot.subtitle = element_text(
        margin = margin(0, 0, 1, 0, "lines"),
        face = "plain",
        size = base_size,
        hjust = 0
      ),
      plot.caption = element_text(
        margin = margin(0, 3, 0, 0, "lines"),
        size = base_size * 0.8,
        hjust = 0,
        lineheight = 1
      ),

      strip.background = element_rect(),
      strip.text = element_text(face = "bold", hjust = 0, size = base_size),

      axis.text = element_text(size = base_size),
      axis.text.x = element_text(color = NULL, size = base_size * 0.9),
      axis.text.y = element_text(color = NULL, hjust = 0),
      axis.title.x = element_text(
        color = base_color,
        size = base_size,
        face = "bold",
        hjust = 1,
        vjust = -2
      ),
      axis.title.y = element_blank(),
      axis.ticks = element_line(color = NULL),
      axis.ticks.length = unit(0.25, "lines"),
      axis.ticks.y = element_blank(),
      axis.ticks.x = element_line(color = NULL),
      axis.line = element_line(),
      axis.line.y = element_blank(),

      legend.background = element_rect(fill = NA, color = NA),
      legend.box.background = element_rect(fill = NA, color = NA),
      legend.title = element_text(
        size = base_size * 0.9,
        margin = margin(0, 0, .75, 0, "lines")
      ),
      legend.title.position = "top",
      legend.text = element_text(size = base_size * 0.8, hjust = 1),
      legend.position = legend,
      legend.justification = 0
    ) +
    theme(...)
}


#' Bootstrap-branded ggplot with custom axis and legend
#'
#' Shorthand to generate branded ggplots. Uses [theme_brand()] to control colors and fonts, and has Y-axis on the right. Axis placement can be quickly modified with argument `axes`.
#'
#' @inheritParams ggplot2::ggplot
#' @param axes position of X (`bottom` or `top`) and Y (`left` or `right`) primary axes (default: `bottomright`)
#' @inheritDotParams theme_brand
#'
#' @return A `ggplot2` object with themef elements
#' @import ggplot2
#' @importFrom data.table `%ilike%`
#' @examples
#' require(ggplot2)
#'
#' ggbrand(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
#'   geom_col() +
#'   labs(
#'     x = "carb",
#'     title = "Default Plot with Y-axis on the Right",
#'     subtitle = "My very long subtitle with many units",
#'     caption = "My very long plot caption with many references.")
#'
#' # Equivalent to below
#' ggplot(mtcars, aes(factor(carb), mpg, fill=factor(carb))) +
#'   geom_col() +
#'   scale_brand_df() +
#'   guides(y=guide_axis(position="right")) +
#'   theme_brand(grid="XY")
#'
#' ggbrand(mtcars, aes(wt, mpg, color=carb), axes="topright") +
#'   geom_smooth(color=pal.brand("red"), fill=pal.brand("pink")) +
#'   geom_point(size=3) +
#'   guides(color=guide_legend(nrow=1) +
#'   labs(
#'     title = "My Beautiful Plot with X-axis at the Top",
#'     subtitle = "My descriptive subtitle with units",
#'     caption = "My plot caption with many references.")
#'
#' ggbrand(mtcars, aes(wt, mpg, color=factor(cyl)),
#'   grid="XY", legend="bottom", base_family="Pacifico") +
#'   geom_point(size=3) +
#'   labs(
#'     x = "cyl",
#'     title = "My Plot with Full Gridlines and Pacifico Font",
#'     subtitle = "Placed the legend at the bottom",
#'     caption = "My plot caption with many references.")
#'
#' @export
ggbrand <- function(
  data = NULL,
  mapping = aes(),
  axes = c("bottomright", "topright", "bottomleft", "topleft"),
  ...
) {
  axes = match.arg(axes)

  ggplot2::ggplot(data, mapping) +
    guides(
      x = guide_axis(position = if (axes %ilike% "top") "top" else "bottom"),
      y = guide_axis(position = if (axes %ilike% "right") "right" else "left")
    ) +
    theme_brand(...)
}
