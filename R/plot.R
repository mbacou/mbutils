#' Wrapper for graphics::legend()
#'
#' Simply assign default arguments to base R [legend()]. This function is exported but is not meant to be called directly, use [brand_on()] instead.
#'
#' @inheritParams graphics::legend
#' @inheritDotParams graphics::legend
#'
#' @seealso [axes()]
#' @returns Branded legend for base R plots
#' @examples
#' set.seed(1)
#' x = runif(100, min = -5, max = 5)
#' y = x ^ 3 + rnorm(100, mean = 0, sd = 5)
#'
#' opar = par(par.brand())
#'
#' plot(x, y, type="h", col=(y>0)+4)
#' axes(nx=NULL,
#'   main="Bootstrap Branded Plot", sub="My Subtitle",
#'   xlab="X Units", ylab="Y Units")
#' abline(h=0, col=pal("red"), lwd=2)
#' legend_brand(legend=names(pal())[4:5], lty=1, lwd=2, col=4:5)
#'
#' plot(x, type="h", col=pal())
#' axes(side=c(1,4),
#'   main="My Bootstrap Branded Plot",
#'   sub="Histogram, dummy legend", ylab="Frequency")
#' legend_brand(legend=paste("cat", 1:3), fill=pal(1:3))
#'
#' par(opar)
#'
#' @export
legend_brand = function(
  x = "topright",
  y = NULL,
  legend,
  bty = "n",
  horiz = TRUE,
  xpd = TRUE,
  inset = c(-0.05, -0.4),
  par = par.brand(),
  ...
) {
  graphics::legend(
    x = x,
    y = y,
    legend = legend,
    bty = bty,
    horiz = horiz,
    xpd = xpd,
    inset = inset,
    ...
  )
}


#' Bootstrap-branded axes and labels for base R graphics
#'
#' Shorthand function to apply Bootstrap brand to base R plot axes and labels. Many tips derived from [r-charts.com](https://r-charts.com/base-r/margins/), since base R graphic documentation is often lacking.
#'
#' This function has no side effect and does not modify the current device, but it does require at minimum to specifiy `par(mar = c(2, 2, 7, 3))` to provide margin space for all plot labels.
#'
#' @param side position of axes, up to 4 (1-bottom, 2-left, 3-top, 4-right)
#' @param at length-2 list of x/y points at which tickmarks are to be drawn, default `list(x=NA, y=NA)`
#' @param axes.lty length-2 type of axis line (depends on `nx` value, c(0,1) if vertical gridlines are drawn) but can be modified here
#' @param gap.axis length-2 minimal gap between axis labels
#' @param grid.col gridline color
#' @param grid.lty gridline type
#' @param grid.lwd gridline width
#'
#' @inheritParams graphics::title
#' @inheritParams graphics::axis
#' @inheritParams graphics::grid
#' @importFrom stringi stri_flatten
#'
#' @returns Branded axis and grid for base R plots
#' @examples
#' set.seed(1)
#' x = runif(100, min = -5, max = 5)
#' y = x ^ 3 + rnorm(100, mean = 0, sd = 5)
#'
#' opar = par(par.brand())
#'
#' plot(x, y)
#' axes(nx=NULL, xlab="X Units", ylab="Y Units",
#'   main="My Bootstrap Branded Plot", sub="Subtitle")
#' abline(h=0, col="red", lwd=2)
#'
#' plot(x, type="h", col=c("red", "green")[(x > 0) + 1])
#' axes(xlab="X units", ylab="Y units",
#'   main="My Bootstrap Branded Plot", sub="Histogram")
#' legend_brand(legend=c("Red", "Green"), lty=1, lwd=2, col=c("red", "green"))
#'
#' hist(x, col=pal(), border=NA)
#' axes(c(1,4), xlab=NA, ylab="Frequency",
#'   main="My Bootstrap Branded Plot", sub="Histogram, dummy legend")
#' legend_brand(legend=paste("cat", 1:3), fill=pal(1:3), lty=0)
#'
#' # Restore
#' par(opar)
#'
#' @export
axes = function(
  side = getOption("axes.side"),
  at = list(x = NULL, y = NULL),
  axes.lty = NULL,
  gap.axis = c(NA, NA),
  line = c(0, 0),
  main = NA,
  sub = NA,
  xlab = NA,
  ylab = NA,
  nx = NA,
  ny = NULL,
  grid.col = par("col"), # par() does not provide these specifically
  grid.lty = "dotted",
  grid.lwd = par("lwd")
) {
  side = if (is.null(side)) c(1, 2) else side

  side = match.arg(
    as.character(side),
    choices = as.character(0:4),
    several.ok = TRUE
  )

  # Override local par()
  opar = par(
    col.lab = par("fg"),
    ann = TRUE,
    xaxt = "s",
    yaxt = "s",
    no.readonly = TRUE
  )
  on.exit(suppressWarnings(par(opar)))

  # Axis line type logic
  axes.lty = if (missing(axes.lty)) c(1 * is.na(nx), 0) else axes.lty
  axes.lty = if (length(axes.lty) == 1) rep(axes.lty, 2) else axes.lty

  if (1 %in% side) {
    axis(1, lty = axes.lty[1], line = line[1], at = at[["x"]], gap.axis = gap.axis[1])
  }
  if (2 %in% side) {
    axis(2, lty = axes.lty[2], line = line[2], at = at[["y"]], gap.axis = gap.axis[2])
  }
  if (3 %in% side) {
    axis(3, lty = axes.lty[1], line = line[1], at = at[["x"]], gap.axis = gap.axis[1])
  }
  if (4 %in% side) {
    axis(4, lty = axes.lty[2], line = line[2], at = at[["y"]], gap.axis = gap.axis[2])
  }

  # Gridlines
  grid(nx = nx, ny = ny, col = grid.col, lty = grid.lty, lwd = grid.lwd)

  # Axis labels
  mtext(
    stri_flatten(
      c(ylab, xlab),
      collapse = if (is.na(xlab) || is.na(ylab)) "" else " / ",
      na_empty = NA
    ),
    side = c(1, 3)[(1 %in% side) + 1],
    line = 0.25,
    adj = (2 %in% side) + 0,
    cex = par("cex.lab"),
    font = par("font.lab"),
    col = par("col.lab")
  )

  # Main
  title(main = main, line = 5, adj = 0, col.main = par("fg"))

  # Sub
  mtext(
    sub,
    side = 3,
    line = 3.5,
    adj = 0,
    cex = par("cex.sub"),
    font = par("font.sub"),
    col = par("col.sub")
  )
}


#' Graphical parameters for Bootstrap branded plots
#'
#' Opinionated mods to base R plots compatible with new `_brand.yml` feature. Does not load any brand by itself, explicitely call [brand_on()] if needed instead.
#'
#' @param fg Bootstrap color **name** for text and line elements, or color code
#' @param bg Bootstrap color **name** for plot, panel background, or color code
#' @param family one of `_brand.yml` font families (currently only `base`, `monospace`, or `headings`), else a valid System or Google font family name
#' @inheritParams graphics::par
#' @inheritDotParams graphics::par
#' @returns a list of graphical parameters
#' @examples
#' opar = par(par.brand())
#' par()
#' # Restore plotting device to default state
#' par(opar)
#'
#' @export
par.brand = function(fg = NULL, bg = NULL, font = "base", ...) {
  b = if (.globals %in% search()) {
    # Search the environment
    as.environment(.globals)$brand
  } else {
    # Or call `brand()`
    suppressMessages(brand())
  }

  # Provide package defaults
  p = unlist(b$color$palette)
  bg = if (missing(bg)) p[b$color$background] else bg
  fg = if (missing(fg)) p[b$color$foreground] else fg

  # Check for Bootstrap names
  bg = if (bg %in% names(p)) p[bg] else bg
  fg = if (fg %in% names(p)) p[fg] else fg
  bg = unname(bg)
  fg = unname(fg)

  # Get font, if not found assume Google font
  font = if (font %in% names(b$typography)) {
    b$typography[[font]]$family
  } else {
    font
  }
  if (!is.null(font) && !font %in% font_families()) {
    font_add_google(font)
  }

  p = list(
    bty = "n",
    mar = c(4.1, 4.1, 6.5, 3.1),
    mgp = c(1, 0.5, 0), # axis title, labels, line spacing
    pty = "m",

    fg = fg,
    bg = bg,
    col = fg,
    family = font,
    cex.main = 1.5, # seems device and dpi dependent
    cex.sub = 1.15,
    cex.axis = 1,
    cex.lab = 1,
    font.main = 1,
    font.sub = 1,
    font.lab = 3,
    col.main = fg,
    col.sub = adjustcolor(fg, alpha = .5),
    col.lab = bg,
    las = 1,
    tck = 0.025,

    ann = FALSE,
    xaxs = "r",
    yaxs = "r",
    xaxt = "n",
    yaxt = "n",
    ...
  )

  # Skip NULL elements
  p[sapply(p, length) > 0]
}
