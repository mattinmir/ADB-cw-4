RUN /vol/automed/data/usgs/load_tables.pig

joined = JOIN populated_place BY state_code, state BY code;

joined_cut = FOREACH joined GENERATE state::name AS state_name, populated_place::name AS name, population AS population; 
nonulls = FILTER joined_cut BY population IS NOT NULL;
grouped = GROUP nonulls BY (state_name);

top5 = FOREACH grouped {
	sorted = ORDER nonulls BY population DESC;
	top = LIMIT sorted 5;
	
	GENERATE FLATTEN(top) AS (state_name, name, population);
	}
	 

state_order = ORDER top5 By state_name ASC, population DESC ;

STORE state_order INTO 'q4' USING PigStorage(',');