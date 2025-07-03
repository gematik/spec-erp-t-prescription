| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `kbvMedicationPZN.extension` | `bfarmMedication.extension` | Copies the Medication Extensions |
| `kbvMedicationPZN.extension.extVar [where url='http://fhir.de/StructureDefinition/normgroesse']` | `bfarmMedication.extension.tgtExtVar.url` | Copies the 'normgroesse' extension and sets its URL to 'normgroesseNEW' in the target |
| `kbvMedicationPZN.extension.extVar [where url='http://fhir.de/StructureDefinition/normgroesse'].extVar.value` | `bfarmMedication.extension.tgtExtVar.url.tgtExtVar.value` | Copies the the value for each Extension |
| `kbvMedicationPZN.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationPZN.code` | `bfarmMedication.code` | Copies the Medication Code |
| `kbvMedicationPZN.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationPZN.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `kbvMedicationPZN.amount.amountVar.denominator` | `bfarmMedication.amount.tgtAmountVar.denominator` |  |
| `kbvMedicationPZN.amount.amountVar.numerator` | `bfarmMedication.amount.tgtAmountVar.numerator` |  |
| `kbvMedicationPZN.amount.amountVar.numerator.amountNumeratorVar.extension` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension` | Copies the Medication Extensions |
| `kbvMedicationPZN.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize']` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension.tgtAmountNumExtVar.url` |  |
| `kbvMedicationPZN.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize'].amountNumExtVar.value` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension.tgtAmountNumExtVar.url.tgtAmountNumExtVar.value` | Copies the the value for each Extension |
| `kbvMedicationPZN.amount.amountVar.numerator.amountNumeratorVar.value` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.value` |  |
| `kbvMedicationPZN.amount.amountVar.numerator.amountNumeratorVar.unit` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.unit` |  |
| `kbvMedicationPZN.amount.amountVar.numerator.amountNumeratorVar.system` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.system` |  |
| `kbvMedicationPZN.amount.amountVar.numerator.amountNumeratorVar.code` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.code` |  |
| `kbvMedicationPZN.ingredient` | `bfarmMedication.ingredient` | Copies the Medication Ingredient |
