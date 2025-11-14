Instance: KBV-TRP-MedicationRequest
InstanceOf: KBV_PR_ERP_Prescription
Usage: #inline
* meta.versionId = "1"
* extension[Notdienstgebuehr].valueBoolean = false
* extension[Zuzahlungsstatus].valueCoding = $KBV_CS_FOR_StatusCoPayment#1
* extension[SER].valueBoolean = true
* extension[Mehrfachverordnung].extension[Kennzeichen].valueBoolean = false
* extension[T-Rezept].extension[Off-Label].valueBoolean = true
* extension[T-Rezept].extension[GebaerfaehigeFrau].valueBoolean = false
* extension[T-Rezept].extension[EinhaltungSicherheitsmassnahmen].valueBoolean = true
* extension[T-Rezept].extension[AushaendigungInformationsmaterialien].valueBoolean = true
* extension[T-Rezept].extension[ErklaerungSachkenntnis].valueBoolean = true
* extension[Dosierungskennzeichen].valueBoolean = true
* extension[renderedDosageInstruction].valueMarkdown = "0-0-1-0 Stück"
* extension[generatedDosageInstructionsMeta].extension[algorithmVersion].valueString = "1.0.0"
* extension[generatedDosageInstructionsMeta].extension[language].valueCode = #de-DE
* status = #active
* intent = #order
* medicationReference = Reference(a3ca01a4-92c1-422a-87d9-ef046e94527f)
* subject = Reference(30635f5d-c233-4500-94e8-6414940236aa)
* authoredOn = "2025-05-20"
* requester = Reference(0c4e1a54-8a42-4d3d-a12c-0bbf2db48570)
* insurance = Reference(e51239e1-ba74-48e0-97fb-9754d2b05c60)
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when = #EVE
* dosageInstruction.doseAndRate.doseQuantity = 1 https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP_DOSIEREINHEIT#1 "Stück"
* dispenseRequest.quantity.value = 1
* dispenseRequest.quantity.unit = "Packung"
* dispenseRequest.expectedSupplyDuration.value = 3
* dispenseRequest.expectedSupplyDuration.unit = "Woche(n)"
* substitution.allowedBoolean = true

Instance: KBV-TRP-Medication
InstanceOf: KBV_PR_ERP_Medication_PZN
Usage: #inline
* meta.versionId = "1"
* extension[Kategorie].valueCodeableConcept.coding = $sct#763158003 "Medicinal product (product)"
* extension[Arzneimittelkategorie].valueCoding = $KBV_CS_ERP_Medication_Category#02
* extension[Impfstoff].valueBoolean = false
* extension[Normgroesse].valueCode = #N1
* code = $pzn#19201712
* code.text = "Pomalidomid Accord 1 mg 21 x 1 Hartkapseln"
* form = $KBV_CS_SFHIR_KBV_DARREICHUNGSFORM#HKP
* amount
  * numerator.extension[Packungsgroesse].valueString = "21"
  * numerator.unit = "Stück"
  * denominator.value = 1
* ingredient[+]
  * itemCodeableConcept.text = "Pomalidomid"
  * strength.numerator.value = 1
  * strength.numerator.unit = "mg"
  * strength.denominator.value = 1
  * strength.denominator.unit = "Stück"