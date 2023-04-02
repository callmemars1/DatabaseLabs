CREATE OR ALTER PROCEDURE GetAllTeachersAndDepartments
AS
BEGIN
    DECLARE @TeacherID INT
    DECLARE @TeacherName NVARCHAR(250)
    DECLARE @DepartmentName NVARCHAR(120)

    DECLARE curTeacherDepartments CURSOR
        FOR SELECT Teachers.Id, Teachers.FirstName + ' ' + Teachers.SecondName, Departments.Name
            FROM Teachers
                     JOIN Departments ON Teachers.DepartmentId = Departments.Id

    OPEN curTeacherDepartments

    FETCH NEXT FROM curTeacherDepartments INTO @TeacherID, @TeacherName, @DepartmentName

    WHILE @@FETCH_STATUS = 0
        BEGIN
            PRINT 'Teacher: ' + @TeacherName + ', Department: ' + @DepartmentName

            FETCH NEXT FROM curTeacherDepartments INTO @TeacherID, @TeacherName, @DepartmentName
        END

    CLOSE curTeacherDepartments
    DEALLOCATE curTeacherDepartments
END
GO