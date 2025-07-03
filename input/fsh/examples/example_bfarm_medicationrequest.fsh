Instance: ExampleMedicationRequest-T
InstanceOf: ERP_TPrescription_MedicationRequest
Title: "Example MedicationRequest"
Description: "A MedicationRequest for Paracetamol"
* status = #completed
* intent = #order
* authoredOn = "2026-04-01"
* subject.extension[dataAbsentReason].valueCode = #not-permitted
* medicationReference = Reference(ExampleMedication1-Paracetamol-T)
* dosageInstruction[+].text = "1-1-1-1"
* dispenseRequest
  * quantity.value = 10
  * quantity.unit = "Tablette"
* extension[T-Rezept]
  * extension[EinhaltungSicherheitsmassnahmen].valueBoolean = true
  * extension[AushaendigungInformationsmaterialien].valueBoolean = true
  * extension[Off-Label].valueBoolean = false
  * extension[GebaerfaehigeFrau].valueBoolean = false
  * extension[ErklaerungSachkenntnis].valueBoolean = true

Instance: ExampleMedication1-Paracetamol-T
InstanceOf: ERP_TPrescription_Medication
Title: "Example Medication - Paracetamol"
Description: "Paracetamol 500 mg Tabletten"
* code.coding[+]
  * system = "http://www.whocc.no/atc"
  * code = #N02BE01
  * display = "Paracetamol"
* code.text = "Paracetamol 500 mg Tabletten"
* form.coding[+]
  * system = $KBV_CS_SFHIR_KBV_DARREICHUNGSFORM
  * code = #TAB
  * display = "Tabletten"
