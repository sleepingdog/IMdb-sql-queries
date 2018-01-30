/*
1-SELECT-INTO-TABLEs.sql

To simply file paths, the drive letter I: has been mapped to
the directory containing all the relevant files. Do this first.
*/
-- DROP existing IMDb database
USE [master]
GO
/*
ALTER DATABASE IMDb
SET OFFLINE;
GO
*/
DROP DATABASE IF EXISTS IMDb;
GO
-- CREATE IMDb database
CREATE DATABASE IMDb;
GO
USE IMDb;
GO
-- CREATE schemas
CREATE SCHEMA movie; -- for grouping all the original IMDb tables
GO
CREATE SCHEMA deriv; -- for grouping tables derived from IMDb data
GO
-- SELECT from files INTO new TABLES
-- Minimize logging from bulk actions:
ALTER DATABASE IMDb SET RECOVERY BULK_LOGGED;  
GO  
/*
SELECT * INTO   
GO
*/
SELECT titleId, ordering, title
	, CAST((CASE WHEN region = '\N' THEN NULL ELSE region END) AS CHAR(5)) AS region
	, CAST((CASE WHEN language = '\N' THEN NULL ELSE language END) AS CHAR(10)) AS language
	, CAST((CASE WHEN types = '\N' THEN NULL ELSE types END) AS VARCHAR) AS types
	, CAST((CASE WHEN attributes = '\N' THEN NULL ELSE attributes END) AS VARCHAR) AS attributes
	, CAST((CASE WHEN isOriginalTitle = '\N' THEN NULL ELSE isOriginalTitle END) AS BIT) AS isOriginalTitle
	INTO movie.titleakas
FROM OPENROWSET (
	BULK 'I:\title.akas.tsv',   
	FORMATFILE = 'I:\title-akas.xml',
	FIRSTROW = 2,
	CODEPAGE = '65001' -- utf-8, requires SS2016+
) AS titleakas; -- approx 3559746 rows
GO
-- Restore logging
ALTER DATABASE IMDb SET RECOVERY FULL;  
GO  

