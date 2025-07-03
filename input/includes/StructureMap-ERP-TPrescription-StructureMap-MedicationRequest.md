| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `kbvMedicationRequest.status` | `bfarmMedicationRequest.status` | TODO |
| `kbvMedicationRequest.intent` | `bfarmMedicationRequest.intent` | TODO |
| `kbvMedicationRequest.extension` | `bfarmMedicationRequest.extension` | Copies the MedicationRequest T-Rezept Extensions |
| `kbvMedicationRequest.extension.extVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Teratogenic']` | `bfarmMedicationRequest.extension.tgtExtVar.url` |  |
| `kbvMedicationRequest.extension.extVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Teratogenic'].extMatchVar.extension` | `bfarmMedicationRequest.extension.tgtExtVar.url.tgtExtVar.extension` | Copies the the value for the T-Prescription Extension |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject` | TODO |
| `kbvMedicationRequest.subject.kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.tgtSubject.extension` |  |
| `kbvMedicationRequest.subject.kbvMedicationRequest.subject.kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.tgtSubject.extension.tgtSubjectExtension.url` |  |
| `kbvMedicationRequest.authoredOn` | `bfarmMedicationRequest.authoredOn` | TODO |
| `kbvMedicationRequest.dosageInstruction` | `bfarmMedicationRequest.dosageInstruction` | TODO |
| `kbvMedicationRequest.dispenseRequest` | `bfarmMedicationRequest.dispenseRequest` | TODO |
| `kbvMedicationRequest.medication` | `bfarmMedicationRequest.medication` | Copy medication; ensure correct mapping from reference is stated |
