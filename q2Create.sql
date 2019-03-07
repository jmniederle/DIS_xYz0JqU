CREATE INDEX SREGsid_idx ON StudentRegistrationsToDegrees USING hash(StudentId);
CREATE INDEX DP_sidSrID_index ON DegreeProgress (StudentRegistrationID, StudentId);
CREATE INDEX DP_Grade_index ON DegreeProgress (GPA);
CREATE INDEX CREG_coidSrid ON CourseRegistrations (CourseOfferId, StudentRegistrationId);

