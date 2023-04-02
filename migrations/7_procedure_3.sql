CREATE OR ALTER PROCEDURE DELETE_DEPARTMENT @departmentId INT
AS
BEGIN
    IF NOT EXISTS(SELECT *
                  FROM Departments D
                  WHERE D.Id = @departmentId)
        RETURN;

    DELETE
    FROM Teachers 
    WHERE DepartmentId = @departmentId

    DELETE
    FROM Departments
    WHERE @departmentId = Id
END;