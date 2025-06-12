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
      "ncesid", "year", "state", "dist_name", "enroll", "rev_total_pp", "rev_local_pp",
      "rev_state_pp", "rev_fed_pp", "rev_total", "rev_local", "rev_state", "rev_fed", "exp_cur_pp",
      "rev_exp_pp_diff", "exp_cur_st_loc", "exp_cur_fed", "exp_cur_total", "mhi", "mpv", "cpi_sy12",
       "total_pop", "student_pop", "stpov_pop", "stpov_pct", "cong_dist", "state_leaid", "county", 
      "cbsa", "urbanicity", "schlev", "lea_type", "lea_type_id"    
    ),
    type = c(
      "character", "character", "character", "character",
      "numeric", "numeric", "numeric", "numeric", "numeric",
      "numeric", "numeric", "numeric", "numeric", "numeric",
      "numeric", "numeric", "numeric", "numeric", "numeric",
      "numeric", "numeric", "numeric", "numeric", "numeric",
      "numeric", "integer", "character", "character", "character",
      "factor", "character", "factor", "integer"
    ),
    category = c(
      "id", "time", 
      "geographic", "id",
      "demographic",
      "revenue", "revenue", "revenue", "revenue", 
      "revenue", "revenue", "revenue", "revenue", 
      "expenditure", "expenditure", "expenditure", 
      "expenditure", "expenditure",
      "economic", "economic", "economic",
      "demographic", "demographic", "demographic", "demographic",
      "governance", "id", "geographic", "geographic",
      "geographic", "governance", "governance", "governance"
    ),
    description = c(
      "NCES ID", "School year, listed as latest year. Ex. '2012' = '2011-2012'", "State abbreviation",
      "District name", "District enrollment",
      "Total revenue per-pupil from all sources", "Revenue per-pupil from local sources", 
      "Revenue per-pupil from state sources", "Revenue per-pupil from federal sources",
      "Total revenue from all sources", "Revenue from local sources", "Revenue from state sources", "Revenue from federal sources",
      "Total current expenditure per-pupil", "Revenue per-pupil minus current expentiture per-pupil",
      "Current expenditure, state and local", "Current expenditure, federal", "Total current expenditure",
      "Median Household Income", "Median Property Value", "Consumer Price Index, 1 = 2011-2012",
      "Total population", "Total student-aged population", "Student-aged population in poverty", 
      "Percentage of student-aged population in poverty", 
      "Congressional district, listed as 2-digit state code and 2-digit congressional district. Ex. '2001' = KY-01",
      "State LEA ID", "County", "CBSA (if assigned)", "Urbanicity, condensed into four categories: 'City', 'Suburb', 'Town', and 'Rural'",
      "School level", "LEA type", "LEA type ID"
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