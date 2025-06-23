Profile: ERP_TPrescription_Medication
Parent: EPAMedication
Id: erp-tprescription-medication
Title: "E-T-Rezept Medication"
Description: "Medication for BfArM T-Register"
* insert Profile(erp-tprescription-medication)

* extension[rxPrescriptionProcessIdentifier] 0..0
* extension[isVaccine] 0..0
* extension[drugCategory] 0..0
* extension[manufacturingInstructions] 0..0
* extension[type] 0..0

* identifier 0..0
* status 0..0
* manufacturer 0..0
* batch 0..0

