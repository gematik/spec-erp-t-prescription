Instance: TaskInClosedState
InstanceOf: GEM_ERP_PR_Task
Title: "Task im status 'completed'"
Description: "Dieses Beispiel bildet den Status für einen Task ab, an dem eine Apotheke den Workflow via Aufruf der $close-Operation abgeschlossen hat"
Usage: #inline
* extension[flowType].url = "https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_EX_PrescriptionType"
* extension[flowType].valueCoding = https://gematik.de/fhir/erp/CodeSystem/GEM_ERP_CS_FlowType#166 "Flowtype für Arzneimittel nach § 3a AMVV"
* extension[acceptDate].url = "https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_EX_AcceptDate"
* insert Date(extension[acceptDate].valueDate)
* extension[expiryDate].url = "https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_EX_ExpiryDate"
* insert Date(extension[expiryDate].valueDate)
* identifier[PrescriptionID].system = "https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId"
* identifier[PrescriptionID].value = "160.100.000.000.001.39"
* identifier[AccessCode].system = "https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_AccessCode"
* identifier[AccessCode].value = "777bea0e13cc9c42ceec14aec3ddee2263325dc2c6c699db115f58fe423607ea"
* status = #completed
* intent = #order
* insert DateTime(authoredOn)
* performerType[+].coding = https://gematik.de/fhir/erp/CodeSystem/GEM_ERP_CS_OrganizationType#urn:oid:1.2.276.0.76.4.54 "Öffentliche Apotheke"
* for.identifier.system = $identifier-kvid-10
* for.identifier.value = "X123456789"
* insert DateTimeStampPlus1Hr(lastModified)
* input[ePrescription].type.coding = https://gematik.de/fhir/erp/CodeSystem/GEM_ERP_CS_DocumentType#1 "Health Care Provider Prescription"
* input[ePrescription].valueReference.reference = "281a985c-f25b-4aae-91a6-41ad744080b0"
* input[patientReceipt].type.coding = https://gematik.de/fhir/erp/CodeSystem/GEM_ERP_CS_DocumentType#2 "Patient Confirmation"
* input[patientReceipt].valueReference.reference = "f8c2298f-7c00-4a68-af29-8a2862d55d43"
* output[receipt].type.coding = https://gematik.de/fhir/erp/CodeSystem/GEM_ERP_CS_DocumentType#3 "Receipt"
* output[receipt].valueReference.reference = "dffbfd6a-5712-4798-bdc8-07201eb77ab8"
