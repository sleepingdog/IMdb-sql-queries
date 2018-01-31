# IMdb-sql-queries
Builds a Microsoft SQL Server 2016+ relational database from IMDb official data files, to support personal querying.

If you have a SQL Server 2016 Express or better, and you want to query IMDb (internet movie database) data using SQL, these files allow you to import the data into relational tables.

You can currently download the data files in tab-separated-value format from:
http://www.imdb.com/interfaces/
(please read the official guidance and licencing)
which when unpacked will give you:

name.basics.tsv
title.akas.tsv
title.basics.tsv
title.crew.tsv
title.episode.tsv
title.principals.tsv
title.ratings.tsv

If you put the XML format files and SQL bulk upload files in the same directory, and map your I: drive (on Windows) to that directory, then hopefully running the numbered SQL files in order will create and populate a database for you.

1-SELECT-INTO-TABLEs.sql
2-ALTER-TABLEs.sql

I plan to add some queries of interest later. Also create some derived tables to better normalise the data.
