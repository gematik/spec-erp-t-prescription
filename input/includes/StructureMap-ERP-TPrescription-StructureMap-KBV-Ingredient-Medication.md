| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `kbvMedicationIngredient.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationIngredient.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationIngredient.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `kbvMedicationIngredient.amount.amountVar.denominator` | `bfarmMedication.amount.tgtAmountVar.denominator` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator` | `bfarmMedication.amount.tgtAmountVar.numerator` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.extension` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension` | Copies the Medication Extensions |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize']` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension.tgtAmountNumExtVar.url` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize'].amountNumExtVar.value` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension.tgtAmountNumExtVar.url.tgtAmountNumExtVar.value` | Copies the the value for each Extension |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.value` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.value` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.unit` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.unit` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.system` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.system` |  |
| `kbvMedicationIngredient.amount.amountVar.numerator.amountNumeratorVar.code` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.code` |  |
| `kbvMedicationIngredient.ingredient` | `bfarmMedication.ingredient` | Copies the Medication Ingredient |
