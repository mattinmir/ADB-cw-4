RUN /vol/automed/data/usgs/load_tables.pig


STORE avg_elev INTO 'q4' USING PigStorage(',');