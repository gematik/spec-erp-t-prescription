RuleSet: Profile(name)
* ^url = "https://gematik.de/fhir/erp-t-rezept/StructureDefinition/{name}"
* ^status = #draft
* ^version = "0.1.0"
* ^date = "2025-07-01"

RuleSet: Instance(resourcetype, resname)
* url = "https://gematik.de/fhir/erp-t-rezept/{resourcetype}/{resname}"
* status = #draft
* version = "0.1.0"
* date = "2025-07-01"
* name = "{resname}"
* experimental = false