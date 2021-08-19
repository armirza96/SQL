-- Give a list of all public health workers in Québec who never been vaccinated
-- or who have been vaccinated only one dose for Covid-19 (EmployeeID, firstname, last-name, date of birth, telephone-number, city, email address, locations
-- name where the employee work).
-- From: COVID 19 tracking project, found in root > php > reports > q20

SELECT
	E.ID,
	E.firstName FIRST_NAME,
	E.lastName LAST_NAME,
	E.dateOfBirth DOB,
	E.telephone PHONE,
    E.CITY,
	E.EMAIL,
	F.NAME LOCATION_NAME
FROM
	Employee E
	INNER JOIN EmploymentRecord ER ON ER.employeeID = E.ID
    INNER JOIN Patient P ON P.medicareNumber = E.medicareNumber
	INNER JOIN Vaccination V ON V.patientID = P.ID
    INNER JOIN Facility F ON F.ID = ER.facilityID
WHERE
  E.provinceID = 1
GROUP BY
  F.NAME,
  F.ADDRESS,
  F.TYPE,
  PHONE
Having COUNT(dateGiven) < 2
