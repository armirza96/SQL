-- Get details of all the people who live in the city of Montréal and who got
-- vaccinated at least two doses of different types of vaccines. (First-name, last-name, date of birth, email, phone, 
-- city, date of vaccination, vaccination type, been infected by COVID-19 before or not).
-- From: COVID 19 tracking project, found in root > php > reports > q13
SELECT
  firstName as FIRST_NAME,
  lastName as LAST_NAME,
  dateOfBirth as DOB,
  email as EMAIL,
  telephone as PHONE,
  CITY,
  CONCAT(VCN.dateGiven,' AND ', VCN2.dateGiven) as DATE_GIVEN,
  CONCAT(VCNE.name,' AND ', VCNE2.name) as VACCINE_TYPE,
  (CASE WHEN EXISTS
    (SELECT 1 FROM PatientInfection PI WHERE PI.patientID = P.ID)
    THEN 'YES' ELSE 'NO'
  END) as PREVIOUSLY_INFECTED
FROM Patient P
	  INNER JOIN Vaccination VCN ON VCN.patientID = P.ID
    INNER JOIN Vaccination VCN2 ON VCN2.patientID = P.ID
    INNER JOIN Vaccine VCNE ON VCNE.ID = VCN.vaccineID
    INNER JOIN Vaccine VCNE2 ON VCNE2.ID = VCN2.vaccineID
WHERE
    CITY = 'Montreal' AND
    VCN.vaccineID <> VCN2.vaccineID
GROUP BY
  FIRST_NAME,
  LAST_NAME,
  DOB,
  EMAIL,
  PHONE,
  CITY,
  DATE_GIVEN
HAVING COUNT(VCN.dateGiven) = 2
