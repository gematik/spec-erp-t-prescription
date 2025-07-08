
**Titel:** E-T-Rezept Structure Map for KBV Compounding Medication

**Beschreibung:** Maps KBV-Compounding ERP Medication to BfArM T-Prescription Medication format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `kbvMedicationCompounding.extension` | `bfarmMedication.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.extension [KBV_EX_ERP_Medication_Packaging]` | `bfarmMedication.extension.url` | → setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/medication-formulation-packaging-extension' |
| `kbvMedicationCompounding.extension [KBV_EX_ERP_Medication_Packaging].value` | `bfarmMedication.extension.url.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationCompounding.code` | `bfarmMedication.code` | Copies the Medication Code |
| `kbvMedicationCompounding.code.text` | `bfarmMedication.code.text` | Copies the Medication Code Text |
| `kbvMedicationCompounding.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationCompounding.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `kbvMedicationCompounding.amount.numerator.extension` | `bfarmMedication.amount.numerator.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.amount.numerator.extension [KBV_EX_ERP_Medication_PackagingSize]` | `bfarmMedication.amount.numerator.extension.url` | → setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/medication-packaging-size-extension' |
| `kbvMedicationCompounding.amount.numerator.extension.value` | `bfarmMedication.amount.numerator.extension.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.ingredient.extension` | `bfarmMedication.ingredient.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.ingredient.extension [KBV_EX_ERP_Medication_Ingredient_Form]` | `bfarmMedication.ingredient.extension.url` | → setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/medication-ingredient-darreichungsform-extension' |
| `kbvMedicationCompounding.ingredient.extension [KBV_EX_ERP_Medication_Ingredient_Form].value` | `bfarmMedication.ingredient.extension.url.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.ingredient.strength.extension` | `bfarmMedication.ingredient.strength.extension` | Copies the Ingredient Strength Extensions |
| `kbvMedicationCompounding.ingredient.strength.extension [KBV_EX_ERP_Medication_Ingredient_Amount]` | `bfarmMedication.ingredient.strength.extension.url` | → setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/medication-ingredient-amount-extension' |
| `kbvMedicationCompounding.ingredient.strength.extension [KBV_EX_ERP_Medication_Ingredient_Amount].value` | `bfarmMedication.ingredient.strength.extension.url.value` | Copies the the value for each Extension |
