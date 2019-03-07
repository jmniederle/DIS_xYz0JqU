CREATE TABLE DegreeProgress AS(WITH Progress AS(select SRTD.StudentId, CR.StudentRegistrationId, SRTD.DegreeId, SUM(CAST(Grade AS DECIMAL) * ECTS)/SUM(ECTS) AS GPA, SUM(ECTS) AS AcqECTS from CourseRegistrations CR, CourseOffers CO, Courses C, StudentRegistrationsToDegrees SRTD WHERE CR.CourseOfferId = CO.CourseOfferId AND C.CourseId = CO.CourseId AND GRADE >= 5 AND SRTD.StudentRegistrationId = CR.StudentRegistrationId GROUP BY (SRTD.StudentId, CR.StudentRegistrationId, SRTD.DegreeId)) SELECT Progress.*, TotalEcts FROM Progress, Degrees D Where D.DegreeId = Progress.DegreeId);
CREATE INDEX SREGsid_idx ON StudentRegistrationsToDegrees USING hash(StudentId);
CREATE INDEX DP_sidSrID_index ON DegreeProgress (StudentRegistrationID, StudentId);
CREATE INDEX DP_Grade_index ON DegreeProgress (GPA);
CREATE INDEX CREG_coidSrid ON CourseRegistrations (CourseOfferId, StudentRegistrationId);

