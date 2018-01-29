/*
1-SELECT-INTO-TABLEs.sql

To simply file paths, the drive letter I: has been mapped to
the directory containing all the relevant files. Do this first.
*/
-- CREATE IMDb database
CREATE DATABASE IMDb;
GO
USE IMDb;
GO
-- CREATE schemas
CREATE SCHEMA movie; -- for grouping all the original IMDb tables
GO
CREATE SCHEMA deriv; -- for grouping tables derived from IMDb data
GO
-- SELECT from files INTO new TABLES
-- Minimize logging from bulk actions:
ALTER DATABASE IMDb SET RECOVERY BULK_LOGGED;  
GO  
/*
SELECT * INTO   
GO
*/
-- Restore logging
ALTER DATABASE IMDb SET RECOVERY FULL;  
GO  

