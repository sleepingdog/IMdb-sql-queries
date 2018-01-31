/*
SELECT-tests.sql
*/
USE IMDb;

SELECT TOP 10 numVotes
FROM movie.titleratings
ORDER BY numVotes DESC;

SELECT averageRating, COUNT(averageRating) AS freq
FROM movie.titleratings
GROUP BY averageRating
ORDER BY averageRating ASC;

SELECT tb.primaryTitle
	, e2.primaryTitle AS episodeTitle, e2.startYear, e2.runtimeMinutes
	, e1.seasonNumber, e1.episodeNumber
	, tp.principalCast
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
WHERE tb.primaryTitle = 'Doctor Who' AND tb.titleType = 'tvSeries'
ORDER BY e2.startYear ASC, e1.seasonNumber ASC, e1.episodeNumber ASC;



