Instance: TRP-Carbon-Copy
InstanceOf: Parameters
Usage: #example
Title: "Beispiel digitaler Durchschlag E-T-Rezept"
Description: "Dieses Beispiel wurde manuell angelegt, um den Aufbau eines digitalen Durchschlags abzubilden"
* meta.profile = "https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-carbon-copy|1.0"
* parameter[+]
  * name = "rxPrescription"
  * part[+]
    * name = "prescriptionSignatureDate"
    * valueInstant = "2026-04-01T08:23:12Z"
  * part[+]
    * name = "prescriptionId"
    * valueIdentifier.system = "https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId"
    * valueIdentifier.value = "160.100.000.000.001.39"
  * part[+]
    * name = "medicationRequest"
    * resource = TRP-Carbon-Copy-MedicationRequest
  * part[+]
    * name = "medication"
    * resource = TRP-Carbon-Copy-Medication
* parameter[+]
  * name = "rxDispensation"
  * part[+]
    * name = "organization"
    * resource = TRP-Carbon-Copy-Organization
  * part[+]
    * name = "medicationDispense"
    * resource = TRP-Carbon-Copy-MedicationDispense
  * part[+]
    * name = "medication"
    * resource = TRP-Carbon-Copy-D-Medication

Instance: TRP-Carbon-Copy-Medication
InstanceOf: Medication
Usage: #inline
* extension.url = "http://fhir.de/StructureDefinition/normgroesse"
* extension.valueCode = #N1
* code.coding.system = "http://fhir.de/CodeSystem/ifa/pzn"
* code.coding.code = #19201712
* code.text = "Pomalidomid Accord 1 mg 21 x 1 Hartkapseln"
* form.coding.system = "https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_KBV_DARREICHUNGSFORM"
* form.coding.code = #HKP
* amount.numerator.extension.url = "https://gematik.de/fhir/epa-medication/StructureDefinition/medication-packaging-size-extension"
* amount.numerator.extension.valueString = "21"
* amount.numerator.unit = "Stück"
* amount.denominator.value = 1
* ingredient.itemCodeableConcept.text = "Pomalidomid"
* ingredient.strength.numerator.value = 1
* ingredient.strength.numerator.unit = "mg"
* ingredient.strength.denominator.value = 1
* ingredient.strength.denominator.unit = "Stück"

Instance: TRP-Carbon-Copy-D-Medication
InstanceOf: Medication
Usage: #inline
* extension.url = "http://fhir.de/StructureDefinition/normgroesse"
* extension.valueCode = #N1
* code.coding.system = "http://fhir.de/CodeSystem/ifa/pzn"
* code.coding.code = #19201712
* code.text = "Pomalidomid Accord 1 mg 21 x 1 Hartkapseln"
* form.coding.system = "https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_KBV_DARREICHUNGSFORM"
* form.coding.code = #HKP
* amount.numerator.extension.url = "https://gematik.de/fhir/epa-medication/StructureDefinition/medication-total-quantity-formulation-extension"
* amount.numerator.extension.valueString = "21"
* amount.numerator.unit = "Stück"
* amount.denominator.value = 1

Instance: TRP-Carbon-Copy-Organization
InstanceOf: Organization
Usage: #inline
* name = "Organisation 1-2arvtst-ap000053"
* telecom.system = #phone
* telecom.value = "1234"
* telecom.use = #work
* address.use = #work
* address.type = #postal
* address.text = "Schwarzwaldstr. 18&#13;&#10;63762&#13;&#10;Großostheim&#13;&#10;Bayern&#13;&#10;DE"
* address.line = "Schwarzwaldstr. 18"
* address.city = "Großostheim"
* address.state = "Bayern"
* address.postalCode = "63762"
* address.country = "DE"

Instance: TRP-Carbon-Copy-MedicationRequest
InstanceOf: MedicationRequest
Usage: #inline
* extension.extension[+]
  * url = "Off-Label"
  * valueBoolean = true
* extension.extension[+]
  * url = "GebaerfaehigeFrau"
  * valueBoolean = false
* extension.extension[+]
  * url = "EinhaltungSicherheitsmassnahmen"
  * valueBoolean = true
* extension.extension[+]
  * url = "AushaendigungInformationsmaterialien"
  * valueBoolean = true
* extension.extension[+]
  * url = "ErklaerungSachkenntnis"
  * valueBoolean = true
* extension.url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Teratogenic"
* status = #completed
* intent = #order
* medicationReference.reference = "Medication/TRP-Carbon-Copy-Medication"
* subject.extension.url = "http://hl7.org/fhir/StructureDefinition/data-absent-reason"
* subject.extension.valueCode = #not-permitted
* subject.display = "DataAbsentReason-Extension: #not-permitted, dieser Wert wird leer gelassen"
* authoredOn = "2025-05-20"
* dosageInstruction.extension.url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_DosageCategory"
* dosageInstruction.extension.valueCoding.system = "https://fhir.kbv.de/CodeSystem/KBV_CS_ERP_Dosage_Category"
* dosageInstruction.extension.valueCoding.code = #DAILY_FOUR_SCHEME
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when = #EVE
* dosageInstruction.doseAndRate.doseQuantity.value = 1
* dosageInstruction.doseAndRate.doseQuantity.code = #1
* dosageInstruction.doseAndRate.doseQuantity.system = "https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP_DOSIEREINHEIT"
* dosageInstruction.doseAndRate.doseQuantity.unit = "Stück"
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"
* dispenseRequest.expectedSupplyDuration.value = 3
* dispenseRequest.expectedSupplyDuration.unit = "Woche(n)"

Instance: TRP-Carbon-Copy-MedicationDispense
InstanceOf: MedicationDispense
Usage: #inline
* status = #completed
* medicationReference.reference = "Medication/TRP-Carbon-Copy-D-Medication"
* performer.actor.reference = "Organization/3-SMC-B-Testkarte-883110000095957"
* whenHandedOver = "2026-04-01"
