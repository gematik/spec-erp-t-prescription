
Instance: ERP-TPrescription-StructureMap-Task
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for Task"
Description: "Maps resources to BfArM T-Prescription format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-Task)

* insert sd_structure(https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_Task, source, task)
* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Identifier, target, identifier)

* group[+]
  * name = "erpTTaskMapping"
  * typeMode = #none
  * documentation = "Mapping group for Task"

  * insert sd_input(task, source)
  * insert sd_input(identifier, target)

  * rule[+]
    * name = "prescriptionId"
    * insert treeSource(task, identifier, srcTaskIdentifier)
    * source[=].condition = "$this.system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId'"
    * source[=].logMessage = "$this.system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId'"
    * rule[+]
      * name = "prescriptionIdValue"
      * insert treeSource(srcTaskIdentifier, value, srcTaskIdentifierValue)
      * insert targetSetStringVariable(identifier, system, https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId)
      * insert targetSetIdVariable(identifier, value, srcTaskIdentifierValue)