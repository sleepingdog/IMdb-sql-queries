/*
try some age-related SELECT queries
*/
USE IMDb;
-- SELECT 100 oldest movie actors/actresses at time of their performances, given a movie
-- might take a couple of years from performance to release.
-- Notes: some death years are presumably missing.
--   Results include Nino Cochise, Madeleine Milhaud and Kazuo Ôno, which seem genuine.
--   Only pure actor/actress professionals are included.
--   Archive footage may be incorporated into documentaries, offsetting performance dates.
--   Rows are performances, so actors may repeat.
DECLARE @releaseDelay AS TINYINT; -- maximum year offset between production and release.
SET @releaseDelay = 2; -- actors may have died between performance and release.
SELECT TOP 100 c.primaryName
	, c.birthYear
	, c.deathYear
	, (c.deathYear - (ISNULL(c.birthYear, YEAR(GETDATE())))) AS ageLatest
	, (t.startYear - c.birthYear) AS agePerformance
	, c.primaryProfession
	, t.primaryTitle
	, t.startYear
	, t.endYear
	, t.titleType
	, 'https://www.imdb.com/title/' + t.tconst AS movieLink -- t.tconst example: tt0249050
	--, '<a href="https://www.imdb.com/title/' + t.tconst + '">' + t.primaryTitle + '</a>' AS movieLink -- t.tconst example: tt0249050
FROM movie.namebasics AS c
	INNER JOIN
		deriv.titlecast AS tc
			ON c.nconst = tc.castMember
	INNER JOIN
		movie.titlebasics AS t
			ON tc.tconst = t.tconst
WHERE (c.primaryProfession IN ('actor', 'actress')
	AND t.titleType = 'movie'
	AND ISNULL(c.deathYear, YEAR(GETDATE())) >= (ISNULL(t.endYear, t.startYear)) - @releaseDelay)
ORDER BY agePerformance DESC
;
