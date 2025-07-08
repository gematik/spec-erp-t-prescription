
**Titel:** E-T-Rezept Structure Map for MedicationRequest

**Beschreibung:** Maps KBV MedicationRequest BfArM T-Prescription MedicationRequest format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `kbvMedicationRequest.status` | `bfarmMedicationRequest.status` | TODO |
| `kbvMedicationRequest.intent` | `bfarmMedicationRequest.intent` | TODO |
| `kbvMedicationRequest.extension` | `bfarmMedicationRequest.extension` | Copies the MedicationRequest T-Rezept Extensions |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic]` | `bfarmMedicationRequest.extension.url` | → setzt URL 'https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Teratogenic' |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extension` | `bfarmMedicationRequest.extension.url.extension` | Copies the the value for the T-Prescription Extension |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject` | TODO |
| `kbvMedicationRequest.subject.kbvMedicationRequest.subject.kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension.url` | → setzt URL 'http://hl7.org/fhir/StructureDefinition/data-absent-reason' |
| `kbvMedicationRequest.authoredOn` | `bfarmMedicationRequest.authoredOn` | TODO |
| `kbvMedicationRequest.dosageInstruction` | `bfarmMedicationRequest.dosageInstruction` | TODO |
| `kbvMedicationRequest.dispenseRequest` | `bfarmMedicationRequest.dispenseRequest` | TODO |
| `kbvMedicationRequest.medication` | `bfarmMedicationRequest.medication` | Copy medication; ensure correct mapping from reference is stated |
