Instance: ERP-TPrescription-StructureMap
InstanceOf: StructureMap
Usage: #example
Title: "E-T-Rezept Structure Map"
Description: "Maps KBV ERP Prescription, GEM ERP CloseOperation Input, and Directory resources to BfArM T-Prescription format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap)

// Structures to be used
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Bundle, source, kbvBundle)
* insert sd_structure(urn:oid:1.2.840.113549.1.7, source, pkcs7)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Prescription, source, kbvPrescription)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_PZN, source, kbvMedicationPZN)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_Ingredient, source, kbvMedicationIngredient)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_FreeText, source, kbvMedicationFreeText)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_Compounding, source, kbvMedicationCompounding)
* insert sd_structure(https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_Medication, source, gematikMedication)
* insert sd_structure(https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_MedicationDispense, source, gematikMedicationDispense)
* insert sd_structure(https://gematik.de/fhir/directory/StructureDefinition/OrganizationDirectory, source, OrganizationDirectory)
* insert sd_structure(https://gematik.de/fhir/directory/StructureDefinition/LocationDirectory, source, LocationDirectory)
* insert sd_structure(https://gematik.de/fhir/directory/StructureDefinition/HealthcareServiceDirectory, source, HealthcareServiceDirectory)
* insert sd_structure(https://gematik.de/fhir/bfarm/StructureDefinition/erp-tprescription-carbon-copy, target, erpTCarbonCopy)
* insert sd_structure(https://gematik.de/fhir/bfarm/StructureDefinition/erp-tprescription-medication, target, bfarmPrescribedMedication)
* insert sd_structure(https://gematik.de/fhir/bfarm/StructureDefinition/erp-tprescription-medication, target, bfarmDispensedMedication)
* insert sd_structure(https://gematik.de/fhir/bfarm/StructureDefinition/erp-tprescription-medication-request, target, bfarmMedicationRequest)
* insert sd_structure(https://gematik.de/fhir/bfarm/StructureDefinition/erp-tprescription-medication-dispense, target, bfarmMedicationDispense)
* insert sd_structure(https://gematik.de/fhir/bfarm/StructureDefinition/erp-tprescription-organization, target, bfarmOrganization)

* insert trezept-structuremap-prescription
* insert trezept-structuremap-dispense
* insert trezept-structuremap-organization
