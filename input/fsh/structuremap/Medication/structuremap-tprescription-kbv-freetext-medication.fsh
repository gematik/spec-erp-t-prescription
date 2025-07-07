Instance: ERPTPrescriptionStructureMapKBVFreeTextMedication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for KBV FreeText Medication"
Description: "Maps KBV FreeText Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERPTPrescriptionStructureMapKBVFreeTextMedication)

* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, source, kbvMedicationFreeText)
* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, target, bfarmMedication)

// KBV FreeText Medication
* group[+]
  * name = "ERPTPrescriptionStructureMapKBVFreeTextMedication"
  * typeMode = #none
  * documentation = "Mapping group for medication information transformation"

  * insert sd_input(kbvMedicationFreeText, source)
  * insert sd_input(bfarmMedication, target)

  // Id
  * rule[+]
    * name = "medicationId"
    * insert treeSource(kbvMedicationFreeText, id, IdVar)
    * insert targetSetIdVariable(bfarmMedication, id, IdVar)
    * documentation = "Copies the Medication Id"

  // code
  * rule[+]
    * name = "medicationCode"
    * documentation = "Copies the Medication Code"
    * insert treeSource(kbvMedicationFreeText, code, srcCodeVar)
    * insert treeTarget(bfarmMedication, code, tgtCodeVar)
    * rule[+]
      * name = "medicationCodeText"
      * insert treeSource(srcCodeVar, text, srcCodeTextVar)
      * insert targetSetIdVariable(tgtCodeVar, text, srcCodeTextVar)
      * documentation = "Copies the Medication Code Text"
  
  // form
  * rule[+]
    * name = "medicationForm"
    * documentation = "Copies the Medication Form"
    * insert treeSource(kbvMedicationFreeText, form, srcFormVar)
    * insert treeTarget(bfarmMedication, form, tgtFormVar)
    * rule[+]
      * name = "medicationFormText"
      * insert treeSource(srcFormVar, text, srcformTextVar)
      * insert targetSetIdVariable(tgtFormVar, text, srcformTextVar)
      * documentation = "Copies the Medication form Text"
