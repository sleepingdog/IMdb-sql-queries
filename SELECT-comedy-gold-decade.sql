/*
Retrieve by the years (in the period 2000 to 2009) the count of movies produced in a genre of Comedy whose rating was greater than the average rating of movies in similar genres for that year.
*/
USE IMDb;
--Set minimum number of votes to counts in averages
DECLARE @minimumVotes AS SMALLINT = 100;
--SELECT similar genres
WITH SimilarGenres AS (
	SELECT DISTINCT value
	FROM movie.titlebasics  
			CROSS APPLY STRING_SPLIT(genres, ',')
	WHERE genres LIKE '%Comedy%'
		AND NOT value = 'Comedy'
		AND LOWER(titleType) = 'movie'
	--ORDER BY value ASC;
)
--SELECT movie titles in similar genres
, SimilarGenreMovies AS (
	SELECT tb.tconst, tb.startYear
	FROM movie.titlebasics AS tb
		INNER JOIN
			SimilarGenres AS sg
				ON sg.value IN (SELECT value FROM STRING_SPLIT(tb.genres, ','))
		WHERE tb.genres NOT LIKE '%Comedy%'
			AND LOWER(titleType) = 'movie'
)
--SELECT average ratings for similar genres per year 2000-2009
, AverageRatings AS (
	SELECT sgm.startYear, AVG(tr.averageRating) AS yearAverageRating, COUNT(*) AS movieCount
	FROM SimilarGenreMovies AS sgm
		INNER JOIN
			movie.titleratings AS tr
				ON sgm.tconst = tr.tconst
	WHERE sgm.startYear BETWEEN 2000 AND 2009
		AND numVotes > @minimumVotes
	GROUP BY sgm.startYear
)
--SELECT above-average Comedy movies
, AboveAverageComedyMovies AS (
	SELECT tb.tconst, tb.primaryTitle, tb.genres, tb.startYear, tr.averageRating, ar.yearAverageRating, ar.movieCount
	FROM movie.titlebasics AS tb
		INNER JOIN
			movie.titleratings AS tr
				ON tb.tconst = tr.tconst
		INNER JOIN
			AverageRatings AS ar
				ON tb.startYear = ar.startYear
	WHERE tb.genres LIKE '%Comedy%'
		AND LOWER(tb.titleType) = 'movie'
		AND averageRating > yearAverageRating
)
--SELECT count
SELECT aacm.startYear AS 'Year', COUNT(*) AS AboveAverageComedyMovies, aacm.movieCount AS NonComedyMovies
FROM AboveAverageComedyMovies AS aacm
GROUP BY aacm.startYear, aacm.movieCount
ORDER BY aacm.startYear ASC
;

/*
Resulting 3-column table should look something like:

Year	AboveAverageComedyMovies	NonComedyMovies
2000	406	1763
2001	498	1871
2002	456	1958
2003	563	1893
2004	477	2280
2005	651	2462
2006	602	2817
2007	605	3001
2008	629	3048
2009	812	3260
*/

