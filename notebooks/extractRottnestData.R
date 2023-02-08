
# this script is used to extract the Rottnest Island data from the PerthNRM data
# loading the entire dataset is slow, so it is faster to do it once and save to
# a smaller file which can be loaded quickly

suppressMessages(library(data.table))
suppressMessages(library(tidyverse))

all_surveys = fread("../data/PerthNRMall/surveys.csv")
all_obsv = fread("../data/PerthNRMall/sightings.csv")

rotto_surveys <- all_surveys %>% 
    filter(Latitude > -32.2, Latitude < -31.8) %>% 
    filter(Longitude < 115.6)

#merge observations with surveys
colnames_ralo_to_merge <- c(
    "Survey ID","Source","Source Ref","Completed","All Species Recorded",
    "Survey Point ID","Survey Point Name","Latitude","Longitude","Accuracy (m)",
    "Number of Observers","Survey Notes","Start Date","Start Time",
    "Finish Date","Survey Type","Duration (mins)" ,"Program","Water Level",
    "Raisers Edge ID","User Name","Private Survey","Shared Site")
rotto <- merge(all_obsv, rotto_surveys, by = colnames_ralo_to_merge)

#write to csv
write_csv(rotto, "../data/rottnestObservations.csv")

