-- Give a report by city in Québec the total number of vaccines received in each
-- city between January 1st 2021 and July 22nd 2021.
-- From: COVID 19 tracking project, found in root > php > reports > q17

SELECT
  F.CITY,
  SUM(numberOfVaccinesRecieved) TOTAL_NUMBER_VACCINES_PER_CITY
FROM
  Province P
  INNER JOIN Facility F ON F.provinceID = P.ID
  INNER JOIN Shipment S ON S.facilityID = F.ID
WHERE
  provinceID = 1 AND
  dateOfReception BETWEEN '2021-01-01' AND '2021-07-22'
GROUP BY CITY
ORDER BY
	CITY ASC, TOTAL_NUMBER_VACCINES_PER_CITY DESC
