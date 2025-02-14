SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions REGEXP '(\\s|^)DIAB1[0-9]*($|\\s)';
