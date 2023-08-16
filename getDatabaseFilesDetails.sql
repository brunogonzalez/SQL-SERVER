SELECT [File Name] = df.name
	,[Physical Name]=df.physical_name
	,[Current File Size (MB)] = FORMAT(df.size*1.0/128, '0.######')
	,[Max File Size]= 
	CASE df.max_size
		WHEN 0 THEN 'Autogrowth is off.'
		WHEN -1 THEN 'Autogrowth is on.'
		ELSE 'Log file grows to a maximum size of 2 TB.'
	END
	,[File Growth Value]=
     CASE
       WHEN df.growth = 0 THEN FORMAT(df.growth, '0.######')
       WHEN df.growth > 0 AND df.is_percent_growth = 0 THEN FORMAT(df.growth*1.0/128.0, '0.######')
       WHEN df.growth > 0 AND df.is_percent_growth = 1 THEN FORMAT(df.growth, '0.######')
     END
	 ,[Growth Increment Unit]=
     CASE
       WHEN df.growth = 0 THEN 'Size is fixed.'
       WHEN df.growth > 0 AND df.is_percent_growth = 0  THEN 'Growth value is MB.'
       WHEN df.growth > 0 AND df.is_percent_growth = 1  THEN 'Growth value is a percentage.'
     END
FROM .sys.master_files AS df;
