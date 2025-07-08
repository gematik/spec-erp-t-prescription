Instance: GEM-MedicationDispense
InstanceOf: GEM_ERP_PR_MedicationDispense
Usage: #example
Title: "Example Medication Dispense"
Description: "Example of a Medication Dispense."
* identifier[prescriptionID].value = "160.100.000.000.001.39"
* subject.identifier.system = $identifier-kvid-10
* subject.identifier.value = "X123456789"
* performer.actor.identifier.system = $identifier-telematik-id
* performer.actor.identifier.value = "3-SMC-B-Testkarte-883110000095957"
* insert Date(whenHandedOver)
* medicationReference = Reference(PomalidomidMedication)

// Medication
Instance: PomalidomidMedication
InstanceOf: GEM_ERP_PR_Medication
Title:   "Sample Medication Pomalidomid"
Usage: #example
// Arzneimittelkategorie
* extension[drugCategory].valueCoding = https://gematik.de/fhir/epa-medication/CodeSystem/epa-drug-category-cs#02

// Impfstoff
* extension[isVaccine].valueBoolean = false

// ChargenInformation
* batch.lotNumber = "1234567890"

// normgroesse
* extension[normSizeCode].url = "http://fhir.de/StructureDefinition/normgroesse"
* extension[normSizeCode].valueCode = #N1
* code.coding[pzn].system = "http://fhir.de/CodeSystem/ifa/pzn"
* code.coding[pzn].code = #19201712
* code.text = "Pomalidomid Accord 1 mg 21 x 1 Hartkapseln"
* form.coding[kbvDarreichungsform].system = "https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_KBV_DARREICHUNGSFORM"
* form.coding[kbvDarreichungsform].code = #HKP
* amount.numerator.extension[totalQuantity].valueString = "21"
* amount.numerator.unit = "Stück"
* amount.denominator.value = 1
