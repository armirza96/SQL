-- Give a detailed report of all the facilities in the city of Montréal. The report
-- should include the name, address, type and phone number of the facility, the total
-- number of public health workers working in the facility, the total number of
-- shipments of vaccines received by the facility, the total number of doses received
-- by the facility, the total number of transfer of vaccines from the facility and
-- transfer to the facility, the total number of doses transferred from the facility, the
-- total number of doses transferred to the facility, the total number of vaccines of
-- each type in the facility, the number of people vaccinated in the facility, and the
-- number of doses people have received in the facility. 
-- From: COVID 19 tracking project, found in root > php > reports > q18

SELECT
*,
(TOTAL_NUMBER_OF_TRANSERS_TO + TOTAL_NUMBER_OF_TRANSERS_FROM) TOTAL_NUMBER_OF_TRANSERS
FROM (
	SELECT
	  F.NAME,
	  F.ADDRESS,
	  F.TYPE,
	  F.Telephone PHONE,
	  COUNT(distinct ER.ID) TOTAL_HEALTH_CARE_WORKERS_EMPLOYED,
	  COUNT(distinct S.ID) TOTAL_NUMBER_OF_SHIPMENTS,
	  SUM(distinct S.numberOfVaccinesRecieved) TOTAL_NUMBER_OF_VACCINES_RECEIVED,
	  SUM(distinct T.numberOfVaccinesTransfered) TOTAL_NUMBER_OF_TRANSERS_FROM,
	  SUM(distinct T2.numberOfVaccinesTransfered) TOTAL_NUMBER_OF_TRANSERS_TO,
	  COUNT(DISTINCT V.NAME) TOTAL_VACCINE_TYPES,
	  COUNT(DISTINCT VCN.patientID) TOTAL_NUMBER_OF_PEOPLE_VACCINATED,
	  COUNT(distinct VCN.patientID) TOTAL_NUMBER_OF_DOSES_GIVEN
	FROM
	  Facility F
	  LEFT JOIN Shipment S ON S.facilityID = F.ID
	  LEFT JOIN EmploymentRecord ER ON ER.facilityID = F.ID
	  LEFT JOIN Transfer T ON T.fromfacilityID = F.ID
	  LEFT JOIN Transfer T2 ON T2.tofacilityID = F.ID
	  LEFT JOIN Vaccine V ON V.ID = S.vaccineID
	  LEFT JOIN Vaccination VCN ON VCN.facilityID = F.ID AND VCN.vaccineID = V.ID
	WHERE
	  F.CITY = 'Montreal'
	GROUP BY
	  F.NAME,
	  F.ADDRESS,
	  F.TYPE,
	  PHONE
) t1
