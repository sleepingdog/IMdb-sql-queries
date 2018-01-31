/*
1-SELECT-INTO-TABLEs.sql

To simplify file paths, the drive letter I: has been mapped to
the directory containing all the relevant files. Do this first.
Running time in last test approximately 6 minutes 40 seconds.
*/
-- DROP existing IMDb database
USE [master]
GO
/*
ALTER DATABASE IMDb
SET OFFLINE;
GO
DROP DATABASE IF EXISTS IMDb;
GO
*/
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
SELECT tconst, titleType, primaryTitle, originalTitle,
	isAdult
	, CAST((CASE WHEN startYear = '\N' THEN NULL ELSE startYear END) AS SMALLINT) AS startYear
	, CAST((CASE WHEN endYear = '\N' THEN NULL ELSE endYear END) AS SMALLINT) AS endYear
	, CAST((CASE WHEN runtimeMinutes = '\N' THEN NULL ELSE runtimeMinutes END) AS INT) AS runtimeMinutes
	, CAST((CASE WHEN genres = '\N' THEN NULL ELSE genres END) AS NVARCHAR(50)) AS genres
	INTO movie.titlebasics
FROM OPENROWSET (
	BULK 'I:\title.basics.tsv',
	FORMATFILE = 'I:\title-basics.xml',
	FIRSTROW = 2,
	CODEPAGE = '65001' -- utf-8, requires SS2016+
) AS titlebasics; -- approx 4760383 rows
GO
SELECT tconst
	, (CASE WHEN directors = '\N' THEN NULL ELSE directors END) AS directors
	, (CASE WHEN writers = '\N' THEN NULL ELSE writers END) AS writers
	INTO movie.titlecrew
FROM OPENROWSET (
	BULK 'I:\title.crew.tsv',
	FORMATFILE = 'I:\title-crew.xml',
	FIRSTROW = 2,
	CODEPAGE = '65001' -- utf-8, requires SS2016+
) AS titlecrew; -- approx 4219 and 5659 characters respectively
GO
SELECT tconst, parentTconst
	, CAST((CASE WHEN seasonNumber = '\N' THEN NULL ELSE seasonNumber END) AS SMALLINT) AS seasonNumber
	, CAST((CASE WHEN episodeNumber = '\N' THEN NULL ELSE episodeNumber END) AS INT) AS episodeNumber
	INTO movie.titleepisode
FROM OPENROWSET (
	BULK 'I:\title.episode.tsv',
	FORMATFILE = 'I:\title-episode.xml',
	FIRSTROW = 2,
	CODEPAGE = '65001' -- utf-8, requires SS2016+
) AS titleepisode;  -- approx 3167900 rows
GO
SELECT tconst, principalCast
	INTO movie.titleprincipals
FROM OPENROWSET (
	BULK 'I:\title.principals.tsv',   
	FORMATFILE = 'I:\title-principals.xml',
	FIRSTROW = 2,
	CODEPAGE = '65001' -- utf-8, requires SS2016+
) AS titleprincipals; -- approx 4234452 rows
GO
SELECT tconst, averageRating, numVotes
	INTO movie.titleratings
FROM OPENROWSET (
	BULK 'I:\title.ratings.tsv',   
	FORMATFILE = 'I:\title-ratings.xml',
	FIRSTROW = 2,
	CODEPAGE = '65001' -- utf-8, requires SS2016+
) AS titleratings; -- approx 798666 rows
GO
SELECT nconst, primaryName
	, CAST((CASE WHEN birthYear = '\N' THEN NULL ELSE birthYear END) AS SMALLINT) AS birthYear
	, CAST((CASE WHEN deathYear = '\N' THEN NULL ELSE deathYear END) AS SMALLINT) AS deathYear
	, primaryProfession, knownForTitles
	INTO movie.namebasics
FROM OPENROWSET (
	BULK 'I:\name.basics.tsv',
	FORMATFILE = 'I:\name-basics.xml',
	FIRSTROW = 2,
	CODEPAGE = '65001' -- utf-8, requires SS2016+
) AS namebasics; -- approx 8378045 rows
GO
-- Restore logging
ALTER DATABASE IMDb SET RECOVERY FULL;  
GO  

