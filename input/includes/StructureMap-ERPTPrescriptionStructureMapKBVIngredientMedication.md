| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `kbvMedicationIngredient.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationIngredient.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationIngredient.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `kbvMedicationIngredient.amount.amountVar.denominator` | `bfarmMedication.amount.denominator` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.extension` | `bfarmMedication.amount.numerator.extension` | Copies the Medication Extensions |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize'].amountNumExtVar.value` | `bfarmMedication.amount.numerator.extension.url.value` | Copies the the value for each Extension |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.value` | `bfarmMedication.amount.numerator.value` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.unit` | `bfarmMedication.amount.numerator.unit` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.system` | `bfarmMedication.amount.numerator.system` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.code` | `bfarmMedication.amount.numerator.code` |  |
| `kbvMedicationIngredient.ingredient` | `bfarmMedication.ingredient` | Copies the Medication Ingredient |
