-- ON UPDATE не используется из-за бесполезности в контексте, где все ключи авто-инкрементные
-- https://stackoverflow.com/questions/1481476/when-to-use-on-update-cascade
-- Используются авто-инкрементные числовые ключи, т.к. это является лучшей практикой
-- sources: https://stackoverflow.com/questions/337503/whats-the-best-practice-for-primary-keys-in-tables

CREATE TABLE Specialties
(
    Id   INT PRIMARY KEY IDENTITY (1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE
);

-- Учебный план
CREATE TABLE Curriculums
(
    Id          INT PRIMARY KEY IDENTITY (1,1),
    Name        NVARCHAR(250) NOT NULL UNIQUE,
    SpecialtyId INT           NOT NULL,
    FOREIGN KEY (SpecialtyId) REFERENCES Specialties (Id) ON DELETE CASCADE
);

CREATE TABLE Faculties
(
    Id   INT PRIMARY KEY IDENTITY (1,1),
    Name NVARCHAR(120) NOT NULL UNIQUE
);

-- Кафедры
CREATE TABLE Departments
(
    Id        INT PRIMARY KEY IDENTITY (1,1),
    Name      NVARCHAR(120) NOT NULL UNIQUE,
    FacultyId INT           NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties (Id) ON DELETE NO ACTION
);

CREATE TABLE Teachers
(
    Id           INT PRIMARY KEY IDENTITY (1,1),
    FullName     NVARCHAR(250) NOT NULL,
    DepartmentId INT           NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments (Id) ON DELETE NO ACTION
);

CREATE TABLE Disciplines
(
    Id   INT PRIMARY KEY IDENTITY (1,1),
    Name NVARCHAR(75) NOT NULL UNIQUE
);

CREATE TABLE Groups
(
    Id           INT PRIMARY KEY IDENTITY (1,1),
    Name         NVARCHAR(50) NOT NULL UNIQUE,
    Course       INT          NOT NULL CHECK (Course BETWEEN 1 AND 6), -- 5 и 6 магистратура
    FacultyId    INT          NOT NULL,
    CurriculumId INT          NOT NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties (Id) ON DELETE NO ACTION,
    FOREIGN KEY (CurriculumId) REFERENCES Curriculums (Id) ON DELETE NO ACTION
);

CREATE TABLE LessonTypes
(
    Id   INT PRIMARY KEY IDENTITY (1,1),
    Name NVARCHAR(8) NOT NULL UNIQUE
);

-- Учебные корпуса
CREATE TABLE Buildings
(
    Id      INT PRIMARY KEY IDENTITY (1,1),
    Address NVARCHAR(100) NOT NULL UNIQUE
);

-- Аудитории
CREATE TABLE Classrooms
(
    Id         INT PRIMARY KEY IDENTITY (1,1),
    Number     VARCHAR(32) NOT NULL, -- 32 на случай, если это спортивный зал или подобное
    BuildingId INT         NOT NULL,
    CONSTRAINT UQ_Number_BuildingId UNIQUE (Number, BuildingId),
    FOREIGN KEY (BuildingId) REFERENCES Buildings (Id) ON DELETE CASCADE
);

CREATE TABLE Lessons
(
    Id           INT PRIMARY KEY IDENTITY (1,1),
    Day          INT NOT NULL CHECK (Day BETWEEN 1 AND 6),          -- в вс не учимся
    SerialNumber INT NOT NULL CHECK (SerialNumber BETWEEN 1 AND 6), -- всего 6 пар
    DisciplineId INT NOT NULL,
    LessonTypeId INT NOT NULL,
    ClassroomId  INT NOT NULL,
    FOREIGN KEY (DisciplineId) REFERENCES Disciplines (Id) ON DELETE CASCADE,
    FOREIGN KEY (LessonTypeId) REFERENCES LessonTypes (Id) ON DELETE CASCADE,
    FOREIGN KEY (ClassroomId) REFERENCES Classrooms (Id) ON DELETE CASCADE
    -- Без типа занятия или изучаемого предмета или аудитории занятие не имеет смысла
);

-- Несколько преподавателей могут вести пару (Физра/Английский/Физика и т.д.)
CREATE TABLE LessonTeacher
(
    LessonID  INT NOT NULL,
    TeacherID INT NOT NULL,
    PRIMARY KEY (LessonID, TeacherID),
    FOREIGN KEY (LessonID) REFERENCES Lessons (ID) ON DELETE CASCADE,
    FOREIGN KEY (TeacherID) REFERENCES Teachers (ID) ON DELETE CASCADE
);

-- Несколько групп могут присутствовать на паре
CREATE TABLE LessonGroup
(
    LessonID INT NOT NULL,
    GroupID  INT NOT NULL,
    PRIMARY KEY (LessonID, GroupID),
    FOREIGN KEY (LessonID) REFERENCES Lessons (ID) ON DELETE CASCADE,
    FOREIGN KEY (GroupID) REFERENCES Groups (ID) ON DELETE CASCADE
);