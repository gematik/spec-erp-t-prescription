Instance: aea2f4c5-675a-4d76-ab9b-7994c80b64ec
InstanceOf: KBV_PR_ERP_Bundle
Usage: #example
* meta.versionId = "1"
* identifier.system = "https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId"
* identifier.value = "160.100.000.000.001.39"
* type = #document
* timestamp = "2025-05-20T08:30:00+00:00"
* entry[0].fullUrl = "http://pvs.praxis.local/fhir/Composition/6aba4ca1-6bc9-47db-a58d-946b5ded26b7"
* entry[=].resource = 6aba4ca1-6bc9-47db-a58d-946b5ded26b7
* entry[+].fullUrl = "http://pvs.praxis.local/fhir/MedicationRequest/7d871b93-e18c-4865-bad0-6b55196be46b"
* entry[=].resource = 7d871b93-e18c-4865-bad0-6b55196be46b
* entry[+].fullUrl = "http://pvs.praxis.local/fhir/Medication/a3ca01a4-92c1-422a-87d9-ef046e94527f"
* entry[=].resource = a3ca01a4-92c1-422a-87d9-ef046e94527f
* entry[+].fullUrl = "http://pvs.praxis.local/fhir/Patient/30635f5d-c233-4500-94e8-6414940236aa"
* entry[=].resource = 30635f5d-c233-4500-94e8-6414940236aa
* entry[+].fullUrl = "http://pvs.praxis.local/fhir/Practitioner/0c4e1a54-8a42-4d3d-a12c-0bbf2db48570"
* entry[=].resource = 0c4e1a54-8a42-4d3d-a12c-0bbf2db48570
* entry[+].fullUrl = "http://pvs.praxis.local/fhir/Organization/4ad4ae52-bd62-4cbd-bae9-7f7d6ece3fd2"
* entry[=].resource = 4ad4ae52-bd62-4cbd-bae9-7f7d6ece3fd2
* entry[+].fullUrl = "http://pvs.praxis.local/fhir/Coverage/e51239e1-ba74-48e0-97fb-9754d2b05c60"
* entry[=].resource = e51239e1-ba74-48e0-97fb-9754d2b05c60

Instance: 6aba4ca1-6bc9-47db-a58d-946b5ded26b7
InstanceOf: KBV_PR_ERP_Composition
Usage: #inline
* meta.versionId = "1"
* extension[+].url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_FOR_Legal_basis"
* extension[=].valueCoding = $KBV_CS_SFHIR_KBV_STATUSKENNZEICHEN#00
* status = #final
* type = $KBV_CS_SFHIR_KBV_FORMULAR_ART#e16A
* subject = Reference(30635f5d-c233-4500-94e8-6414940236aa)
* date = "2025-05-20T08:00:00Z"
* author[Arzt] = Reference(0c4e1a54-8a42-4d3d-a12c-0bbf2db48570)
* author[Pruefnummer].identifier.system = "https://fhir.kbv.de/NamingSystem/KBV_NS_FOR_Pruefnummer"
* author[Pruefnummer].identifier.value = "Y/400/2107/36/999"
* title = "elektronische Arzneimittelverordnung"
* custodian = Reference(4ad4ae52-bd62-4cbd-bae9-7f7d6ece3fd2)
* section[Verordnung_Arzneimittel].entry = Reference(7d871b93-e18c-4865-bad0-6b55196be46b)
* section[Krankenversicherungsverhaeltnis].entry = Reference(e51239e1-ba74-48e0-97fb-9754d2b05c60)

Instance: 7d871b93-e18c-4865-bad0-6b55196be46b
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

Instance: a3ca01a4-92c1-422a-87d9-ef046e94527f
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

Instance: 30635f5d-c233-4500-94e8-6414940236aa
InstanceOf: KBV_PR_FOR_Patient
Usage: #inline
* meta.versionId = "1"
* identifier[versichertenId].value = "K220645122"
* name[name]
  * family = "Schuhmann"
  * family.extension[nachname].valueString = "Schuhmann"
  * given = "Sahra"
* birthDate = "1970-12-24"
* address[Strassenanschrift]
  * line[+] = "Berliner Straße 1"
  * line[=].extension[Hausnummer].valueString = "1"
  * line[=].extension[Strasse].valueString = "Berliner Straße"
  * city = "Husum"
  * postalCode = "25813"
  * country = "D"

Instance: 0c4e1a54-8a42-4d3d-a12c-0bbf2db48570
InstanceOf: KBV_PR_FOR_Practitioner
Usage: #inline
* meta.versionId = "1"
* identifier[ANR].value = "582369858"
* name[name]
  * family = "Becker"
  * family.extension[nachname].valueString = "Becker"
  * given = "Emilia"
* qualification[Typ].code = $KBV_CS_FOR_Qualification_Type#00
* qualification[Berufsbezeichnung].code = $KBV_CS_FOR_Berufsbezeichnung#Berufsbezeichnung
* qualification[Berufsbezeichnung].code.text = "Fachärztin für Psychiatrie und Psychotherapie"

Instance: 4ad4ae52-bd62-4cbd-bae9-7f7d6ece3fd2
InstanceOf: KBV_PR_FOR_Organization
Usage: #inline
* meta.versionId = "1"
* identifier[Betriebsstaettennummer].value = "723333300"
* name = "Praxis für Psychiatrie und Psychotherapie"
* telecom[telefon].value = "030369258147"
* address[Strassenanschrift]
  * line[+] = "Herbert-Lewin-Platz 2"
  * line[=].extension[Hausnummer].valueString = "2"
  * line[=].extension[Strasse].valueString = "Herbert-Lewin-Platz"
  * city = "Berlin"
  * postalCode = "10623"
  * country = "D"

Instance: e51239e1-ba74-48e0-97fb-9754d2b05c60
InstanceOf: KBV_PR_FOR_Coverage
Usage: #inline
* meta.versionId = "1"
* extension[BesonderePersonengruppe].valueCoding = $KBV_CS_SFHIR_KBV_PERSONENGRUPPE#06
* extension[DMPKennzeichen].valueCoding = $KBV_CS_SFHIR_KBV_DMP#00
* extension[wop].valueCoding = $KBV_CS_SFHIR_ITA_WOP#01
* extension[versichertenart].valueCoding = $KBV_CS_SFHIR_KBV_VERSICHERTENSTATUS#1
* status = #active
* type = $versicherungsart-de-basis#GKV
* beneficiary = Reference(30635f5d-c233-4500-94e8-6414940236aa)
* payor.identifier.system = "http://fhir.de/sid/arge-ik/iknr"
* payor.identifier.value = "108018347"
* payor.display = "AOK Baden-Württember/BVG"
