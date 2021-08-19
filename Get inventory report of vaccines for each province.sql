-- Give a report of the inventory of vaccines in each province. The report should
-- include for each province and for each type of vaccine, the total number of
-- vaccines available in the province. The report should be displayed in ascending
-- order by province then by descending order of number of vaccines in the inventory
-- From: COVID 19 tracking project, found in root > php > reports > q15

SELECT
  P.Name PROVINCE_NAME,
  SUM(numberOfVaccinesAvailable) TOTAL_NUMBER_VACCINES_AVAILABLE,
  V.Name VACCINE_NAME
FROM
  Province P
  INNER JOIN Facility F ON F.provinceID = P.ID
  INNER JOIN Inventory I ON I.facilityID = F.ID
  INNER JOIN Vaccine V on V.ID = I.vaccineID
GROUP BY P.Name, V.Name
ORDER BY
	PROVINCE_NAME ASC, TOTAL_NUMBER_VACCINES_AVAILABLE DESC
