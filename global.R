
library(shiny)
library(ggvis)
library(dplyr)


source("track_functions.R")
source("transformation_functions.R")

population_flows <- read.csv("data/population_data.csv")

region_flows <- population_flows %>%
  group_by(region_orig, region_dest) %>%
  summarise(regionflow_1990 = first(regionflow_1990), regionflow_1995 = first(regionflow_1995),
            regionflow_2000 = first(regionflow_2000), regionflow_2005 = first(regionflow_2005))


region_totals_out <- region_flows %>%
  group_by(region_orig) %>%
  summarise(total_flow_1990 = sum(regionflow_1990), total_flow_1995 = sum(regionflow_1995),
            total_flow_2000 = sum(regionflow_2000), total_flow_2005 = sum(regionflow_2005))

region_totals_in <- region_flows %>%
  group_by(region_dest) %>%
  summarise(total_flow_1990 = sum(regionflow_1990), total_flow_1995 = sum(regionflow_1995),
            total_flow_2000 = sum(regionflow_2000), total_flow_2005 = sum(regionflow_2005))


link_one_region <- function(region_flows, region_totals_out, region) {
  
  region_flows %>% filter(region_orig == region) %>% select(1:3) %>% ungroup() %>%
    left_join(region_totals_out, by = c("region_dest" = "region_orig")) %>%
    mutate(pos_from_start = c(0, cumsum(regionflow)[1:9]), pos_from_end = cumsum(regionflow) - 1,
           pos_to_start = total_flow, pos_to_end = total_flow + regionflow) %>%
    select(region_orig, region_dest, regionflow, pos_from_start, pos_from_end, pos_to_start, pos_to_end)
  
}

