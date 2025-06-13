#' List available variables in the education finance dataset
#'
#' This function provides information about the variables available
#' in the education finance dataset, including their names, types,
#' and brief descriptions.
#'
#' @importFrom rlang .data
#' 
#' @param dataset_type A string specifying whether to list variables for "skinny" (default) or "full" dataset.
#' @param category Optional. Filter variables by category: "id", "time", "geographic", 
#'                 "demographic", "revenue", "expenditure", "economic", "governance", 
#'                 or "all" (default).
#' @return A tibble with variable information
#' @export
#'
#' @examples
#' \dontrun{
#' # List all available variables in skinny dataset
#' vars <- list_variables()
#' 
#' # List all variables in full dataset
#' full_vars <- list_variables(dataset_type = "full")
#' 
#' # List only expenditure variables in full dataset
#' exp_vars <- list_variables(dataset_type = "full", category = "expenditure")
#' }
list_variables <- function(dataset_type = "skinny", category = "all") {
  # Validate dataset_type parameter
  if (!dataset_type %in% c("skinny", "full")) {
    cli::cli_abort("dataset_type must be either 'skinny' or 'full'.")
  }
  
  # Define all variables in the exact order they appear in the datasets
  all_variables <- tibble::tibble(
    name = c(
      # Variables in skinny dataset (in order)
      "ncesid", "year", "state", "dist_name", "enroll",
      "rev_total_pp", "rev_local_pp", "rev_state_pp", "rev_fed_pp",
      "rev_total", "rev_local", "rev_state", "rev_fed",
      "rev_total_unadj", "rev_local_unadj", "rev_state_unadj", "rev_fed_unadj",
      "exp_cur_pp", "rev_exp_pp_diff", "exp_cur_st_loc", "exp_cur_fed",
      "exp_cur_resa", "exp_cur_total", "cpi_sy12",
      "mhi", "mpv", "adult_pop", "ba_plus_pop", "ba_plus_pct",
      "total_pop", "student_pop", "stpov_pop", "stpov_pct",
      "cong_dist", "state_leaid", "county", "cbsa", "urbanicity",
      "schlev", "lea_type", "lea_type_id",
      
      # === FULL DATASET ONLY VARIABLES (in order) ===
      "exp_emp_salary", "exp_emp_bene",
      "exp_textbooks", "exp_utilities",
      "exp_tech_supp", "exp_tech_equip",
      "exp_pay_private_sch", "exp_pay_charter_sch",
      "exp_pay_other_lea", "exp_other_sys_pay",
      "exp_instr_total", "exp_instr_sal", "exp_instr_bene",
      "exp_supp_stu_total", "exp_supp_stu_sal", "exp_supp_stu_bene",
      "exp_supp_instr_total", "exp_supp_instr_sal", "exp_supp_instr_bene",
      "exp_supp_gen_admin_total", "exp_supp_gen_admin_sal", "exp_supp_gen_admin_bene",
      "exp_supp_sch_admin_total", "exp_supp_sch_admin_sal", "exp_supp_sch_admin_bene",
      "exp_supp_ops_total", "exp_supp_opps_sal", "exp_supp_opps_bene",
      "exp_supp_trans_total", "exp_supp_trans_sal", "exp_supp_trans_bene",
      "exp_central_serv_total", "exp_central_serv_sal", "exp_central_serv_bene",
      "exp_noninstr_food_total", "exp_noninstr_food_sal", "exp_noninstr_food_bene",
      "exp_noninstr_ent_ops_total", "exp_noninstr_ent_ops_bene", "exp_noninstr_other",
      "exp_covid_total", "exp_covid_instr", "exp_covid_supp", "exp_covid_cap_out",
      "exp_covid_tech_supp", "exp_covid_tech_equip", "exp_covid_supp_plant", "exp_covid_food"
    ),
    
    type = c(
      # Skinny dataset types (in order)
      "character", "integer", "character", "character", "numeric",  # ncesid, year, state, dist_name, enroll
      "numeric", "numeric", "numeric", "numeric",  # rev_total_pp, rev_local_pp, rev_state_pp, rev_fed_pp
      "numeric", "numeric", "numeric", "numeric",  # rev_total, rev_local, rev_state, rev_fed
      "numeric", "numeric", "numeric", "numeric",  # rev_total_unadj, rev_local_unadj, rev_state_unadj, rev_fed_unadj
      "numeric", "numeric", "numeric", "numeric",  # exp_cur_pp, rev_exp_pp_diff, exp_cur_st_loc, exp_cur_fed
      "numeric", "numeric", "numeric",  # exp_cur_resa, exp_cur_total, cpi_sy12
      "numeric", "numeric", "numeric", "numeric", "numeric",  # mhi, mpv, adult_pop, ba_plus_pop, ba_plus_pct
      "numeric", "numeric", "numeric", "numeric",  # total_pop, student_pop, stpov_pop, stpov_pct
      "character", "character", "character", "character", "character",  # cong_dist, state_leaid, county, cbsa, urbanicity
      "character", "character", "integer",  # schlev, lea_type, lea_type_id
      # Full dataset variables - all numeric
      rep("numeric", 48)
    ),
    
    category = c(
      # Skinny dataset categories (in order)
      "id", "time", "geographic", "id", "demographic",  # ncesid, year, state, dist_name, enroll
      "revenue", "revenue", "revenue", "revenue",  # rev_total_pp, rev_local_pp, rev_state_pp, rev_fed_pp
      "revenue", "revenue", "revenue", "revenue",  # rev_total, rev_local, rev_state, rev_fed
      "revenue", "revenue", "revenue", "revenue",  # rev_total_unadj, rev_local_unadj, rev_state_unadj, rev_fed_unadj
      "expenditure", "expenditure", "expenditure", "expenditure",  # exp_cur_pp, rev_exp_pp_diff, exp_cur_st_loc, exp_cur_fed
      "expenditure", "expenditure", "economic",  # exp_cur_resa, exp_cur_total, cpi_sy12
      "economic", "economic", "demographic", "demographic", "demographic",  # mhi, mpv, adult_pop, ba_plus_pop, ba_plus_pct
      "demographic", "demographic", "demographic", "demographic",  # total_pop, student_pop, stpov_pop, stpov_pct
      "geographic", "id", "geographic", "geographic", "geographic",  # cong_dist, state_leaid, county, cbsa, urbanicity
      "governance", "governance", "id",  # schlev, lea_type, lea_type_id
      # Full dataset - all expenditure
      rep("expenditure", 48)
    ),
    
    description = c(
      # Skinny dataset descriptions (in order)
      "NCES district ID", "School year (end year, e.g., 2022 = 2021-2022)", "State abbreviation", 
      "District name", "Total district enrollment",
      "Total revenue per pupil (all sources)", "Local revenue per pupil",
      "State revenue per pupil", "Federal revenue per pupil",
      "Total revenue (all sources)", "Total local revenue",
      "Total state revenue", "Total federal revenue",
      "Total revenue (unadjusted for inflation)", "Local revenue (unadjusted)",
      "State revenue (unadjusted)", "Federal revenue (unadjusted)",
      "Current expenditure per pupil", "Revenue minus expenditure per pupil",
      "Current expenditure from state/local sources", "Current expenditure from federal sources",
      "Current expenditure for RESA/ESA", "Total current expenditure",
      "Consumer Price Index (base year 2011-2012)",
      "Median household income", "Median property value",
      "Adult population", "Adults with bachelor's degree or higher", 
      "Percent of adults with bachelor's degree or higher",
      "Total population", "Student-aged population (5-17)",
      "Student-aged population in poverty", "Percent of students in poverty",
      "Congressional district (e.g., KY-01)", "State-assigned LEA ID", "County name", 
      "Core Based Statistical Area", "Urbanicity (City, Suburb, Town, Rural)",
      "School level", "LEA type description", "LEA type numeric code",
      
      # Full dataset descriptions
      "Total employee salaries", "Total employee benefits",
      "Textbook expenditures", "Utilities expenditures",
      "Technology support expenditures", "Technology equipment expenditures",
      "Payments to private schools", "Payments to charter schools", 
      "Payments to other LEAs", "Payments to other systems",
      "Instructional expenditures total", "Instructional salaries", "Instructional benefits",
      "Student support services total", "Student support salaries", "Student support benefits",
      "Instructional support services total", "Instructional support salaries", "Instructional support benefits",
      "General administration total", "General administration salaries", "General administration benefits",
      "School administration total", "School administration salaries", "School administration benefits",
      "Operations and maintenance total", "Operations and maintenance salaries", "Operations and maintenance benefits",
      "Transportation services total", "Transportation salaries", "Transportation benefits",
      "Central services total", "Central services salaries", "Central services benefits",
      "Food services total", "Food services salaries", "Food services benefits",
      "Enterprise operations total", "Enterprise operations benefits", "Other non-instructional services",
      "COVID-related expenditures total", "COVID instructional expenditures", 
      "COVID support expenditures", "COVID capital outlay",
      "COVID technology support", "COVID technology equipment", 
      "COVID plant support", "COVID food services"
    ),
    
    dataset = c(
      # Variables in skinny dataset
      rep("skinny", 41),
      # Variables only in full dataset
      rep("full", 48)
    )
  )
  
  # Filter by dataset type
  if (dataset_type == "skinny") {
    variables <- dplyr::filter(all_variables, .data$dataset == "skinny")
  } else {
    # Full dataset includes all variables
    variables <- all_variables
  }
  
  # Remove the dataset column before returning
  variables <- dplyr::select(variables, -.data$dataset)
  
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