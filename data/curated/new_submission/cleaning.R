# Paste code used to create the curated dataset here. Include comments as
# necessary. If you did not need to clean the data, use a comment like the one
# below, but also load the data with readr::read_csv() to ensure the data can be
# loaded, and to use with `saving.R`. Delete this block of comments.

# Clean data provided by <source of data>. No cleaning was necessary.
dataset <- readr::read_csv("dataset_url")

# The original dataset comes from the UN-Habitat website 
# https://data.unhabitat.org/pages/open-spaces-and-green-areas
# So download the second file on the website
# the .xlsx file is called 
# 'Urban_green_area_proportion_and_green_area_per_capita.xlsx'

# Packages 
library(tidytuesdayR)
library(readxl)
library(janitor)
library(dplyr)
library(tidyr)

# Clean dataset 
# Ignore the first sheet because it has metadata and info 
# Then we will fix the columns that are in wide format and leave 
# the entire dataset in long format 
urban <- readxl::read_excel('tt_submission/Urban_green_area_proportion_and_green_area_per_capita.xlsx', 
                            sheet = 2, 
                            na = '-') |> 
  janitor::clean_names(case = "small_camel") |> 
  tidyr::pivot_longer(
    cols = matches("^(averageShareOfGreenAreaInCityUrbanArea|greenAreaPerCapita)\\d{4}"),
    names_to = c(".value", "year"),
    names_pattern = "^(averageShareOfGreenAreaInCityUrbanArea|greenAreaPerCapita)(\\d{4})"
  ) |>
  rename(
    averageShareOfGreenAreaInCityUrbanAreaPct = averageShareOfGreenAreaInCityUrbanArea,
    greenAreaPerCapitaM2 = greenAreaPerCapita
  ) |>
  mutate(year = as.integer(year))

# tt_save_dataset(urban)




