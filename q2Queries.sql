SELECT c.CourseName, creg.Grade FROM StudentRegistrationsToDegrees as sreg, CourseRegistrations as creg, CourseOffers as coffer, Courses as c where sreg.StudentId = %1% and sreg.StudentRegistrationId = creg.StudentRegistrationId and creg.Grade >= 5 and creg.CourseOfferId = coffer.CourseOfferId AND coffer.CourseId = c.CourseId AND sreg.DegreeId = %2% ORDER BY coffer.Year, coffer.Quartile, coffer.CourseOfferId;
WITH ExcellentStudentRegistrations AS (SELECT StudentRegistrationId FROM DegreeProgress WHERE GPA > %1% AND AcqECTS > TotalECTS EXCEPT (SELECT StudentRegistrationId FROM CourseRegistrations WHERE Grade IS NULL)) SELECT DISTINCT StudentId FROM ExcellentStudentRegistrations ESR, DegreeProgress DP WHERE ESR.StudentRegistrationId = DP.StudentRegistrationId ORDER BY StudentId;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;