#' List available variables in the education finance dataset
#'
#' This function provides information about the variables available
#' in the education finance dataset, including their names, types,
#' and brief descriptions.
#'
#' @importFrom rlang .data
#' 
#' 
#' @param category Optional. Filter variables by category: "finance", "demographic", 
#'                 "geographic", or "all" (default).
#' @return A tibble with variable information
#' @export
#'
#' @examples
#' \dontrun{
#' # List all available variables
#' vars <- list_variables()
#' 
#' # List only finance variables
#' finance_vars <- list_variables("finance")
#' }
list_variables <- function(category = "all") {
  # Define variable information
  variables <- tibble::tibble(
    name = c(
      # These are placeholder examples - should be updated with real column names
      "year", "state", "district_id", "district_name", "county_name",
      "total_revenue", "state_revenue", "local_revenue", "federal_revenue",
      "total_expenditure", "instruction_expenditure", "support_services_expenditure",
      "capital_outlay", "enrollment", "frpl_percent", "median_household_income",
      "poverty_percent", "population"
    ),
    type = c(
      "numeric", "character", "character", "character", "character",
      "numeric", "numeric", "numeric", "numeric",
      "numeric", "numeric", "numeric",
      "numeric", "numeric", "numeric", "numeric",
      "numeric", "numeric"
    ),
    category = c(
      "time", "geographic", "geographic", "geographic", "geographic",
      "finance", "finance", "finance", "finance",
      "finance", "finance", "finance",
      "finance", "demographic", "demographic", "demographic",
      "demographic", "demographic"
    ),
    description = c(
      "Fiscal year", "State abbreviation", "District ID", "District name", "County name",
      "Total revenue from all sources", "Revenue from state sources", "Revenue from local sources", "Revenue from federal sources",
      "Total expenditure", "Expenditure on instruction", "Expenditure on support services",
      "Capital outlay expenditure", "Total student enrollment", "Percentage of students eligible for free/reduced price lunch", "Median household income in district",
      "Percentage of school-age children in poverty", "Total population in district"
    )
  )
  
  # Filter by category if requested
  if (category != "all") {
    variables <- dplyr::filter(variables, .data$category == !!category)
  }
  
  return(variables)
}

#' Get list of valid state codes
#'
#' Returns the valid two-letter state codes that can be used with get_finance_data
#'
#' @return A character vector of state codes
#' @export
#'
#' @examples
#' \dontrun{
#' states <- get_states()
#' }
get_states <- function() {
  states <- c(
    "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", 
    "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", 
    "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", 
    "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", 
    "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "DC"
  )
  
  return(states)
}