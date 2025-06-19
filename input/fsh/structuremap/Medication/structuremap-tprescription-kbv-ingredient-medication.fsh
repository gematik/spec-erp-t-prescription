Instance: ERP-TPrescription-StructureMap-KBV-Ingredient-Medication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for KBV Ingredient Medication"
Description: "Maps KBV-Ingredient ERP Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-KBV-Ingredient-Medication)

* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_Ingredient, source, kbvMedicationIngredient)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-medication, target, bfarmMedication)

* group[+]
  * name = "KBVIngredientMedicationMapping"
  * typeMode = #none
  * documentation = "Mapping group for medication information transformation"

  * insert sd_input(kbvMedicationIngredient, source)
  * insert sd_input(bfarmMedication, target)

  // form
  * rule[+]
    * name = "medicationForm"
    * insert treeSource(kbvMedicationIngredient, form, formVar)
    * insert targetCopyVariable(bfarmMedication, form, formVar)
    * documentation = "Copies the Medication Form"
  
  // amount
  * rule[+]
    * name = "medicationAmount"
    * insert treeSource(kbvMedicationIngredient, amount, amountVar)
    * insert targetCopyVariable(bfarmMedication, amount, amountVar)
    * documentation = "Copies the Medication Amount"
  
  // ingredient
  * rule[+]
    * name = "medicationIngredient"
    * insert treeSource(kbvMedicationIngredient, ingredient, ingredientVar)
    * insert targetCopyVariable(bfarmMedication, ingredient, ingredientVar)
    * documentation = "Copies the Medication Ingredient"
  