/*
SELECT-tests.sql
*/
USE IMDb;
-- try computing the average age of actors by gender in each year of TV series Doctor Who
WITH DoctorWhoActors AS
(
SELECT tb.primaryTitle
	, e2.primaryTitle AS episodeTitle, e2.startYear, e2.runtimeMinutes
	, e1.seasonNumber, e1.episodeNumber
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
	LEFT OUTER JOIN
		movie.namebasics AS nb
			ON nb.nconst = tp.nconst
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


