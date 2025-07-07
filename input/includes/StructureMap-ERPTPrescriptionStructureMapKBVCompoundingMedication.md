| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `kbvMedicationCompounding.extension` | `bfarmMedication.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.extension.extVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Packaging'].extMatchVar.value` | `bfarmMedication.extension.url.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationCompounding.code` | `bfarmMedication.code` | Copies the Medication Code |
| `kbvMedicationCompounding.code.text` | `bfarmMedication.code.text` | Copies the Medication Code Text |
| `kbvMedicationCompounding.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationCompounding.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `kbvMedicationCompounding.amount.amountVar.denominator` | `bfarmMedication.amount.denominator` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.extension` | `bfarmMedication.amount.numerator.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize']` | `bfarmMedication.amount.numerator.extension.url` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar.value` | `bfarmMedication.amount.numerator.extension.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.value` | `bfarmMedication.amount.numerator.value` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.unit` | `bfarmMedication.amount.numerator.unit` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.system` | `bfarmMedication.amount.numerator.system` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.code` | `bfarmMedication.amount.numerator.code` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.item` | `bfarmMedication.ingredient.item` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.extension` | `bfarmMedication.ingredient.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.ingredient.ingredientVar.extension.IngredientExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Ingredient_Form'].IngredientExtVar.value` | `bfarmMedication.ingredient.extension.url.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.denominator` | `bfarmMedication.ingredient.strength.IngredientStrengthValueVar.denominator` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.numerator` | `bfarmMedication.ingredient.strength.IngredientStrengthValueVar.numerator` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.extension` | `bfarmMedication.ingredient.strength.IngredientStrengthValueVar.extension` | Copies the Ingredient Strength Extensions |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.extension.IngredientStrExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Ingredient_Amount'].IngredientStrExtVar.value` | `bfarmMedication.ingredient.strength.IngredientStrengthValueVar.extension.url.value` | Copies the the value for each Extension |
