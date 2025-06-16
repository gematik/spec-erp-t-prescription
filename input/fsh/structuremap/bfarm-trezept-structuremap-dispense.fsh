RuleSet: trezept-structuremap-dispense
// Dispense Group
* group[+]
  * name = "DispenseMapping"
  * typeMode = #none
  * documentation = "Mapping group for dispense information transformation"

  * insert sd_input(gematikMedication, source)
  * insert sd_input(gematikMedicationDispense, source)
  * insert sd_input(bfarmDispensedMedication, target)
  * insert sd_input(bfarmMedicationDispense, target)

// Rules for MedicationDispense
  * rule[+]
    * name = "medicationReference"
    * source.context = "gematikMedicationDispense"
    * source.element = "medication"
    * insert targetCopyVariable(bfarmMedicationDispense, medication)
    * documentation = "Copy medication; ensure correct mapping from reference is stated"
  
  * rule[+]
    * name = "medicationDispenseDosageInstruction"
    * source.context = "gematikMedicationDispense"
    * source.element = "dosageInstruction"
    * insert targetCopyVariable(bfarmMedicationDispense, dosageInstruction)
    * documentation = "TODO"

  * rule[+]
    * name = "medicationDispenseStatus"
    * source.context = "gematikMedicationDispense"
    * source.element = "status"
    * target[+]
      * context = "bfarmMedicationDispense"
      * contextType = #variable
      * element = "status"
      * transform = #evaluate
      * parameter.valueString = "'#completed'"
    * documentation = "TODO"
  
  * rule[+]
    * name = "medicationDispenseWhenHandedOver"
    * source.context = "gematikMedicationDispense"
    * source.element = "whenHandedOver"
    * insert targetCopyVariable(bfarmMedicationDispense, whenHandedOver)
    * documentation = "TODO"
  
  * rule[+]
    * name = "medicationDispenseQuantity"
    * source.context = "gematikMedicationDispense"
    * source.element = "quantity"
    * insert targetCopyVariable(bfarmMedicationDispense, quantity)
    * documentation = "TODO"
  
  * rule[+]
    * name = "medicationDispensePerformer"
    * source.context = "gematikMedicationDispense"
    * source.element = "performer[0].actor.where(identifier.system='https://gematik.de/fhir/sid/telematik-id').value"
    * target[+]
      * context = "bfarmMedicationDispense"
      * contextType = #variable
      * element = "performer[0].actor"
      * transform = #reference
      * parameter.valueString = "Organization/{identifier.value}"
    * documentation = "Map performer.identifier to a reference to Organization with the identifier value"
