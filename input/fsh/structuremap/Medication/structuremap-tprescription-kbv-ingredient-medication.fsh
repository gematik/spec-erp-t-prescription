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

  // Id
  * rule[+]
    * name = "medicationId"
    * insert treeSource(kbvMedicationIngredient, id, IdVar)
    * insert targetSetIdVariable(bfarmMedication, id, IdVar)
    * documentation = "Copies the Medication Id"

  // form
  * rule[+]
    * name = "medicationForm"
    * insert treeSource(kbvMedicationIngredient, form, formVar)
    * insert targetSetIdVariable(bfarmMedication, form, formVar)
    * documentation = "Copies the Medication Form"
  
  
   // amount
  * rule[+]
    * name = "medicationAmount"
    * insert treeSource(kbvMedicationPZN, amount, amountVar)
    * insert treeTarget(bfarmMedication, amount, tgtAmountVar)
    * documentation = "Copies the Medication Amount"

    * rule[+]
      * name = "medicationAmountDenominator"
      * insert treeSource(amountVar, denominator, amountDenominatorVar)
      * insert targetSetIdVariable(tgtAmountVar, denominator, amountDenominatorVar)
    
    // Amount Numerator Values
    * rule[+]
      * name = "medicationAmountNumerator"
      * insert treeSource(amountVar, numerator, amountNumeratorVar)
      * insert treeTarget(tgtAmountVar, numerator, tgtAmountNumeratorVar)
      // Amount Numerator Extensions
      * rule[+]
        * name = "medicationAmountExt"
        * insert treeSource(amountNumeratorVar, extension, amountNumExtVar)
        * insert treeTarget(tgtAmountNumeratorVar, extension, tgtAmountNumExtVar)
        * documentation = "Copies the Medication Extensions"
        * rule[+]
          * name = "copyPackagingSizeExtensionUrl"
          * source[+].context = "amountNumExtVar"
          * source[=].condition = "url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_PackagingSize'"
          * insert targetSetStringVariable(tgtAmountNumExtVar, url, https://gematik.de/fhir/epa-medication/StructureDefinition/medication-packaging-size-extension)
          * rule[+]
            * name = "copyExtensionValue"
            * documentation = "Copies the the value for each Extension"
            * insert treeSource(amountNumExtVar, value, extValVar)
            * insert targetSetIdVariable(tgtAmountNumExtVar, value, extValVar)

      // Amount Numerator Values
      * rule[+]
        * name = "medicationAmountNumeratorValue"
        * insert treeSource(amountNumeratorVar, value, amountNumeratorValueVar)
        * insert targetSetIdVariable(tgtAmountNumeratorVar, value, amountNumeratorValueVar)
      * rule[+]
        * name = "medicationAmountNumeratorUnit"
        * insert treeSource(amountNumeratorVar, unit, amountNumeratorUnitVar)
        * insert targetSetIdVariable(tgtAmountNumeratorVar, unit, amountNumeratorUnitVar)
      * rule[+]
        * name = "medicationAmountNumeratorSystem"
        * insert treeSource(amountNumeratorVar, system, amountNumeratorSystemVar)
        * insert targetSetIdVariable(tgtAmountNumeratorVar, system, amountNumeratorSystemVar)
      * rule[+]
        * name = "medicationAmountNumeratorCode"
        * insert treeSource(amountNumeratorVar, code, amountNumeratorCodeVar)
        * insert targetSetIdVariable(tgtAmountNumeratorVar, code, amountNumeratorCodeVar)

  // ingredient
  * rule[+]
    * name = "medicationIngredient"
    * insert treeSource(kbvMedicationIngredient, ingredient, ingredientVar)
    * insert targetSetIdVariable(bfarmMedication, ingredient, ingredientVar)
    * documentation = "Copies the Medication Ingredient"
  