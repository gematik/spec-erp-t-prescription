Instance: ERP-TPrescription-StructureMap-KBV-Compounding-Medication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for KBV Compounding Medication"
Description: "Maps KBV-Compounding ERP Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-KBV-Compounding-Medication)

* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_Compounding, source, kbvMedicationCompounding)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-medication, target, bfarmMedication)

* group[+]
  * name = "KBVCompoundingMedicationMapping"
  * typeMode = #none
  * documentation = "Mapping group for medication information transformation"

  * insert sd_input(kbvMedicationCompounding, source)
  * insert sd_input(bfarmMedication, target)

  // code
  * rule[+]
    * name = "medicationCode"
    * documentation = "Copies the Medication Code"
    * insert treeSource(kbvMedicationCompounding, code, srcCodeVar)
    * insert treeTarget(bfarmMedication, code, tgtCodeVar)
    * rule[+]
      * name = "medicationCodeText"
      * insert treeSource(srcCodeVar, text, srcCodeTextVar)
      * insert targetSetIdVariable(tgtCodeVar, text, srcCodeTextVar)
      * documentation = "Copies the Medication Code Text"
  
  // form
  * rule[+]
    * name = "medicationForm"
    * insert treeSource(kbvMedicationCompounding, form, formVar)
    * insert targetSetIdVariable(bfarmMedication, form, formVar)
    * documentation = "Copies the Medication Form"
  
  // amount
  * rule[+]
    * name = "medicationAmount"
    * insert treeSource(kbvMedicationCompounding, amount, amountVar)
    * insert targetSetIdVariable(bfarmMedication, amount, amountVar)
    * documentation = "Copies the Medication Amount"
  
  // Compounding
  * rule[+]
    * name = "medicationIngredient"
    * insert treeSource(kbvMedicationCompounding, ingredient, ingredientVar)
    * insert targetSetIdVariable(bfarmMedication, ingredient, ingredientVar)
    * documentation = "Copies the Medication Ingredient"
  