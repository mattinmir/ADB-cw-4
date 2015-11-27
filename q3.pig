RUN /vol/automed/data/usgs/load_tables.pig

--feature_cut = FOREACH feature GENERATE type, county, state_name;
feature_cut_grouped = GROUP feature BY (state_name, county);
counted = FOREACH feature_cut_grouped {
			pp = FILTER feature BY type == 'ppl';
			s = FILTER feature BY type == 'stream';
			
			GENERATE 
					group.state_name AS state_name,
					group.county AS county,
					COUNT(pp.type) AS no_ppl,
					COUNT(s.type) AS no_stream;
			}
ordered = ORDER counted BY state_name, county;


STORE ordered INTO 'q3' USING PigStorage(',');