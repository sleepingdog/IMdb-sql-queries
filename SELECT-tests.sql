/*
SELECT-tests.sql
*/
USE IMDb;
-- try computing the average age of actors by gender in each year of TV series Doctor Who
-- noting that the data is imperfect and weightings are ignored in this crude example
-- particularly it does not seem possible to distinguish actors in each episode
-- from other crew who also have acting in their primary profession
-- although any 'principals' who match directors/writers can be eliminated
WITH DoctorWhoActors AS
(
SELECT tb.primaryTitle
	, e2.primaryTitle AS episodeTitle, e2.startYear, e2.runtimeMinutes
	, e1.seasonNumber, e1.episodeNumber
	--, tp.principalCast
	, nb.primaryName, nb.birthYear, nb.primaryProfession
	, e2.startYear - nb.birthYear AS age
	, CASE WHEN tp.category = 'actor' THEN e2.startYear - nb.birthYear ELSE NULL END AS maleAge
	, CASE WHEN tp.category = 'actress' THEN e2.startYear - nb.birthYear ELSE NULL END AS femaleAge
FROM movie.titlebasics AS tb
	INNER JOIN
		movie.titleepisode AS e1
			ON tb.tconst = e1.parentTconst
	INNER JOIN
		movie.titlebasics AS e2
			ON e1.tconst = e2.tconst
	LEFT OUTER JOIN
		movie.titleprincipals AS tp
			ON tp.tconst = e1.tconst
	/*LEFT OUTER JOIN
		deriv.titlecast AS tc
			ON e1.tconst = tc.tconst*/
	LEFT OUTER JOIN
		movie.namebasics AS nb
			ON nb.nconst = tp.nconst
	LEFT OUTER JOIN
		movie.titlecrew AS dw
			ON e1.tconst = dw.tconst
WHERE tb.primaryTitle = 'Doctor Who' AND tb.titleType = 'tvSeries'
	AND tp.category IN ('actress', 'actor')
)
-- basic SELECT statement
/*
SELECT *
FROM DoctorWhoActors
ORDER BY startYear ASC, seasonNumber ASC, episodeNumber ASC
*/
-- group by average actor age per year
SELECT primaryTitle, startYear, AVG(maleAge) AS avgMaleAge, AVG(femaleAge) AS avgFemaleAge
FROM DoctorWhoActors
GROUP BY primaryTitle, startYear
ORDER BY startYear ASC
--*/
;
GO


