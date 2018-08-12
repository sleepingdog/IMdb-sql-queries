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
FROM movie.namebasics AS c
	INNER JOIN
		deriv.titlecast AS tc
			ON c.nconst = tc.castMember
	INNER JOIN
		movie.titlebasics AS t
			ON tc.tconst = t.tconst
WHERE (c.primaryProfession IN ('actor', 'actress')
	AND t.titleType = 'movie'
	AND ISNULL(c.deathYear, YEAR(GETDATE())) >= (ISNULL(t.endYear, t.startYear)) - 2)
ORDER BY agePerformance DESC
;
