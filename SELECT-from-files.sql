USE IMDb;

SELECT *
FROM OPENROWSET (
	BULK '\\WDMYCLOUDMIRROR\SleepingDog\Projects\Data\IMdb-sql-queries\title.ratings.tsv',   
	FORMATFILE = '\\WDMYCLOUDMIRROR\SleepingDog\Projects\Data\IMdb-sql-queries\title-ratings.xml' 
) AS test1;
GO
SELECT *
FROM OPENROWSET (
	BULK '\\WDMYCLOUDMIRROR\SleepingDog\Projects\Data\IMdb-sql-queries\title.principals.tsv',   
	FORMATFILE = '\\WDMYCLOUDMIRROR\SleepingDog\Projects\Data\IMdb-sql-queries\title-principals.xml' 
) AS test2;
GO

