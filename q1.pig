state_statenames = 		FOREACH state 
						GENERATE LOWER(name) AS state_name;
						
feature_statenames = 	FOREACH feature 
						GENRERATE LOWER(state_name);

joined = 				JOIN feature_statenames BY state_name LEFT,
						state_statenames BY name;

filtered = 				FILTER joined
						BY state_statenames::name IS NULL;
						

STORE filtered INTO 'q1' USING PigStorage(',');
