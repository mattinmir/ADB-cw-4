spp = JOIN state BY code, populated_place BY state_code;

grouped_spp = GROUP spp BY state::name;

avg_elev = FOREACH grouped_spp GENERATE name, SUM(spp.population), (int)AVG(spp.elevation);



STORE avg_elev INTO 'q1' USING PigStorage(',');