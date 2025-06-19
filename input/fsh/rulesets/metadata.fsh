RuleSet: Profile(name)
* ^url = "https://gematik.de/fhir/erp-t-prescription/StructureDefinition/{name}"
* ^status = #draft
* ^version = "0.1.0"
* ^date = "2025-07-01"

RuleSet: Instance(resourcetype, resname)
* url = "https://gematik.de/fhir/erp-t-prescription/{resourcetype}/{resname}"
* status = #draft
* version = "0.1.0"
* date = "2025-07-01"
* name = "{resname}"
* experimental = false