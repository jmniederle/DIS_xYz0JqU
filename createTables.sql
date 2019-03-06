CREATE UNLOGGED TABLE Degrees(DegreeId int, Dept varchar(50), DegreeDescription varchar(200), TotalECTS int); 
CREATE UNLOGGED TABLE Students(StudentId int, StudentName varchar(50), Address varchar(200), BirthyearStudent int, Gender char);
CREATE UNLOGGED TABLE StudentRegistrationsToDegrees(StudentRegistrationId int, StudentId int, DegreeId int, RegistrationYear int);
CREATE UNLOGGED TABLE Teachers(TeacherId int, TeacherName varchar(50), Address varchar(200), BirthYearTeacher int, Gender char);
CREATE UNLOGGED TABLE Courses(CourseId int, CourseName varchar(50), CourseDescription varchar(200), DegreeId int, ECTS int);
CREATE UNLOGGED TABLE CourseOffers(CourseOfferId int, CourseId int, Year int, Quartile int);
CREATE UNLOGGED TABLE TeacherAssignmentsToCourses(CourseOfferId int, TeacherId int);
CREATE UNLOGGED TABLE StudentAssistants(CourseOfferId int, StudentRegistrationId int);
CREATE UNLOGGED TABLE CourseRegistrations(CourseOfferId int, StudentRegistrationId int, Grade int);

COPY Degrees(DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/mnt/ramdisk/tables/Degrees.table' DELIMITER ',' CSV HEADER;
COPY Students(StudentId, StudentName, Address, BirthYearStudent, Gender) FROM '/mnt/ramdisk/tables/Students.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationsToDegrees(StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/mnt/ramdisk/tables/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER;
COPY Teachers(TeacherId, TeacherName, Address, BirthYearTeacher, Gender) FROM '/mnt/ramdisk/tables/Teachers.table' DELIMITER ',' CSV HEADER;
COPY Courses(CourseId, CourseName, CourseDescription, DegreeId, ECTS) FROM '/mnt/ramdisk/tables/Courses.table' DELIMITER ',' CSV HEADER;
COPY CourseOffers(CourseOfferId, CourseId, Year, Quartile) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY TeacherAssignmentsToCourses(CourseOfferId, TeacherId) FROM '/mnt/ramdisk/tables/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants(CourseOfferId, StudentRegistrationId) FROM '/mnt/ramdisk/tables/StudentAssistants.table' DELIMITER ',' CSV HEADER;
COPY CourseRegistrations(CourseOfferId, StudentRegistrationId, Grade) FROM '/mnt/ramdisk/tables/CourseRegistrations.table' DELIMITER ',' NULL 'null' CSV HEADER;

ALTER TABLE Degrees ADD PRIMARY KEY (DegreeId);
ALTER TABLE Students ADD PRIMARY KEY (StudentId);
ALTER TABLE StudentRegistrationsToDegrees ADD PRIMARY KEY (StudentRegistrationId);
ALTER TABLE Teachers ADD PRIMARY KEY (TeacherId);
ALTER TABLE Courses ADD PRIMARY KEY (CourseId);
ALTER TABLE TeacherAssignmentsToCourses ADD PRIMARY KEY (CourseOfferId, TeacherId);
ALTER TABLE CourseOffers ADD PRIMARY KEY (CourseOfferId);
ALTER TABLE StudentAssistants ADD PRIMARY KEY (CourseOfferId, StudentRegistrationId);
ALTER TABLE CourseRegistrations ADD PRIMARY KEY (StudentRegistrationId, CourseOfferId);

CREATE TABLE DegreeProgress AS(WITH Progress AS(select SRTD.StudentId, CR.StudentRegistrationId, SRTD.DegreeId, SUM(CAST(Grade AS DECIMAL) * ECTS)/SUM(ECTS) AS GPA, SUM(ECTS) AS AcqECTS from CourseRegistrations CR, CourseOffers CO, Courses C, StudentRegistrationsToDegrees SRTD WHERE CR.CourseOfferId = CO.CourseOfferId AND C.CourseId = CO.CourseId AND GRADE >= 5 AND SRTD.StudentRegistrationId = CR.StudentRegistrationId GROUP BY (SRTD.StudentId, CR.StudentRegistrationId, SRTD.DegreeId)) SELECT Progress.*, TotalEcts FROM Progress, Degrees D Where D.DegreeId = Progress.DegreeId);

ANALYZE VERBOSE;

