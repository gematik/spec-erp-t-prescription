
Instance: ERPTPrescriptionStructureMapTask
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for Task"
Description: "Maps resources to BfArM T-Prescription format"
* insert Instance(StructureMap, ERPTPrescriptionStructureMapTask)

* insert sd_structure(https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_Task, source, task)
* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Identifier, target, tgtIdentifier)

* group[+]
  * name = "ERPTPrescriptionStructureMapTask"
  * typeMode = #none
  * documentation = "Mapping group for Task"

  * insert sd_input(task, source)
  * insert sd_input(tgtIdentifier, target)

  * rule[+]
    * name = "prescriptionId"
    * insert treeSource(task, identifier, srcTaskIdentifier)
    * source[=].condition = "$this.system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId'"
    * source[=].logMessage = "'Prescription ID Identifier present: ' + ($this.system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId').toString()"
    * rule[+]
      * name = "prescriptionIdValue"
      * insert treeSource(srcTaskIdentifier, value, srcTaskIdentifierValue)
      * source[=].logMessage = "tgtIdentifier"
      * insert targetSetStringVariable(tgtIdentifier, system, https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId)
      * insert targetSetIdVariable(tgtIdentifier, value, srcTaskIdentifierValue)