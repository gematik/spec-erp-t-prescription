
**Titel:** E-T-Rezept Structure Map for KBV Ingredient Medication

**Beschreibung:** Maps KBV-Ingredient ERP Medication to BfArM T-Prescription Medication format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `kbvMedicationIngredient.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationIngredient.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationIngredient.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `kbvMedicationIngredient.amount.numerator.extension` | `bfarmMedication.amount.numerator.extension` | Copies the Medication Extensions |
| `kbvMedicationIngredient.amount.numerator.extension [KBV_EX_ERP_Medication_PackagingSize]` | `bfarmMedication.amount.numerator.extension.url` | → setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/medication-packaging-size-extension' |
| `kbvMedicationIngredient.amount.numerator.extension [KBV_EX_ERP_Medication_PackagingSize].value` | `bfarmMedication.amount.numerator.extension.url.value` | Copies the the value for each Extension |
| `kbvMedicationIngredient.ingredient` | `bfarmMedication.ingredient` | Copies the Medication Ingredient |
