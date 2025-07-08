Instance: KBV-TRP-MedicationRequest
InstanceOf: MedicationRequest
Usage: #inline
* dispenseRequest.expectedSupplyDuration.value = 3
* dispenseRequest.expectedSupplyDuration.unit = "Woche(n)"
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"
* meta.profile = "https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Prescription|1.4"
* substitution.allowedBoolean = true
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.when = #EVE
* dosageInstruction.doseAndRate.doseQuantity = 1 https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP_DOSIEREINHEIT#1 "Stück"
* dosageInstruction.extension.valueCoding = $KBV_CS_ERP_Dosage_Category#DAILY_FOUR_SCHEME
* dosageInstruction.extension.url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_DosageCategory"
* intent = #order
* insurance = Reference(e51239e1-ba74-48e0-97fb-9754d2b05c60)
* subject = Reference(30635f5d-c233-4500-94e8-6414940236aa)
* authoredOn = "2025-05-20"
* extension[0].valueCoding = $KBV_CS_FOR_StatusCoPayment#1
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_FOR_StatusCoPayment"
* extension[+].valueBoolean = false
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_EmergencyServicesFee"
* extension[+].valueBoolean = true
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_FOR_SER"
* extension[+].extension.valueBoolean = false
* extension[=].extension.url = "Kennzeichen"
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Multiple_Prescription"
* extension[+].extension[0].valueBoolean = true
* extension[=].extension[=].url = "Off-Label"
* extension[=].extension[+].valueBoolean = false
* extension[=].extension[=].url = "GebaerfaehigeFrau"
* extension[=].extension[+].valueBoolean = true
* extension[=].extension[=].url = "EinhaltungSicherheitsmassnahmen"
* extension[=].extension[+].valueBoolean = true
* extension[=].extension[=].url = "AushaendigungInformationsmaterialien"
* extension[=].extension[+].valueBoolean = true
* extension[=].extension[=].url = "ErklaerungSachkenntnis"
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Teratogenic"
* extension[+].valueBoolean = true
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_DosageFlag"
* requester = Reference(0c4e1a54-8a42-4d3d-a12c-0bbf2db48570)
* medicationReference = Reference(KBV-TRP-Medication)
* status = #active

Instance: KBV-TRP-Medication
InstanceOf: Medication
Usage: #inline
* form = $KBV_CS_SFHIR_KBV_DARREICHUNGSFORM#HKP
* ingredient.itemCodeableConcept.text = "Pomalidomid"
* ingredient.strength.denominator.value = 1
* ingredient.strength.denominator.unit = "Stück"
* ingredient.strength.numerator.value = 1
* ingredient.strength.numerator.unit = "mg"
* amount.denominator.value = 1
* amount.numerator.extension.valueString = "21"
* amount.numerator.extension.url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize"
* amount.numerator.unit = "Stück"
* extension[0].valueCodeableConcept.coding.version = "http://snomed.info/sct/11000274103/version/20240515"
* extension[=].valueCodeableConcept.coding = $sct#763158003 "Medicinal product (product)"
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_Base_Medication_Type"
* extension[+].valueCoding = $KBV_CS_ERP_Medication_Category#02
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Category"
* extension[+].valueBoolean = false
* extension[=].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Vaccine"
* extension[+].valueCode = #N1
* extension[=].url = "http://fhir.de/StructureDefinition/normgroesse"
* code.text = "Pomalidomid Accord 1 mg 21 x 1 Hartkapseln"
* code = $pzn#19201712
* meta.profile = "https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_PZN|1.4"
