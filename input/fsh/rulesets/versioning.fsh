// General rule for to handle versions for all structure definitions

//WICHTIG: Auch die OpenAPI Version anpassen!

RuleSet: Versioning
* ^status = #active
* ^version = "1.2.0"
* ^date = "2026-05-08"

RuleSet: InstanceVersioning
* status = #active
* version = "1.2.0"
* date = "2026-05-08"

// Dates for Examples (Date of actual release)
RuleSet: Date(field)
* {field} = "2026-07-01"

RuleSet: DateTime(field)
* {field} = "2026-07-01T15:29:00+00:00"

RuleSet: DateTimeStamp(field)
* {field} = "2026-07-01T15:29:00.434+00:00"

RuleSet: DateTimeStampPlus1Hr(field)
* {field} = "2026-07-01T16:44:00.434+00:00"

RuleSet: setMetaProfileCC(context, to)
* insert targetBase({context}, {to})
* target[=].parameter.valueString = "https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-carbon-copy|1.1"

// Rules to set meta.profile in profiles and instances
RuleSet: PackageMetaProfileExactly(profile)
* meta.profile[+] = "https://gematik.de/fhir/erp-t-prescription/StructureDefinition/{profile}|1.1" (exactly)