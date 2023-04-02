INSERT INTO Specialties (Name)
VALUES ('Computer Science'), ('Mathematics'), ('Physics');

INSERT INTO Curriculums (Name, SpecialtyId)
VALUES ('Bachelor of Computer Science', 1), ('Master of Computer Science', 1),
       ('Bachelor of Mathematics', 2), ('Master of Mathematics', 2),
       ('Bachelor of Physics', 3), ('Master of Physics', 3);

INSERT INTO Faculties (Name)
VALUES ('Faculty of Computer Science'), ('Faculty of Mathematics'), ('Faculty of Physics');

INSERT INTO Departments (Name, FacultyId)
VALUES ('Department of Computer Science', 1), ('Department of Mathematics', 2), ('Department of Physics', 3);

INSERT INTO Teachers (FirstName, SecondName, Patronymic, DepartmentId)
VALUES ('Pavel', 'Pavlov', 'Pavlovich', 1), 
       ('Ivan', 'Ivanov', 'Ivanovich', 2),
       ('Igor', 'Igorev', 'Igorevich', 3)
;

INSERT INTO Disciplines (Name)
VALUES ('Databases'), 
       ('Logic Programming'), 
       ('Calculus'), 
       ('Algebra'),
       ('Python'),
       ('Mechanics'),
       ('Embedded Programming'),
       ('Physical Education'),
       ('Web development'),
       ('Quantum Mechanics');

-- Удаляем лишний предмет
DELETE FROM Disciplines 
WHERE Name='Quantum Mechanics';

INSERT INTO Groups (Name, Course, FacultyId, CurriculumId)
VALUES ('CS-101', 1, 1, 1), ('CS-201', 2, 1, 1), 
       ('MA-101', 1, 2, 3),
       ('PH-101', 3, 3, 5), ('PH-501', 5, 3, 6);

INSERT INTO LessonTypes (Name)
VALUES ('Lecture'), ('Lab'), ('Practice');

INSERT INTO Buildings (Address)
VALUES ('Pushkinaa 21'), ('Lenina 40'), ('Pobedy 27');


INSERT INTO Classrooms (Number, BuildingId)
VALUES ('101', 1), ('102', 1), ('201', 2), ('202', 2), ('301', 3), ('302', 3);

-- Lessons
INSERT INTO Lessons (Day, DisciplineId, LessonTypeId, ClassroomId, SerialNumber)
VALUES 
    (1, 1, 1, 1, 1), -- monday/1 DB Lecture at 101 auditory groups CS-101 MA-101 / Pavel
    (1, 2, 1, 1, 2), -- monday/2 Logical Programming lecture at 101 groups CS-201 / Pavel
    (2, 4, 1, 4, 3), -- tuesday/3 Algebra Lecture at 202 groups MA-101 / Ivan
    (2, 4, 3, 4, 4), -- tuesday/4 Algebra Practice at 202 groups MA-101 / Ivan
    (3, 5, 1, 3, 3), -- wednesday/3 Python Lecture at 201 groups / Pavel
    (1, 3, 3, 5, 4),  -- monday/4 Calculus Practice at 301 groups / Igorev
    
    (1, 1, 1, 6, 1),
    (1, 1, 2, 6, 2),
    (1, 2, 1, 6, 3),
    
    (2, 2, 2, 6, 1),
    (2, 3, 1, 6, 2),
    (2, 3, 2, 6, 3),

    (3, 4, 1, 6, 1),
    (3, 4, 2, 6, 2),
    (3, 5, 1, 6, 3),

    (4, 5, 2, 6, 1),
    (4, 6, 1, 6, 2),
    (4, 6, 2, 6, 3),

    (5, 7, 1, 6, 1),
    (5, 7, 2, 6, 2),
    (5, 8, 1, 6, 3),

    (6, 8, 2, 6, 1),
    (6, 9, 1, 6, 2),
    (6, 9, 2, 6, 3),
    (6, 9, 3, 6, 4)
;

-- LessonTeacher
INSERT INTO LessonTeacher (LessonID, TeacherID)
VALUES 
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 1),
    (6, 3),

    (7,1),
    (8,1),
    (9,1),

    (10,1),
    (11,1),
    (12,1),
        
    (13,1),
    (14,1),
    (15,1),
        
    (16,1),
    (17,1),
    (18,1),
        
    (19,1),
    (20,1),
    (21,1),
        
    (22,1),
    (23,1),
    (24,1),
    (25,1)
;

-- LessonGroup
INSERT INTO LessonGroup (LessonID, GroupID)
VALUES 
    (1, 1), (1, 3),
    (2, 2),
    (3, 3),
    (4, 3),
    (5, 2), (5, 3),
    (6, 5),
    
    (7,4),
    (8,4),
    (9,4),
       
    (10,4),
    (11,4),
    (12,4),
       
    (13,4),
    (14,4),
    (15,4),
       
    (16,4),
    (17,4),
    (18,4),
       
    (19,4),
    (20,4),
    (21,4),
       
    (22,4),
    (23,4),
    (24,4),
    (25,4)
;