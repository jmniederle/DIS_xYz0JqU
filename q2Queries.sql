SELECT c.CourseName, creg.Grade FROM StudentRegistrationsToDegrees as sreg, CourseRegistrations as creg, CourseOffers as coffer, Courses as c where sreg.StudentId = %1% and sreg.StudentRegistrationId = creg.StudentRegistrationId and creg.Grade >= 5 and creg.CourseOfferId = coffer.CourseOfferId AND coffer.CourseId = c.CourseId AND sreg.DegreeId = %2% ORDER BY coffer.Year, coffer.Quartile, coffer.CourseOfferId;
WITH ExcellentStudentRegistrations AS (SELECT StudentRegistrationId FROM DegreeProgress WHERE GPA > %1% AND AcqECTS > TotalECTS EXCEPT (SELECT StudentRegistrationId FROM CourseRegistrations WHERE (Grade IS NULL) or (Grade < 5))) SELECT DISTINCT StudentId FROM ExcellentStudentRegistrations ESR, DegreeProgress DP WHERE ESR.StudentRegistrationId = DP.StudentRegistrationId ORDER BY StudentId;
SELECT 0;
SELECT (count(DISTINCT S.StudentId) FILTER(WHERE Gender='F')/CAST(count(DISTINCT S.StudentId) AS DECIMAL)) AS percentage  FROM Degrees D, StudentRegistrationsToDegrees SRTD, Students S WHERE Dept = %1% AND D.DegreeId = SRTD.DegreeId AND S.StudentId = SRTD.StudentId;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;