| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `kbvMedicationCompounding.extension` | `bfarmMedication.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.extension.extVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Packaging']` | `bfarmMedication.extension.tgtExtVar.url` |  |
| `kbvMedicationCompounding.extension.extVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Packaging'].extMatchVar.value` | `bfarmMedication.extension.tgtExtVar.url.tgtExtVar.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationCompounding.code` | `bfarmMedication.code` | Copies the Medication Code |
| `kbvMedicationCompounding.code.srcCodeVar.text` | `bfarmMedication.code.tgtCodeVar.text` | Copies the Medication Code Text |
| `kbvMedicationCompounding.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationCompounding.amount` | `bfarmMedication.amount` | Copies the Medication Amount |
| `kbvMedicationCompounding.amount.amountVar.denominator` | `bfarmMedication.amount.tgtAmountVar.denominator` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator` | `bfarmMedication.amount.tgtAmountVar.numerator` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.extension` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize']` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension.tgtAmountNumExtVar.url` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.extension.amountNumExtVar.value` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.extension.tgtAmountNumExtVar.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.value` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.value` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.unit` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.unit` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.system` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.system` |  |
| `kbvMedicationCompounding.amount.amountVar.numerator.amountNumeratorVar.code` | `bfarmMedication.amount.tgtAmountVar.numerator.tgtAmountNumeratorVar.code` |  |
| `kbvMedicationCompounding.ingredient` | `bfarmMedication.ingredient` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.item` | `bfarmMedication.ingredient.tgtIngredientVar.item` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.extension` | `bfarmMedication.ingredient.tgtIngredientVar.extension` | Copies the Medication Extensions |
| `kbvMedicationCompounding.ingredient.ingredientVar.extension.IngredientExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Ingredient_Form']` | `bfarmMedication.ingredient.tgtIngredientVar.extension.tgtIngredientExtVar.url` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.extension.IngredientExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Ingredient_Form'].IngredientExtVar.value` | `bfarmMedication.ingredient.tgtIngredientVar.extension.tgtIngredientExtVar.url.tgtIngredientExtVar.value` | Copies the the value for each Extension |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength` | `bfarmMedication.ingredient.tgtIngredientVar.strength` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.denominator` | `bfarmMedication.ingredient.tgtIngredientVar.strength.IngredientStrengthValueVar.denominator` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.numerator` | `bfarmMedication.ingredient.tgtIngredientVar.strength.IngredientStrengthValueVar.numerator` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.extension` | `bfarmMedication.ingredient.tgtIngredientVar.strength.IngredientStrengthValueVar.extension` | Copies the Ingredient Strength Extensions |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.extension.IngredientStrExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Ingredient_Amount']` | `bfarmMedication.ingredient.tgtIngredientVar.strength.IngredientStrengthValueVar.extension.tgtIngredientStrExtVar.url` |  |
| `kbvMedicationCompounding.ingredient.ingredientVar.strength.IngredientStrengthValueVar.extension.IngredientStrExtVar [where url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Ingredient_Amount'].IngredientStrExtVar.value` | `bfarmMedication.ingredient.tgtIngredientVar.strength.IngredientStrengthValueVar.extension.tgtIngredientStrExtVar.url.tgtIngredientStrExtVar.value` | Copies the the value for each Extension |
