Instance: ERP-TPrescription-StructureMap-KBV-PZN-Medication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for KBV PZN Medication"
Description: "Maps KBV-PZN ERP Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-KBV-PZN-Medication)

* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_PZN, source, kbvMedicationPZN)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-medication, target, bfarmMedication)

* group[+]
  * name = "KBVPZNMedicationMapping"
  * typeMode = #none
  * documentation = "Mapping group for medication information transformation"

  * insert sd_input(kbvMedicationPZN, source)
  * insert sd_input(bfarmMedication, target)

  // Id
  * rule[+]
    * name = "medicationId"
    * insert treeSource(kbvMedicationPZN, id, IdVar)
    * insert targetSetIdVariable(bfarmMedication, id, IdVar)
    * documentation = "Copies the Medication Id"

  // code
  * rule[+]
    * name = "medicationCode"
    * insert treeSource(kbvMedicationPZN, code, codeVar)
    // * source[=].logMessage = "$this"
    * insert targetSetIdVariable(bfarmMedication, code, codeVar)
    * documentation = "Copies the Medication Code"

  // form
  * rule[+]
    * name = "medicationForm"
    * insert treeSource(kbvMedicationPZN, form, formVar)
    * insert targetSetIdVariable(bfarmMedication, form, formVar)
    * documentation = "Copies the Medication Form"
  
  // amount
  * rule[+]
    * name = "medicationAmount"
    * insert treeSource(kbvMedicationPZN, amount, amountVar)
    * insert targetSetIdVariable(bfarmMedication, amount, amountVar)
    * documentation = "Copies the Medication Amount"
  
  // ingredient
  * rule[+]
    * name = "medicationIngredient"
    * insert treeSource(kbvMedicationPZN, ingredient, ingredientVar)
    * insert targetSetIdVariable(bfarmMedication, ingredient, ingredientVar)
    * documentation = "Copies the Medication Ingredient"
  