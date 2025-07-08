| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `gematikMedication.id` | `bfarmMedication.id` | Copies the Medication Id |
| `gematikMedication.contained` | `bfarmMedication.contained` |  |
| `gematikMedication.extension` | `bfarmMedication.extension` | Copies the Medication Extensions |
| `gematikMedication.extension.extVar [where url='http://fhir.de/StructureDefinition/normgroesse']` | `bfarmMedication.extension.url` | Copies the 'normgroesse' extension |
| `gematikMedication.extension.extVar [where url='http://fhir.de/StructureDefinition/normgroesse'].extVar.value` | `bfarmMedication.extension.url.value` | Copies the the value for each Extension |
| `gematikMedication.extension.extVar [where url='https://gematik.de/fhir/epa-medication/StructureDefinition/medication-formulation-packaging-extension']` | `bfarmMedication.extension.url` | Copies the 'packaging' extension |
| `gematikMedication.extension.extVar [where url='https://gematik.de/fhir/epa-medication/StructureDefinition/medication-formulation-packaging-extension'].extVar.value` | `bfarmMedication.extension.url.value` | Copies the the value for each Extension |
| `gematikMedication.code` | `bfarmMedication.code` | Copies the Medication Code |
| `gematikMedication.form` | `bfarmMedication.form` | Copies the Medication Form |
| `gematikMedication.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `gematikMedication.ingredient` | `bfarmMedication.ingredient` | Copies the Medication Ingredient |
