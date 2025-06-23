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

  // Extensions
  * rule[+]
    * name = "medicationExt"
    * insert treeSource(kbvMedicationCompounding, extension, extVar)
    * insert treeTarget(bfarmMedication, extension, tgtExtVar)
    * documentation = "Copies the Medication Extensions"
    * rule[+]
      * name = "copyFormulaPackagingExtensionUrl"
      * source[+].context = "extVar"
      * source[=].variable = "extMatchVar"
      * source[=].condition = "url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Packaging'"
      * insert targetSetStringVariable(tgtExtVar, url,  https://gematik.de/fhir/epa-medication/StructureDefinition/medication-formulation-packaging-extension)
      * rule[+]
        * name = "copyExtensionValue"
        * documentation = "Copies the the value for each Extension"
        * insert treeSource(extMatchVar, value, extValVar)
        * insert targetSetIdVariable(tgtExtVar, value, extValVar)

  // Id
  * rule[+]
    * name = "medicationId"
    * insert treeSource(kbvMedicationCompounding, id, IdVar)
    * insert targetSetIdVariable(bfarmMedication, id, IdVar)
    * documentation = "Copies the Medication Id"

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
    
  // Compounding Ingredient
  * rule[+]
    * name = "medicationIngredient"
    * insert treeSource(kbvMedicationCompounding, ingredient, ingredientVar)
    * insert treeTarget(bfarmMedication, ingredient, tgtIngredientVar)

    // Copy item[x]
    * rule[+]
      * name = "medicationIngredientItemValue"
      * insert treeSource(ingredientVar, item, IngredientItemValueVar)
      * insert targetSetIdVariable(tgtIngredientVar, item, IngredientItemValueVar)

    // Extension
    * rule[+]
      * name = "medicationIngredientExt"
      * insert treeSource(ingredientVar, extension, IngredientExtVar)
      * insert treeTarget(tgtIngredientVar, extension, tgtIngredientExtVar)
      * documentation = "Copies the Medication Extensions"
      * rule[+]
        * name = "copyPackagingSizeExtensionUrl"
        * source[+].context = "IngredientExtVar"
        * source[=].condition = "url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Ingredient_Form'"
        * insert targetSetStringVariable(tgtIngredientExtVar, url, https://gematik.de/fhir/epa-medication/StructureDefinition/medication-ingredient-darreichungsform-extension)
        * rule[+]
          * name = "copyExtensionValue"
          * documentation = "Copies the the value for each Extension"
          * insert treeSource(IngredientExtVar, value, extValVar)
          * insert targetSetIdVariable(tgtIngredientExtVar, value, extValVar)

    // Copy strength
    * rule[+]
      * name = "medicationIngredientStrength"
      * insert treeSource(ingredientVar, strength, IngredientStrengthValueVar)
      * insert treeTarget(tgtIngredientVar, strength, IngredientStrengthValueVar)

      // Copy numerator and denominator
      * rule[+]
        * name = "medicationIngredientDenominator"
        * insert treeSource(IngredientStrengthValueVar, denominator, ingredientDenominatorVar)
        * insert targetSetIdVariable(IngredientStrengthValueVar, denominator, ingredientDenominatorVar)
      * rule[+]
        * name = "medicationIngredientNumerator"
        * insert treeSource(IngredientStrengthValueVar, numerator, ingredientNumeratorVar)
        * insert targetSetIdVariable(IngredientStrengthValueVar, numerator, ingredientNumeratorVar)

      // Strength Extension
      * rule[+]
        * name = "medicationIngredientStrengthExt"
        * insert treeSource(IngredientStrengthValueVar, extension, IngredientStrExtVar)
        * insert treeTarget(IngredientStrengthValueVar, extension, tgtIngredientStrExtVar)
        * documentation = "Copies the Ingredient Strength Extensions"
        * rule[+]
          * name = "copyPackagingSizeExtensionUrl"
          * source[+].context = "IngredientStrExtVar"
          * source[=].condition = "url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Medication_Ingredient_Amount'"
          * insert targetSetStringVariable(tgtIngredientStrExtVar, url, https://gematik.de/fhir/epa-medication/StructureDefinition/medication-ingredient-amount-extension)
          * rule[+]
            * name = "copyExtensionValue"
            * documentation = "Copies the the value for each Extension"
            * insert treeSource(IngredientStrExtVar, value, extValVar)
            * insert targetSetIdVariable(tgtIngredientStrExtVar, value, extValVar)
  