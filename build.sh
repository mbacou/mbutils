#!/bin/bash

# Description: - document, build and install R package
#              - render HTML documentation
#

cd "$(dirname "$(realpath "$0")")";

# Exit on error
set -e

# Favicons (one-time)
#R -e 'pkgdown::build_favicons(pkg = ".", overwrite=TRUE)'

# Update package datasets
R -e 'source("data-raw/data.R")'

# Document
R -e 'devtools::document()'

# Build package documentation
R -e 'pkgdown::build_site_github_pages()'

# install local
R -e 'devtools::install()'
