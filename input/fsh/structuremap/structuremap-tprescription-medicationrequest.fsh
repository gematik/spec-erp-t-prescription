Instance: ERP-TPrescription-StructureMap-MedicationRequest
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for MedicationRequest"
Description: "Maps KBV MedicationRequest BfArM T-Prescription MedicationRequest format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-MedicationRequest)
//TODO
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Prescription, source, kbvMedicationRequest)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-medication-request, target, bfarmMedicationRequest)

* group[+]
  * name = "erpTRequestMapping"
  * typeMode = #none
  * documentation = "Mapping group for Request information transformation"

  * insert sd_input(kbvMedicationRequest, source)
  * insert sd_input(bfarmMedicationRequest, target)

// set status to completed
  * rule[+]
    * name = "medicationRequestStatus"
    * insert treeSource(kbvMedicationRequest, status, srcStatus)
    * insert targetSetStringVariable(bfarmMedicationRequest, status, completed)
    * documentation = "TODO"

// set intent to completed
  * rule[+]
    * name = "medicationRequestIntent"
    * source.context = "kbvMedicationRequest"
    * source.element = "intent"
    * insert targetSetStringVariable(bfarmMedicationRequest, intent, order)
    * documentation = "TODO"

// set subject to not-permitted
  * rule[+]
    * name = "medicationRequestsubject"
    * insert treeSource(kbvMedicationRequest, subject, srcSubject)
    * insert treeTarget(bfarmMedicationRequest, subject, tgtSubject)
    * rule[+]
      * name = "medicationRequestsubjectExtension"
      * insert treeSource(kbvMedicationRequest, subject, srcSubject)
      * insert treeTarget(tgtSubject, extension, tgtSubjectExtension)
      * rule[+]
        * name = "medicationRequestsubjectExtensionContent"
        * insert treeSource(kbvMedicationRequest, subject, srcSubject)
        * insert targetSetStringVariable(tgtSubjectExtension, url, http://hl7.org/fhir/StructureDefinition/data-absent-reason)
        * insert targetSetCodeVariable(tgtSubjectExtension, valueMarkdown, not-permitted)
    * documentation = "TODO"

// authoredOn
  * rule[+]
    * name = "medicationRequestAuthoredOn"
    * insert treeSource(kbvMedicationRequest, authoredOn, srcAuthoredOnVar)
    * insert targetSetIdVariable(bfarmMedicationRequest, authoredOn, srcAuthoredOnVar)
    * documentation = "TODO"

// dosageInstruction
  * rule[+]
    * name = "medicationRequestDosageInstruction"
    * insert treeSource(kbvMedicationRequest, dosageInstruction, srcDosageInstructionVar)
    * insert targetSetIdVariable(bfarmMedicationRequest, dosageInstruction, srcDosageInstructionVar)
    * documentation = "TODO"

// dispenseRequest
  * rule[+]
    * name = "medicationRequestDispenseRequest"
    * insert treeSource(kbvMedicationRequest, dispenseRequest, srcDispenseRequestVar)
    * insert targetSetIdVariable(bfarmMedicationRequest, dispenseRequest, srcDispenseRequestVar)
    * documentation = "TODO"

// reference to Medication
  * rule[+]
    * name = "medicationReference"
    * insert treeSource(kbvMedicationRequest, medication, medicationVar)
    * insert targetSetIdVariable(bfarmMedicationRequest, medication, medicationVar)
    * documentation = "Copy medication; ensure correct mapping from reference is stated"