/*
3-CREATE-derived-TABLEs.sql

Some of the original data columns contain multiple values.
To normalise the data for efficient querying, split these into new tables.
Running time in last test approximately 06 minutes 03 seconds.
*/
USE IMDb;
GO
SELECT tconst, CAST(value AS CHAR(9)) AS castMember
	INTO deriv.titlecast
FROM movie.titleprincipals  
	CROSS APPLY STRING_SPLIT(principalCast, ','); -- requires SS2016+
GO -- approx 26760830 rows
ALTER TABLE deriv.titlecast
	ALTER COLUMN castMember CHAR(9) NOT NULL;
GO
ALTER TABLE deriv.titlecast
	ADD CONSTRAINT PK_titlecast_tconst_castMember PRIMARY KEY CLUSTERED (tconst, castMember);  
GO
