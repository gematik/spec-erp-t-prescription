| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `vzdSearchSet.entry.resource [where ofType(Organization)].name` | `bfarmOrganization.name` | Copy Name to Organization |
| `vzdSearchSet.entry.resource [where ofType(HealthcareService)].telecom` | `bfarmOrganization.telecom` | Copy telecom to HealthcareService |
| `vzdSearchSet.entry.resource [where ofType(Location)].address` | `bfarmOrganization.address` | Copy address to Location |
