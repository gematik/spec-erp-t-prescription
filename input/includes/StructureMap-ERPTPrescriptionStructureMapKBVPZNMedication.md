
**Titel:** E-T-Rezept Structure Map for KBV PZN Medication

**Beschreibung:** Maps KBV-PZN ERP Medication to BfArM T-Prescription Medication format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `kbvMedicationPZN.extension` | `bfarmMedication.extension` | Copies the Medication Extensions |
| `kbvMedicationPZN.extension [normgroesse]` | `bfarmMedication.extension.url` | Copies the 'normgroesse' extension and sets its URL to 'normgroesseNEW' in the target<br>→ setzt URL 'http://fhir.de/StructureDefinition/normgroesse' |
| `kbvMedicationPZN.extension [normgroesse].value` | `bfarmMedication.extension.url.value` | Copies the the value for each Extension |
| `kbvMedicationPZN.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationPZN.code` | `bfarmMedication.code` | Copies the Medication Code |
| `kbvMedicationPZN.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationPZN.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `kbvMedicationPZN.amount.numerator.extension` | `bfarmMedication.amount.numerator.extension` | Copies the Medication Extensions |
| `kbvMedicationPZN.amount.numerator.extension [KBV_EX_ERP_Medication_PackagingSize]` | `bfarmMedication.amount.numerator.extension.url` | → setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/medication-packaging-size-extension' |
| `kbvMedicationPZN.amount.numerator.extension [KBV_EX_ERP_Medication_PackagingSize].value` | `bfarmMedication.amount.numerator.extension.url.value` | Copies the the value for each Extension |
| `kbvMedicationPZN.ingredient` | `bfarmMedication.ingredient` | Copies the Medication Ingredient |
