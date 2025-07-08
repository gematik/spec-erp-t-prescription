| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `vzdSearchSet.entry.resource [where ofType(Organization)].name` | `bfarmOrganization.name` | Copy Name to Organization |
| `vzdSearchSet.entry.resource [where ofType(Organization)].identifier [where $this.system='https://gematik.de/fhir/sid/telematik-id'].value` | `bfarmOrganization.identifier.bfarmOrganizationIdentifierVar.system` | Copy TelematikID to Organization |
| `vzdSearchSet.entry.resource [where ofType(HealthcareService)].telecom` | `bfarmOrganization.telecom` | Copy telecom to HealthcareService |
| `vzdSearchSet.entry.resource [where ofType(Location)].address` | `bfarmOrganization.address` | Copy address to Location |
