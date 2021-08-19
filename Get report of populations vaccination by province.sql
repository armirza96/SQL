-- Give a report of the population’s vaccination by province between January 1st
-- 2021 and July 22nd 2021. The report should include for each province and for
-- each type of vaccine, the total number of people using the type of vaccine. If a
-- person have been vaccinated with Pfizer twice then the person will be counted
-- only once for Pfizer. But if a person have been vaccinated one dose for Pfizer and
-- one dose for Moderna then the person is counted once for each type.
-- From: COVID 19 tracking project, found in root > php > reports > q16

SELECT
  P.Name PROVINCE_NAME,
  V.Name VACCINE_NAME,
  COUNT(distinct VCN.patientID) TOTAL_NUMBER_VACCINATIONS_GIVEN
FROM
  Province P
  INNER JOIN Facility F ON F.provinceID = P.ID
  INNER JOIN Inventory I ON I.facilityID = F.ID
  INNER JOIN Vaccine V on V.ID = I.vaccineID
  INNER JOIN Vaccination VCN ON VCN.vaccineID = V.ID
WHERE
  dateGiven BETWEEN '2021-01-01' AND '2021-07-22'
GROUP BY PROVINCE_NAME, VACCINE_NAME
ORDER BY
	PROVINCE_NAME ASC, TOTAL_NUMBER_VACCINATIONS_GIVEN DESC
