DROP TABLE IF EXISTS GroupStudyingDatabasesPhysicsAndPython

CREATE TABLE GroupStudyingDatabasesPhysicsAndPython
(
    GroupID INT NOT NULL UNIQUE,
    FOREIGN KEY (GroupID) REFERENCES Groups (ID) ON DELETE CASCADE,
);

INSERT INTO GroupStudyingDatabasesPhysicsAndPython
SELECT DISTINCT G.ID
FROM Groups G
         INNER JOIN LessonGroup LG on G.Id = LG.GroupID
         INNER JOIN Lessons L on L.Id = LG.LessonID
         INNER JOIN Disciplines D on D.Id = L.DisciplineId
WHERE D.Name IN ('Databases', 'Python', 'Physics');

DELETE
FROM GroupStudyingDatabasesPhysicsAndPython
WHERE GroupID IN (1, 3);

GO

ALTER TABLE GroupStudyingDatabasesPhysicsAndPython
    ADD GroupName NVARCHAR(20) NULL;

GO

UPDATE GroupStudyingDatabasesPhysicsAndPython
SET GroupName = (SELECT G.Name
                 FROM Groups G
                 WHERE GroupID = G.Id);