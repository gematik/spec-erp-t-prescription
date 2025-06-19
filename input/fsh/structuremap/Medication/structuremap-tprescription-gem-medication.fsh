Instance: ERP-TPrescription-StructureMap-GEM-Medication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for Medication"
Description: "Maps GEM ERP Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-GEM-Medication)

* insert sd_structure(https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_Medication, source, gematikMedication)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_PZN, source, kbvMedicationPZN)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_Ingredient, source, kbvMedicationIngredient)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_FreeText, source, kbvMedicationFreeText)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_Compounding, source, kbvMedicationCompounding)

* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-medication, target, bfarmMedication)
/* TODO
  * insert sd_input(kbvMedicationPZN, source)
  * insert sd_input(kbvMedicationIngredient, source)
  * insert sd_input(kbvMedicationCompounding, source)
*/

* group[+]
  * name = "GemMedicationMapping"
  * typeMode = #none
  * documentation = "Mapping group for medication information transformation"

  * insert sd_input(gematikMedication, source)
  * insert sd_input(bfarmMedication, target)

  // code
  * rule[+]
    * name = "medicationCode"
    * insert treeSource(gematikMedication, code, codeVar)
    * insert targetCopyVariable(bfarmMedication, code, codeVar)
    * documentation = "Copies the Medication Code"
  

  // form
  * rule[+]
    * name = "medicationForm"
    * insert treeSource(gematikMedication, form, formVar)
    * insert targetCopyVariable(bfarmMedication, form, formVar)
    * documentation = "Copies the Medication Form"
  

  // amount
  * rule[+]
    * name = "medicationAmount"
    * insert treeSource(gematikMedication, amount, amountVar)
    * insert targetCopyVariable(bfarmMedication, amount, amountVar)
    * documentation = "Copies the Medication Amount"
  

  // ingredient
  * rule[+]
    * name = "medicationIngredient"
    * insert treeSource(gematikMedication, ingredient, ingredientVar)
    * insert targetCopyVariable(bfarmMedication, ingredient, ingredientVar)
    * documentation = "Copies the Medication Ingredient"
  