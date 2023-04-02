-- disable all constraints
EXEC sp_MSForEachTable "ALTER TABLE ? NOCHECK CONSTRAINT all";

-- delete data in all tables
EXEC sp_MSForEachTable "DELETE FROM ?";

-- enable all constraints
EXEC sp_MSForEachTable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";

-- reseed all identity columns
EXEC sp_MSForEachTable "DBCC CHECKIDENT ('?', RESEED, 0)";
    
    