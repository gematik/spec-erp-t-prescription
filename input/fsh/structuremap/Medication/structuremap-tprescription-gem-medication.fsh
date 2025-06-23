Instance: ERP-TPrescription-StructureMap-GEM-Medication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for Medication"
Description: "Maps GEM ERP Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-GEM-Medication)

* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, source, gematikMedication)
* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, target, bfarmMedication)

* group[+]
  * name = "erpTGemMedicationMapping"
  * typeMode = #none
  * documentation = "Mapping group for medication information transformation"

  * insert sd_input(gematikMedication, source)
  * insert sd_input(bfarmMedication, target)

  // Id
  * rule[+]
    * name = "medicationId"
    * insert treeSource(gematikMedication, id, IdVar)
    * insert targetSetIdVariable(bfarmMedication, id, IdVar)
    * documentation = "Copies the Medication Id"

  // Extension
  * rule[+]
    * name = "medicationExtension"
    * insert treeSource(gematikMedication, extension, extVar)
    * insert targetSetIdVariable(bfarmMedication, extension, extVar)
    * documentation = "Copies the Medication Extension"
  
  // code
  * rule[+]
    * name = "medicationCode"
    * insert treeSource(gematikMedication, code, codeVar)
    * insert targetSetIdVariable(bfarmMedication, code, codeVar)
    * documentation = "Copies the Medication Code"
  

  // form
  * rule[+]
    * name = "medicationForm"
    * insert treeSource(gematikMedication, form, formVar)
    * insert targetSetIdVariable(bfarmMedication, form, formVar)
    * documentation = "Copies the Medication Form"
  

  // amount
  * rule[+]
    * name = "medicationAmount"
    * insert treeSource(gematikMedication, amount, amountVar)
    * insert targetSetIdVariable(bfarmMedication, amount, amountVar)
    * documentation = "Copies the Medication Amount"
  

  // ingredient
  * rule[+]
    * name = "medicationIngredient"
    * insert treeSource(gematikMedication, ingredient, ingredientVar)
    * insert targetSetIdVariable(bfarmMedication, ingredient, ingredientVar)
    * documentation = "Copies the Medication Ingredient"
  