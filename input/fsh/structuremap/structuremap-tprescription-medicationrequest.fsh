Instance: ERP-TPrescription-StructureMap-MedicationRequest
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for MedicationRequest"
Description: "Maps GEM ERP MedicationRequest BfArM T-Prescription MedicationRequest format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-MedicationRequest)
//TODO
* insert sd_structure(https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_MedicationRequest, source, gematikMedicationRequest)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-medication-request, target, bfarmMedicationRequest)

* group[+]
  * name = "RequestMapping"
  * typeMode = #none
  * documentation = "Mapping group for Request information transformation"

  * insert sd_input(gematikMedicationRequest, source)
  * insert sd_input(bfarmMedicationRequest, target)

// Rules for MedicationRequest

// dosageInstruction
  * rule[+]
    * name = "medicationRequestDosageInstruction"
    * source[+]
      * context = "gematikMedicationRequest"
      * element = "dosageInstruction"
      * variable = "dosageInstructionVar"
    * insert targetCopyVariable(bfarmMedicationRequest, dosageInstruction, dosageInstructionVar)
    * documentation = "TODO"
  * rule[+]
    * name = "medicationRequestDosageInstruction"
    * source[+]
      * context = "gematikMedicationRequest"
      * element = "whenHandedOver"
      * variable = "whenHandedOverVar"
    * insert targetCopyVariable(bfarmMedicationRequest, whenHandedOver, whenHandedOverVar)
    * documentation = "TODO"
  
// reference to Medication
  * rule[+]
    * name = "medicationReference"
    * source[+]
      * context = "gematikMedicationRequest"
      * element = "medication"
      * variable = "medicationVar"
    * insert targetCopyVariable(bfarmMedicationRequest, medication, medicationVar)
    * documentation = "Copy medication; ensure correct mapping from reference is stated"

// set status to completed
  * rule[+]
    * name = "medicationRequestStatus"
    * source.context = "gematikMedicationRequest"
    * source.element = "status"
    * target[+]
      * context = "bfarmMedicationRequest"
      * contextType = #variable
      * element = "status"
      * transform = #copy
      * parameter.valueString = "completed"
    * documentation = "TODO"
  
// quantity
  * rule[+]
    * name = "medicationRequestQuantity"
    * source[+]
      * context = "gematikMedicationRequest"
      * element = "quantity"
      * variable = "quantityVar"
    * insert targetCopyVariable(bfarmMedicationRequest, quantity, quantityVar)
    * documentation = "TODO"
  
// Sets Organization/<telematik-id> as reference
  * rule[+]
    * name = "medicationRequestPerformer"
    * source[+]
      * context = "gematikMedicationRequest"
      * element = "performer"
      * variable = "performerVar"
    * target[+]      
      * context = "bfarmMedicationRequest"
      * contextType = #variable
      * element = "performer"
      * variable = "tgtPerformerVar"
    * rule[+]
      * name = "medicationRequestPerformerActor"
      * source[+]
        * context = "performerVar"
        * element = "actor"
        * variable = "performerActorVar"
      * target[+]      
        * context = "tgtPerformerVar"
        * contextType = #variable
        * element = "actor"
        * variable = "tgtPerformerActorVar"
      * rule[+]
        * name = "medicationRequestPerformerActorIdentifier"
        * source[+]
          * context = "performerActorVar"
          * element = "identifier"
          * variable = "performerActorIdentifierVar"
        // * target[+]      
        //   * context = "tgtPerformerActorVar"
        //   * contextType = #variable
        //   * element = "reference"
        //   * variable = "tgtPerformerActorReferenceVar"
        * rule[+]
          * name = "medicationRequestPerformerActorIdentifierValue"
          * source[+]
            * context = "performerActorIdentifierVar"
            * element = "value"
            * variable = "performerActorIdentifierValueVar"
          * target[+]
            * context = "tgtPerformerActorVar"
            * contextType = #variable
            * element = "reference"
            * transform = #append
            * parameter[+].valueString = "Organization/"
            * parameter[+].valueId = "performerActorIdentifierValueVar"
    * documentation = "Map performer.identifier to a reference to Organization with the identifier value"