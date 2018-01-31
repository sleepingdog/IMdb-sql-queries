/*
2-ALTER-TABLEs.sql
Add primary keys to the tables imported from the IMDb data files.
*/
USE IMDb;  
GO  
ALTER TABLE movie.namebasics
	ALTER COLUMN nconst CHAR(9) NOT NULL;
GO
ALTER TABLE movie.namebasics
	ADD CONSTRAINT PK_namebasics_nconst PRIMARY KEY CLUSTERED (nconst);  
GO
ALTER TABLE movie.titlebasics
	ALTER COLUMN tconst CHAR(9) NOT NULL;
GO
ALTER TABLE movie.titlebasics
	ADD CONSTRAINT PK_titlebasics_tconst PRIMARY KEY CLUSTERED (tconst);  
GO
-- titleakas has multiple column primary key
ALTER TABLE movie.titleakas
	ALTER COLUMN titleId CHAR(9) NOT NULL;
GO
ALTER TABLE movie.titleakas
	ALTER COLUMN  ordering TINYINT NOT NULL;
;
GO
ALTER TABLE movie.titleakas
	ADD CONSTRAINT PK_titleakas_titleId_ordering PRIMARY KEY CLUSTERED (titleId, ordering);  
GO
ALTER TABLE movie.titlecrew
	ALTER COLUMN tconst CHAR(9) NOT NULL;
GO
ALTER TABLE movie.titlecrew
	ADD CONSTRAINT PK_titlecrew_tconst PRIMARY KEY CLUSTERED (tconst);  
GO
ALTER TABLE movie.titleepisode
	ALTER COLUMN tconst CHAR(9) NOT NULL;
GO
ALTER TABLE movie.titleepisode
	ADD CONSTRAINT PK_titleepisode_tconst PRIMARY KEY CLUSTERED (tconst);  
GO
ALTER TABLE movie.titleprincipals
	ALTER COLUMN tconst CHAR(9) NOT NULL;
GO
ALTER TABLE movie.titleprincipals
	ADD CONSTRAINT PK_titleprincipals_tconst PRIMARY KEY CLUSTERED (tconst);  
GO
ALTER TABLE movie.titleratings
	ALTER COLUMN tconst CHAR(9) NOT NULL;
GO
ALTER TABLE movie.titleratings
	ADD CONSTRAINT PK_titleratings_tconst PRIMARY KEY CLUSTERED (tconst);  
GO




