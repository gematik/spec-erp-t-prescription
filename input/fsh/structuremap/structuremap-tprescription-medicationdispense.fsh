Instance: ERP-TPrescription-StructureMap-MedicationDispense
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for MedicationDispense"
Description: "Maps GEM ERP MedicationDispense BfArM T-Prescription MedicationDispense format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-MedicationDispense)

* insert sd_structure(https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_MedicationDispense, source, gematikMedicationDispense)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-medication-dispense, target, bfarmMedicationDispense)

* group[+]
  * name = "erpTDispenseMapping"
  * typeMode = #none
  * documentation = "Mapping group for dispense information transformation"

  * insert sd_input(gematikMedicationDispense, source)
  * insert sd_input(bfarmMedicationDispense, target)

// Rules for MedicationDispense

// dosageInstruction
  * rule[+]
    * name = "medicationDispenseDosageInstruction"
    * source[+]
      * context = "gematikMedicationDispense"
      * element = "dosageInstruction"
      * variable = "dosageInstructionVar"
    * insert targetSetIdVariable(bfarmMedicationDispense, dosageInstruction, dosageInstructionVar)
    * documentation = "TODO"
  * rule[+]
    * name = "medicationDispenseDosageInstruction"
    * source[+]
      * context = "gematikMedicationDispense"
      * element = "whenHandedOver"
      * variable = "whenHandedOverVar"
    * insert targetSetIdVariable(bfarmMedicationDispense, whenHandedOver, whenHandedOverVar)
    * documentation = "TODO"
  
// reference to Medication
  * rule[+]
    * name = "medicationReference"
    * source[+]
      * context = "gematikMedicationDispense"
      * element = "medication"
      * variable = "medicationVar"
    * insert targetSetIdVariable(bfarmMedicationDispense, medication, medicationVar)
    * documentation = "Copy medication; ensure correct mapping from reference is stated"

// set status to completed
  * rule[+]
    * name = "medicationDispenseStatus"
    * insert treeSource(gematikMedicationDispense, status, gematikMedicationDispenseStatus)
    * source[=].logMessage = "$this"
    * insert targetSetStringVariable(bfarmMedicationDispense, status, completed)
    * documentation = "TODO"
  
// quantity
  * rule[+]
    * name = "medicationDispenseQuantity"
    * insert treeSource(gematikMedicationDispense, quantity, quantityVar)
    * insert targetSetIdVariable(bfarmMedicationDispense, quantity, quantityVar)
    * documentation = "TODO"
  
// Sets Organization/<telematik-id> as reference
  * rule[+]
    * name = "medicationDispensePerformer"
    * insert treeSource(gematikMedicationDispense, performer, srcPerformerVar)
    * target[+]      
      * context = "bfarmMedicationDispense"
      * contextType = #variable
      * element = "performer"
      * variable = "tgtPerformerVar"
    * rule[+]
      * name = "medicationDispensePerformerActor"
      * insert treeSource(srcPerformerVar, actor, srcPerformerActorVar)
      * insert treeTarget(tgtPerformerVar, actor, tgtPerformerActorVar)
      * rule[+]
        * name = "medicationDispensePerformerActorIdentifier"
        * insert treeSource(srcPerformerActorVar, identifier, srcPerformerActorIdentifierVar)
        * rule[+]
          * name = "medicationDispensePerformerActorIdentifierValue"
          * insert treeSource(srcPerformerActorIdentifierVar, value, srcPerformerActorIdentifierValueVar)
          * target[+]
            * context = "tgtPerformerActorVar"
            * contextType = #variable
            * element = "reference"
            * transform = #append
            * parameter[+].valueString = "Organization/"
            * parameter[+].valueId = "srcPerformerActorIdentifierValueVar"
    * documentation = "Map performer.identifier to a reference to Organization with the identifier value"