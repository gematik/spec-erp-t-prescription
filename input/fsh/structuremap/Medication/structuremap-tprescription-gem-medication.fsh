Instance: ERPTPrescriptionStructureMapGEMMedication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for Medication"
Description: "Maps GEM ERP Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERPTPrescriptionStructureMapGEMMedication)

* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, source, gematikMedication)
* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, target, bfarmMedication)

* group[+]
  * name = "ERPTPrescriptionStructureMapGEMMedication"
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

  // Contained Medications
  * rule[+]
    * name = "mapContainedRessources"
    * insert treeSource(gematikMedication, contained, ContainedVar)
    * insert targetSetIdVariable(bfarmMedication, contained, ContainedVar)

  // Extensions
  * rule[+]
    * name = "medicationExtension"
    * insert treeSource(gematikMedication, extension, extVar)
    * insert treeTarget(bfarmMedication, extension, tgtExtVar)
    * documentation = "Copies the Medication Extensions"
    // Normgroesse
    * rule[+]
      * name = "copyNormgroesseExtensionUrl"
      * documentation = "Copies the 'normgroesse' extension"
      * source[+].context = "extVar"
      * source[=].condition = "url='http://fhir.de/StructureDefinition/normgroesse'"
      * insert targetSetStringVariable(tgtExtVar, url, http://fhir.de/StructureDefinition/normgroesse)
      * rule[+]
        * name = "copyExtensionValue"
        * documentation = "Copies the the value for each Extension"
        * insert treeSource(extVar, value, extValVar)
        * insert targetSetIdVariable(tgtExtVar, value, extValVar)

    //Packaging
    * rule[+]
      * name = "copyPackagingExtensionUrl"
      * documentation = "Copies the 'packaging' extension"
      * source[+].context = "extVar"
      * source[=].condition = "url='https://gematik.de/fhir/epa-medication/StructureDefinition/medication-formulation-packaging-extension'"
      * insert targetSetStringVariable(tgtExtVar, url, https://gematik.de/fhir/epa-medication/StructureDefinition/medication-formulation-packaging-extension)
      * rule[+]
        * name = "copyExtensionValue"
        * documentation = "Copies the the value for each Extension"
        * insert treeSource(extVar, value, extValVar)
        * insert targetSetIdVariable(tgtExtVar, value, extValVar)
  
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
  