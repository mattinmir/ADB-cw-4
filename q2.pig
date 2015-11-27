RUN /vol/automed/data/usgs/load_tables.pig

spp = JOIN state BY code, populated_place BY state_code;

spp_cut = FOREACH spp GENERATE state::name, populated_place::population, populated_place::elevation;

grouped_spp = GROUP spp_cut BY state::name;

avg_elev = FOREACH grouped_spp GENERATE group AS state_name, SUM(spp_cut.population), ROUND(AVG(spp_cut.elevation));

avg_elev_ordered = ORDER avg_elev BY state_name;


STORE avg_elev_ordered INTO 'q2' USING PigStorage(',');