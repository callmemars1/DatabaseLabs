ALTER TABLE Teachers DROP COLUMN FullName;
ALTER TABLE Teachers ADD FirstName  NVARCHAR(50) NOT NULL DEFAULT 'Не установлено';
ALTER TABLE Teachers ADD SecondName NVARCHAR(50) NOT NULL DEFAULT 'Не установлено';
ALTER TABLE Teachers ADD Patronymic NVARCHAR(50) NULL;
