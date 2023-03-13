library(DBI)

sobs_db <- dbConnect(RSQLite::SQLite(), 
                     "/Users/roryeggleston/Documents/WILD6900_DataScience/Sobs_DataManagement/code/sobs.db")

dbExecute(sobs_db, "CREATE TABLE sobs_survey (
  global_id_plot text NOT NULL,
  date_and_start_time_plot text,
  observer_plot text,
  transect_id text,
  visit char(2),
  plot_type varchar(20),
  burn_category text,
  sky_start char(1),
  sky_end char(1),
  wind_start char(1),
  wind_end char(1),
  start_temp varchar(3),
  end_temp varchar(3),
  creation_date_plot text,
  creator_plot text,
  edit_date_plot text,
  editor_plot text,
  lat_plot double,
  long_plot double,
  utm_easting_plot double,
  utm_northing_plot double,
  utm_zone_plot char(2),
  PRIMARY KEY (global_id_plot)
);")

sobs_survey <- read.csv("/Users/roryeggleston/Documents/WILD6900_DataScience/Sobs_DataManagement/data/Sobs_Survey_2022_Editable.csv",
                        stringsAsFactors = FALSE)
names(sobs_survey)

dbWriteTable(sobs_db, "sobs_survey", sobs_survey, append = TRUE)

dbGetQuery(sobs_db, "SELECT * FROM sobs_survey LIMIT 10;")


dbExecute(sobs_db, "CREATE TABLE sobs_point (
          global_id_point text NOT NULL,
          point text,
          start_time_at_point text,
          private_property varchar(3),
          cliff_rock varchar(3),
          cheatgrass_present varchar(3),
          why_no_survey text,
          global_id_plot text NOT NULL,
          creation_date_point text,
          creator_point text,
          edit_date_point text,
          editor_point text,
          area_burned varchar(3),
          percent_burned integer,
          point_notes_pt text,
          lat_point double,
          long_point double,
          utm_easting_point double,
          utm_northing_point double,
          utm_zone_point char(2),
          PRIMARY KEY (global_id_point),
          FOREIGN KEY (global_id_plot) REFERENCES sobs_survey(global_id_plot)
          );")

sobs_point <- read.csv("/Users/roryeggleston/Documents/WILD6900_DataScience/Sobs_DataManagement/data/Sobs_Point_2022_Editable.csv",
                       stringsAsFactors = FALSE)
names(sobs_point)

dbWriteTable(sobs_db, "sobs_point", sobs_point, append = TRUE)

dbGetQuery(sobs_db, "SELECT * FROM sobs_point LIMIT 10;")

dbExecute(sobs_db, "CREATE TABLE sobs_obs (
          global_id_obs text,
          minute integer,
          species_code varchar(5),
          radial_distance integer,
          how_detected char(1),
          song_also varchar(3),
          sex char(1),
          visual_detection varchar(3),
          migrating varchar(3),
          point_notes_obs text,
          global_id_point text,
          creation_date_obs text,
          creator_obs text,
          edit_date_obs text,
          editor_obs text,
          bird_within_burn varchar(3),
          direction varchar(20),
          PRIMARY KEY (global_id_obs),
          FOREIGN KEY (global_id_point) REFERENCES sobs_point(global_id_point)
);")

sobs_obs <- read.csv("/Users/roryeggleston/Documents/WILD6900_DataScience/Sobs_DataManagement/data/Sobs_Observations_2022_Editable.csv",
                       stringsAsFactors = FALSE)
names(sobs_obs)

dbWriteTable(sobs_db, "sobs_obs", sobs_obs, append = TRUE)

dbGetQuery(sobs_db, "SELECT * FROM sobs_obs LIMIT 10;")
