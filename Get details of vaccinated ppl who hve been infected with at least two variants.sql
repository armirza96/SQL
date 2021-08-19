-- Get details of all the people who got vaccinated and have been infected with at
-- least two different variants of Covid-19 (first-name, last-name, date of birth,
-- email, phone, city, date of vaccination, vaccination type, number of times being
-- infected by COVID-19 variants)

SELECT
  firstName as FIRST_NAME,
  lastName as LAST_NAME,
  dateOfBirth as DOB,
  email as EMAIL,
  telephone as PHONE,
  CITY,
  dateGiven as DATE_GIVEN,
  VCNE.name as VACCINE_TYPE,
  Count(PI.dateOfInfection) as COUNT_OF_INFECTIONS
FROM Patient P
	LEFT JOIN PatientInfection PI ON PI.patientID = P.ID
    LEFT JOIN PatientInfection PI2 ON PI2.patientID = P.ID
	INNER JOIN Vaccination VCN ON VCN.patientID = P.ID
    INNER JOIN Vaccine VCNE ON VCNE.ID = VCN.vaccineID
WHERE
    PI2.variantID <> PI.variantID
GROUP BY
  FIRST_NAME,
  LAST_NAME,
  DOB,
  EMAIL,
  PHONE,
  CITY,
  DATE_GIVEN,
  VACCINE_TYPE
