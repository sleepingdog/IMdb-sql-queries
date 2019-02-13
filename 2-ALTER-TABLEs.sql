/*
2-ALTER-TABLEs.sql
Add primary keys to the tables imported from the IMDb data files.
Running time in last test approximately 15 minutes 18 seconds.
*/
USE IMDb;  
GO  
ALTER TABLE movie.namebasics
	ALTER COLUMN nconst VARCHAR(12) NOT NULL;
GO
ALTER TABLE movie.namebasics
	ADD CONSTRAINT PK_namebasics_nconst PRIMARY KEY CLUSTERED (nconst);  
GO
ALTER TABLE movie.titlebasics
	ALTER COLUMN tconst VARCHAR(12) NOT NULL;
GO
ALTER TABLE movie.titlebasics
	ADD CONSTRAINT PK_titlebasics_tconst PRIMARY KEY CLUSTERED (tconst);  
GO
-- titleakas has multiple column primary key
ALTER TABLE movie.titleakas
	ALTER COLUMN titleId VARCHAR(12) NOT NULL;
GO
ALTER TABLE movie.titleakas
	ALTER COLUMN ordering TINYINT NOT NULL;
;
GO
ALTER TABLE movie.titleakas
	ADD CONSTRAINT PK_titleakas_titleId_ordering PRIMARY KEY CLUSTERED (titleId, ordering);  
GO
ALTER TABLE movie.titlecrew
	ALTER COLUMN tconst VARCHAR(12) NOT NULL;
GO
ALTER TABLE movie.titlecrew
	ADD CONSTRAINT PK_titlecrew_tconst PRIMARY KEY CLUSTERED (tconst);  
GO
ALTER TABLE movie.titleepisode
	ALTER COLUMN tconst VARCHAR(12) NOT NULL;
GO
ALTER TABLE movie.titleepisode
	ADD CONSTRAINT PK_titleepisode_tconst PRIMARY KEY CLUSTERED (tconst);  
GO
-- titleprincipals has multiple column primary key
ALTER TABLE movie.titleprincipals
	ALTER COLUMN tconst VARCHAR(12) NOT NULL;
GO
ALTER TABLE movie.titleprincipals
	ALTER COLUMN ordering TINYINT NOT NULL;
GO
ALTER TABLE movie.titleprincipals -- new, different format: rows no longer unique to movie
	ADD CONSTRAINT PK_titleprincipals_tconst_ordering PRIMARY KEY CLUSTERED (tconst, ordering);  
GO
ALTER TABLE movie.titleratings
	ALTER COLUMN tconst VARCHAR(12) NOT NULL;
GO
ALTER TABLE movie.titleratings
	ADD CONSTRAINT PK_titleratings_tconst PRIMARY KEY CLUSTERED (tconst);  
GO
/*
Add foreign key constraints to the tables imported from the IMDb data files.
*/
/*
ALTER TABLE movie.titleakas
ADD CONSTRAINT FK_titleakas_titleId FOREIGN KEY (titleId)  
    REFERENCES movie.titlebasics(tconst);  
GO
*/
ALTER TABLE movie.titlecrew
ADD CONSTRAINT FK_titlecrew_tconst FOREIGN KEY (tconst)  
    REFERENCES movie.titlebasics(tconst);  
GO  
ALTER TABLE movie.titleepisode
ADD CONSTRAINT FK_titleepisode_tconst FOREIGN KEY (tconst)  
    REFERENCES movie.titlebasics(tconst);  
GO
/*
ALTER TABLE movie.titleprincipals -- different format, rows no longer unique to movie
ADD CONSTRAINT FK_titleprincipals_tconst FOREIGN KEY (tconst)  
    REFERENCES movie.titlebasics(tconst);  
GO
ALTER TABLE movie.titleprincipals -- different format, rows no longer unique to movie
ADD CONSTRAINT FK_titleprincipals_nconst FOREIGN KEY (nconst)  
    REFERENCES movie.namebasics(nconst);  
GO
*/
ALTER TABLE movie.titleratings
ADD CONSTRAINT FK_titleratings_tconst FOREIGN KEY (tconst)  
    REFERENCES movie.titlebasics(tconst);  
GO  

