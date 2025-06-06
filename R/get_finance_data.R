#' Get Education Finance Data
#'
#' This function downloads tidy education finance data using data from the
#' NCES F-33 Survey, Census Bureau Small Area Income Poverty Estimates (SAIPE),
#' and community data from the ACS 5-Year Estimates.
#'
#' #' @importFrom rlang .data
#'
#' @param yr A string specifying the year(s) to retrieve. Can be a single year ("2022"),
#'           a range ("2020:2022"), or "all" for all available years.
#' @param geo A string specifying the geographic scope. Can be "all" for all states,
#'           a single state code ("KY"), or a comma-separated list of state codes ("IN,KY,OH,TN").
#' @param refresh A logical value indicating whether to force a refresh of the cached data.
#'                Default is FALSE, which uses cached data if available.
#' @param quiet A logical value indicating whether to suppress download progress messages.
#'              Default is FALSE.
#' @return A tibble containing the requested education finance data.
#' @export
#'
#' @examples
#' \dontrun{
#' # Get data for all states for 2022
#' df <- get_finance_data(yr = "2022", geo = "all")
#'
#' # Get data for Kentucky for 2020-2022
#' ky_data <- get_finance_data(yr = "2020:2022", geo = "KY")
#'
#' # Get data for multiple states for all available years
#' regional_data <- get_finance_data(yr = "all", geo = "IN,KY,OH,TN")
#'
#' # Use with pipe
#' library(dplyr)
#' get_finance_data(yr = "2022", geo = "KY") |>
#'   select(district_name, total_revenue, total_expenditure) |>
#'   arrange(desc(total_revenue))
#' }
get_finance_data <- function(yr = "2022", geo = "all", refresh = FALSE, quiet = FALSE) {
  # Define valid years (assuming 2012-2022 based on filename)
  valid_years <- 2012:2022

  # Define valid state codes (all US states + DC)
  valid_states <- c(
    "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
    "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
    "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
    "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
    "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "DC"
  )

  # Validate year parameter
  if (yr != "all") {
    if (grepl(":", yr)) {
      # Validate year range
      yr_range <- strsplit(yr, ":")[[1]]
      if (length(yr_range) != 2) {
        cli::cli_abort("Year range must be in format 'start:end', e.g., '2020:2022'.")
      }

      start_yr <- suppressWarnings(as.numeric(yr_range[1]))
      end_yr <- suppressWarnings(as.numeric(yr_range[2]))

      if (is.na(start_yr) || is.na(end_yr)) {
        cli::cli_abort("Year range must contain valid numeric years.")
      }

      if (!start_yr %in% valid_years || !end_yr %in% valid_years) {
        cli::cli_abort("Years must be between {min(valid_years)} and {max(valid_years)}.")
      }

      if (start_yr > end_yr) {
        cli::cli_abort("Start year must be less than or equal to end year.")
      }
    } else {
      # Validate single year
      single_yr <- suppressWarnings(as.numeric(yr))
      if (is.na(single_yr)) {
        cli::cli_abort("Year must be a valid number, a range (e.g., '2020:2022'), or 'all'.")
      }

      if (!single_yr %in% valid_years) {
        cli::cli_abort("Year must be between {min(valid_years)} and {max(valid_years)}.")
      }
    }
  }

  # Validate geography parameter
  if (geo != "all") {
    states <- strsplit(geo, ",")[[1]]

    # Check if all provided states are valid
    invalid_states <- states[!states %in% valid_states]
    if (length(invalid_states) > 0) {
      cli::cli_abort("Invalid state code(s): {paste(invalid_states, collapse = ', ')}.
                     State codes must be valid two-letter US state codes.")
    }
  }

  # URL for the RDS file
  url <- "https://edfinr-tidy-data.s3.us-east-2.amazonaws.com/edfinr_data_fy12_fy22_clean.rds"

  # Cache handling
  cache_name <- "edfinr_data_fy12_fy22_clean.rds"
  cache_file_path <- cache_file(cache_name)

  # Check if we need to download the data
  download_required <- refresh || !is_cache_current(cache_name)

  if (download_required) {
    if (!quiet) {
      cli::cli_alert_info("Downloading education finance data...")
    }

    # Download the file to cache
    utils::download.file(url, cache_file_path, mode = "wb", quiet = quiet)

    if (!quiet) {
      cli::cli_alert_success("Download complete.")
    }
  } else if (!quiet) {
    cli::cli_alert_info("Using cached data. Use refresh = TRUE to download fresh data.")
  }

  # Read the RDS file from cache
  data <- readRDS(cache_file_path)

  # Convert to tibble if it's not already
  if (!inherits(data, "tbl_df")) {
    data <- tibble::as_tibble(data)
  }

  # Process year parameter
  if (yr != "all") {
    if (grepl(":", yr)) {
      # Handle year range (e.g., "2020:2022")
      yr_range <- strsplit(yr, ":")[[1]]
      start_yr <- as.numeric(yr_range[1])
      end_yr <- as.numeric(yr_range[2])
      years <- start_yr:end_yr
      data <- dplyr::filter(data, .data$year %in% years)
    } else {
      # Handle single year
      data <- dplyr::filter(data, .data$year == as.numeric(yr))
    }
  }

  # Process geography parameter
  if (geo != "all") {
    # Handle comma-separated list of states
    states <- strsplit(geo, ",")[[1]]
    data <- dplyr::filter(data, .data$state %in% states)
  }

  return(data)
}

