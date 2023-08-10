SELECT FileName = df.name
	,df.physical_name
	,current_file_size_MB = df.size*1.0/128
	,max_size = 
	CASE df.max_size
		WHEN 0 THEN 'Autogrowth is off.'
		WHEN -1 THEN 'Autogrowth is on.'
		ELSE 'Log file grows to a maximum size of 2 TB.'
	END
	,growth_value =
     CASE
       WHEN df.growth = 0 THEN df.growth
       WHEN df.growth > 0 AND df.is_percent_growth = 0 THEN df.growth*1.0/128.0
       WHEN df.growth > 0 AND df.is_percent_growth = 1 THEN df.growth
     END
	 ,growth_increment_unit =
     CASE
       WHEN df.growth = 0 THEN 'Size is fixed.'
       WHEN df.growth > 0 AND df.is_percent_growth = 0  THEN 'Growth value is MB.'
       WHEN df.growth > 0 AND df.is_percent_growth = 1  THEN 'Growth value is a percentage.'
     END
FROM .sys.master_files AS df;
