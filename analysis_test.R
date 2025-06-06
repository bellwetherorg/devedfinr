library(tidyverse)
library(devedfinr)

ky_22 <- get_finance_data(yr = "2022", geo = "KY")

ky_12_thru_22 <- get_finance_data(yr = "2012:2022", geo = "KY")

all_data <- get_finance_data(yr = "all", geo = "all")
