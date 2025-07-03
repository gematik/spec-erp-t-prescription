| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `vzdSearchSet.entry.srcEntryOrgVar.resource [where ofType(Organization)].srcEntryOrganizationVar.name` | `bfarmOrganization.name` | Copy Name to Organization |
| `vzdSearchSet.entry.srcEntryHCSVar.resource [where ofType(HealthcareService)].srcEntryHealthcareServiceVar.telecom` | `bfarmOrganization.telecom` | Copy telecom to HealthcareService |
| `vzdSearchSet.entry.srcEntryHCSVar.resource [where ofType(Location)].srcEntryLocationVar.address` | `bfarmOrganization.address` | Copy address to Location |
