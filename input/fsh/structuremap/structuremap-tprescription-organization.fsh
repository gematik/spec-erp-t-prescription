Instance: ERP-TPrescription-StructureMap-Organization
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for Organization"
Description: "Maps VZD-Organization-Information to BfArM T-Prescription Organization format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-Organization)

* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-vzd-searchset, source, vzdSearchSet)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-organization, target, bfarmOrganization)

* group[+]
  * name = "erpTOrganizationMapping"
  * typeMode = #none
  * documentation = "Mapping group for VZD SearchSet"

  * insert sd_input(vzdSearchSet, source)
  * insert sd_input(bfarmOrganization, target)

  * rule[+]
    * name = "mapOrganization"
    * insert treeSource(vzdSearchSet, entry, srcEntryOrgVar)
    * rule[+]
      * name = "entry"
      * insert treeSource(srcEntryOrgVar, resource, srcEntryOrganizationVar)
      * source[=].condition = "ofType(Organization)"
      // * source[=].logMessage = "ofType(Organization)"
      * rule[+]
        * name = "name"
        * insert treeSource(srcEntryOrganizationVar, name, srcOrgNameVar)
        * insert targetSetIdVariable(bfarmOrganization, name, srcOrgNameVar)
        * documentation = "Copy Name to Organization"

  * rule[+]
    * name = "mapHealthcareService"
    * insert treeSource(vzdSearchSet, entry, srcEntryHCSVar)
    * rule[+]
      * name = "entry"
      * insert treeSource(srcEntryHCSVar, resource, srcEntryHealthcareServiceVar)
      * source[=].condition = "ofType(HealthcareService)"
      // * source[=].logMessage = "ofType(HealthcareService)"
      * rule[+]
        * name = "telecom"
        * insert treeSource(srcEntryHealthcareServiceVar, telecom, srcHcsTelecomVar)
        * insert targetSetIdVariable(bfarmOrganization, telecom, srcHcsTelecomVar)
        * documentation = "Copy telecom to HealthcareService"

  * rule[+]
    * name = "mapLocation"
    * insert treeSource(vzdSearchSet, entry, srcEntryHCSVar)
    * rule[+]
      * name = "entry"
      * insert treeSource(srcEntryHCSVar, resource, srcEntryLocationVar)
      * source[=].condition = "ofType(Location)"
      // * source[=].logMessage = "ofType(Location)"
      * rule[+]
        * name = "address"
        * insert treeSource(srcEntryLocationVar, address, srcLocationAddressVar)
        * insert targetSetIdVariable(bfarmOrganization, address, srcLocationAddressVar)
        * documentation = "Copy address to Location"
