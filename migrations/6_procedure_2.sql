CREATE OR ALTER PROCEDURE CLEAR_CLASSROOM @classroomId INT
AS
BEGIN
    DECLARE @buildingId INT;

    IF NOT EXISTS(SELECT *
                  FROM Classrooms C
                  WHERE C.Id = @classroomId)
        RETURN;

    SELECT @buildingId = (SELECT C.BuildingId
                          FROM Classrooms C
                          WHERE C.Id = @classroomId)

    DELETE
    FROM Classrooms
    WHERE Id = @classroomId

    IF NOT EXISTS(SELECT *
                  FROM Classrooms
                  WHERE BuildingId = @buildingId)
        DELETE
        FROM Buildings
        WHERE @buildingId = Id
END;