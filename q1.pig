RUN /vol/automed/data/usgs/load_tables.pig

state_statenames = FOREACH state GENERATE LOWER(name) AS state_name;

feature_statenames = FOREACH feature GENERATE LOWER(state_name)AS state_name;

joined = JOIN feature_statenames BY state_name LEFT, state_statenames BY state_name;

filtered = FILTER joined BY state_statenames::state_name IS NULL;

filtered_dist = DISTINCT filtered;

STORE filtered INTO 'q1' USING PigStorage(',');




