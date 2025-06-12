# `edfinr`

An R package for downloading and analyzing education finance data from multiple sources.

## Installation

You can install the development version of `edfinr` from GitHub with:

```r
# install.packages("devtools")
devtools::install_github("bellwetherorg/evedfinr")
```

## Usage

```r
library(edfinr)

# Get data for all states for 2022
df <- get_finance_data(yr = "2022", geo = "all")

# Get data for Kentucky for 2020-2022
ky_data <- get_finance_data(yr = "2020:2022", geo = "KY")

# Get data for multiple states for all available years
regional_data <- get_finance_data(yr = "all", geo = "IN,KY,OH,TN")

# View available variables
vars <- list_variables()

# View only revenue variables
finance_vars <- list_variables(category = "revenue")

# Get list of valid state codes
states <- get_states()

# Use with pipe and tidyverse
library(dplyr)

get_finance_data(yr = "2022", geo = "KY") |>
  select(district_name, rev_total_pp, exp_total_pp) |>
  arrange(desc(rev_total_pp))
```

## Data Sources

This package provides access to education finance data from:

1. NCES F-33 Survey
2. NCES Common Core of Data via `educationdata`
2. Census Bureau Small Area Income Poverty Estimates (SAIPE)
3. American Community Survey 5-Year Estimates via `tidycensus`

## License

MIT License