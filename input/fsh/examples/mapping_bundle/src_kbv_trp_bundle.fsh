Instance: KBV-TRP-Bundle
InstanceOf: Bundle
Usage: #example
* identifier.system = "https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId"
* identifier.value = "160.100.000.000.001.39"
* meta.profile = "https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Bundle|1.4"
* entry[0].resource = 6aba4ca1-6bc9-47db-a58d-946b5ded26b7
* entry[=].fullUrl = "http://pvs.praxis.local/fhir/Composition/6aba4ca1-6bc9-47db-a58d-946b5ded26b7"
* entry[+].resource = KBV-TRP-MedicationRequest
* entry[=].fullUrl = "http://pvs.praxis.local/fhir/MedicationRequest/KBV-TRP-MedicationRequest"
* entry[+].resource = KBV-TRP-Medication
* entry[=].fullUrl = "http://pvs.praxis.local/fhir/Medication/KBV-TRP-Medication"
* entry[+].resource = 30635f5d-c233-4500-94e8-6414940236aa
* entry[=].fullUrl = "http://pvs.praxis.local/fhir/Patient/30635f5d-c233-4500-94e8-6414940236aa"
* entry[+].resource = 0c4e1a54-8a42-4d3d-a12c-0bbf2db48570
* entry[=].fullUrl = "http://pvs.praxis.local/fhir/Practitioner/0c4e1a54-8a42-4d3d-a12c-0bbf2db48570"
* entry[+].resource = 4ad4ae52-bd62-4cbd-bae9-7f7d6ece3fd2
* entry[=].fullUrl = "http://pvs.praxis.local/fhir/Organization/4ad4ae52-bd62-4cbd-bae9-7f7d6ece3fd2"
* entry[+].resource = e51239e1-ba74-48e0-97fb-9754d2b05c60
* entry[=].fullUrl = "http://pvs.praxis.local/fhir/Coverage/e51239e1-ba74-48e0-97fb-9754d2b05c60"
* type = #document
* timestamp = "2025-05-20T08:30:00Z"

Instance: 6aba4ca1-6bc9-47db-a58d-946b5ded26b7
InstanceOf: Composition
Usage: #inline
* date = "2025-05-20T08:00:00Z"
* meta.profile = "https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Composition|1.4"
* section[0].code = $KBV_CS_ERP_Section_Type#Prescription
* section[=].entry = Reference(KBV-TRP-MedicationRequest)
* section[+].code = $KBV_CS_ERP_Section_Type#Coverage
* section[=].entry = Reference(e51239e1-ba74-48e0-97fb-9754d2b05c60)
* author[0] = Reference(0c4e1a54-8a42-4d3d-a12c-0bbf2db48570)
* author[=].type = "Practitioner"
* author[+].type = "Device"
* author[=].identifier.system = "https://fhir.kbv.de/NamingSystem/KBV_NS_FOR_Pruefnummer"
* author[=].identifier.value = "Y/400/2107/36/999"
* subject = Reference(30635f5d-c233-4500-94e8-6414940236aa)
* title = "elektronische Arzneimittelverordnung"
* extension.valueCoding = $KBV_CS_SFHIR_KBV_STATUSKENNZEICHEN#00
* extension.url = "https://fhir.kbv.de/StructureDefinition/KBV_EX_FOR_Legal_basis"
* custodian = Reference(4ad4ae52-bd62-4cbd-bae9-7f7d6ece3fd2)
* type = $KBV_CS_SFHIR_KBV_FORMULAR_ART#e16A
* status = #final

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

Instance: 30635f5d-c233-4500-94e8-6414940236aa
InstanceOf: Patient
Usage: #inline
* identifier.system = "http://fhir.de/sid/gkv/kvid-10"
* identifier.value = "K220645122"
* identifier.type = $identifier-type-de-basis#KVZ10
* address.country = "D"
* address.line.extension[0].valueString = "1"
* address.line.extension[=].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[+].valueString = "Berliner Straße"
* address.line.extension[=].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.postalCode = "25813"
* address.city = "Husum"
* address.line = "Berliner Straße 1"
* address.type = #both
* meta.profile = "https://fhir.kbv.de/StructureDefinition/KBV_PR_FOR_Patient|1.2"
* name.given = "Sahra"
* name.family = "Schuhmann"
* name.family.extension.valueString = "Schuhmann"
* name.family.extension.url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name.use = #official
* birthDate = "1970-12-24"

Instance: 0c4e1a54-8a42-4d3d-a12c-0bbf2db48570
InstanceOf: Practitioner
Usage: #inline
* identifier.system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_ANR"
* identifier.value = "582369858"
* identifier.type = $v2-0203#LANR
* meta.profile = "https://fhir.kbv.de/StructureDefinition/KBV_PR_FOR_Practitioner|1.2"
* name.given = "Emilia"
* name.family = "Becker"
* name.family.extension.valueString = "Becker"
* name.family.extension.url = "http://hl7.org/fhir/StructureDefinition/humanname-own-name"
* name.use = #official
* qualification[0].code = $KBV_CS_FOR_Qualification_Type#00
* qualification[+].code.text = "Fachärztin für Psychiatrie und Psychotherapie"
* qualification[=].code = $KBV_CS_FOR_Berufsbezeichnung#Berufsbezeichnung

Instance: 4ad4ae52-bd62-4cbd-bae9-7f7d6ece3fd2
InstanceOf: Organization
Usage: #inline
* identifier.system = "https://fhir.kbv.de/NamingSystem/KBV_NS_Base_BSNR"
* identifier.value = "723333300"
* identifier.type = $v2-0203#BSNR
* address.country = "D"
* address.line.extension[0].valueString = "2"
* address.line.extension[=].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[+].valueString = "Herbert-Lewin-Platz"
* address.line.extension[=].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.postalCode = "10623"
* address.city = "Berlin"
* address.line = "Herbert-Lewin-Platz 2"
* address.type = #both
* meta.profile = "https://fhir.kbv.de/StructureDefinition/KBV_PR_FOR_Organization|1.2"
* name = "Praxis für Psychiatrie und Psychotherapie"
* telecom.system = #phone
* telecom.value = "030369258147"

Instance: e51239e1-ba74-48e0-97fb-9754d2b05c60
InstanceOf: Coverage
Usage: #inline
* payor.identifier.system = "http://fhir.de/sid/arge-ik/iknr"
* payor.identifier.value = "108018347"
* payor.display = "AOK Baden-Württember/BVG"
* meta.profile = "https://fhir.kbv.de/StructureDefinition/KBV_PR_FOR_Coverage|1.2"
* extension[0].valueCoding = $KBV_CS_SFHIR_KBV_PERSONENGRUPPE#06
* extension[=].url = "http://fhir.de/StructureDefinition/gkv/besondere-personengruppe"
* extension[+].valueCoding = $KBV_CS_SFHIR_KBV_DMP#00
* extension[=].url = "http://fhir.de/StructureDefinition/gkv/dmp-kennzeichen"
* extension[+].valueCoding = $KBV_CS_SFHIR_ITA_WOP#01
* extension[=].url = "http://fhir.de/StructureDefinition/gkv/wop"
* extension[+].valueCoding = $KBV_CS_SFHIR_KBV_VERSICHERTENSTATUS#1
* extension[=].url = "http://fhir.de/StructureDefinition/gkv/versichertenart"
* beneficiary = Reference(30635f5d-c233-4500-94e8-6414940236aa)
* type = $versicherungsart-de-basis#GKV
* status = #active