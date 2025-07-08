
**Titel:** E-T-Rezept Structure Map for Medication

**Beschreibung:** Maps GEM ERP Medication to BfArM T-Prescription Medication format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `gematikMedication.id` | `bfarmMedication.id` | Copies the Medication Id |
| `gematikMedication.extension` | `bfarmMedication.extension` | Copies the Medication Extensions |
| `gematikMedication.extension [normgroesse]` | `bfarmMedication.extension.url` | Copies the 'normgroesse' extension<br>→ setzt URL 'http://fhir.de/StructureDefinition/normgroesse' |
| `gematikMedication.extension [normgroesse].value` | `bfarmMedication.extension.url.value` | Copies the the value for each Extension |
| `gematikMedication.extension [medication-formulation-packaging-extension]` | `bfarmMedication.extension.url` | Copies the 'packaging' extension<br>→ setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/medication-formulation-packaging-extension' |
| `gematikMedication.extension [medication-formulation-packaging-extension].value` | `bfarmMedication.extension.url.value` | Copies the the value for each Extension |
| `gematikMedication.code` | `bfarmMedication.code` | Copies the Medication Code |
| `gematikMedication.form` | `bfarmMedication.form` | Copies the Medication Form |
| `gematikMedication.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `gematikMedication.ingredient` | `bfarmMedication.ingredient` | Copies the Medication Ingredient |
