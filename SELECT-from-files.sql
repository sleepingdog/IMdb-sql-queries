USE IMDb;

SELECT tconst, averageRating, numVotes
FROM OPENROWSET (
	BULK 'I:\title.ratings.tsv',   
	FORMATFILE = 'I:\title-ratings.xml' 
) AS test1;
GO
SELECT tconst, principalCast
FROM OPENROWSET (
	BULK 'I:\title.principals.tsv',   
	FORMATFILE = 'I:\title-principals.xml' 
) AS test2;
GO
SELECT titleId, ordering, title
	, CAST((CASE WHEN region = '\N' THEN NULL ELSE region END) AS CHAR(5)) AS region
	, CAST((CASE WHEN language = '\N' THEN NULL ELSE language END) AS CHAR(10)) AS language
	, CAST((CASE WHEN types = '\N' THEN NULL ELSE types END) AS VARCHAR) AS types
	, CAST((CASE WHEN attributes = '\N' THEN NULL ELSE attributes END) AS VARCHAR) AS attributes
	, CAST((CASE WHEN isOriginalTitle = '\N' THEN NULL ELSE isOriginalTitle END) AS BIT) AS isOriginalTitle
FROM OPENROWSET (
	BULK 'I:\title.akas.tsv',   
	FORMATFILE = 'I:\title-akas.xml',
	CODEPAGE = '65001'
) AS test2;
GO
