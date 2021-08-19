-- Get details of all the people who got vaccinated only one dose and are of
-- group ages 1 to 3 (first-name, last-name, date of birth, email, phone, city, date of
-- vaccination, vaccination type, been infected by COVID-19 before or not).
-- From COVID 19 tracking database project, can be found under root > php > reports > q12.

SELECT
  firstName as FIRST_NAME,
  lastName as LAST_NAME,
  dateOfBirth as DOB,
  email as EMAIL,
  telephone as PHONE,
  CITY,
  dateGiven as DATE_GIVEN,
  VCNE.NAME as VACCINE_TYPE,
  (CASE WHEN EXISTS
    (SELECT 1 FROM PatientInfection PI WHERE PI.patientID = P.ID)
    THEN 'YES' ELSE 'NO'
  END) as PREVIOUSLY_INFECTED
FROM Patient P
	INNER JOIN Vaccination VCN ON VCN.patientID = P.ID
    INNER JOIN Vaccine VCNE ON VCNE.ID = VCN.vaccineID
WHERE P.ageGroupID IN (1,2,3)
GROUP BY
  FIRST_NAME,
  LAST_NAME,
  DOB,
  EMAIL,
  PHONE,
  CITY,
  DATE_GIVEN,
  VACCINE_TYPE
HAVING COUNT(dateGiven) = 1
