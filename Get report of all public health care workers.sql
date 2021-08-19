-- Give a list of all public health workers in a specific facility (EmployeeID,
-- Social Security Number (SSN), first-name, last-name, date of birth, medicare card
-- number, telephone-number, address, city, province, postal-code, citizenship, email
-- address, and history of employment).
-- From: COVID 19 tracking project, found in root > php > reports > q19

SELECT
	E.ID,
	E.SSN,
	E.firstName FIRST_NAME,
	E.lastName LAST_NAME,
	E.dateOfBirth DOB,
	E.medicareNumber MEDICARE_NUMBER,
	E.telephone PHONE,
  E.ADDRESS,
  E.CITY,
  P.NAME,
	E.postal_code POSTAL_CODE,
	E.citizenship CITIZEN,
	E.EMAIL,
	CONCAT(F.NAME, ', Employment Record: ', ER.startDate, ' - ', coalesce(ER.endDate,'')) EMP_RECORD
FROM
	Employee E
	INNER JOIN EmploymentRecord ER ON ER.employeeID = E.ID
	INNER JOIN Facility F ON F.ID = ER.facilityID
	INNER JOIN Province P ON P.ID = E.provinceID
WHERE
  F.ID = 1
GROUP BY
  	E.ID,
	E.SSN,
	E.firstName,
	E.lastName,
	E.dateOfBirth,
	E.medicareNumber,
	E.telephone,
	E.ADDRESS,
	E.CITY,
	P.NAME,
	E.postal_code,
	E.citizenship,
	E.EMAIL
