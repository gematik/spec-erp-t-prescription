Instance: Example-T-Prescription-CC-Post
InstanceOf: ERP_TPrescription_CarbonCopy
Usage: #example

* parameter[rxPrescription]
  * part[prescriptionSignatureDate].valueInstant = "2026-04-01T12:43:23Z"
  * part[prescriptionId]
    * name = "prescriptionId"
    * valueIdentifier
      * system = "https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId"
      * value = "160.153.303.257.459"
  * part[medicationRequest].resource = ExampleMedicationRequest-T
  * part[medication].resource = ExampleMedication1-Paracetamol-T

* parameter[rxDispensation]
  * part[medicationDispense].resource = ExampleMedicationDispense-T
  * part[medication].resource = ExampleMedication2-Ibuprofen-T
  * part[organization].resource = ExampleOrganization-T