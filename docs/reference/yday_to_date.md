# Format yday dates

Format yday dates

## Usage

``` r
yday_to_date(x, format = "%m-%d")
```

## Arguments

- x:

  A numeric vector to format

- format:

  a [`character`](https://rdrr.io/r/base/character.html) string. If not
  specified when converting from a character representation, it will try
  `tryFormats` one by one on the first non-`NA` element, and give an
  error if none works. Otherwise, the processing is via
  [`strptime()`](https://rdrr.io/r/base/strptime.html) whose help page
  describes available conversion specifications.

## Value

formatted character vector
