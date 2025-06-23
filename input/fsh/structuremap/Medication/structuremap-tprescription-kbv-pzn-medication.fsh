Instance: ERP-TPrescription-StructureMap-KBV-PZN-Medication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for KBV PZN Medication"
Description: "Maps KBV-PZN ERP Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-KBV-PZN-Medication)

* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, source, kbvMedicationPZN)
* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, target, bfarmMedication)

* group[+]
  * name = "KBVPZNMedicationMapping"
  * typeMode = #none
  * documentation = "Mapping group for medication information transformation"

  * insert sd_input(kbvMedicationPZN, source)
  * insert sd_input(bfarmMedication, target)

  // Extensions
  * rule[+]
    * name = "medicationExt"
    * insert treeSource(kbvMedicationPZN, extension, extVar)
    * insert treeTarget(bfarmMedication, extension, tgtExtVar)
    * documentation = "Copies the Medication Extensions"
    * rule[+]
      * name = "copyNormgroesseExtensionUrl"
      * documentation = "Copies the 'normgroesse' extension and sets its URL to 'normgroesseNEW' in the target"
      * source[+].context = "extVar"
      * source[=].condition = "url='http://fhir.de/StructureDefinition/normgroesse'"
      * insert targetSetStringVariable(tgtExtVar, url, http://fhir.de/StructureDefinition/normgroesse)
      * rule[+]
        * name = "copyExtensionValue"
        * documentation = "Copies the the value for each Extension"
        * insert treeSource(extVar, value, extValVar)
        * insert targetSetIdVariable(tgtExtVar, value, extValVar)

  
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
    * insert treeSource(kbvMedicationPZN, ingredient, ingredientVar)
    * insert targetSetIdVariable(bfarmMedication, ingredient, ingredientVar)
    * documentation = "Copies the Medication Ingredient"
  