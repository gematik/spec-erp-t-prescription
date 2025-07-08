
**Titel:** E-T-Rezept Structure Map for Organization

**Beschreibung:** Maps VZD-Organization-Information to BfArM T-Prescription Organization format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `vzdSearchSet.entry.resource [Typ: Organization]` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| `vzdSearchSet.entry.resource [Typ: Organization].name` | `bfarmOrganization.name` | Copy Name to Organization |
| `vzdSearchSet.entry.resource [Typ: Organization].identifier [Bedingung: $this.system='https://gematik.de/fhir/sid/telematik-id']` | `bfarmOrganization.identifier` | *(direkte Kopie)* |
| `vzdSearchSet.entry.resource [Typ: Organization].identifier [Bedingung: $this.system='https://gematik.de/fhir/sid/telematik-id'].value` | `bfarmOrganization.identifier.system` | Copy TelematikID to Organization<br>→ setzt URL 'https://gematik.de/fhir/sid/telematik-id' |
| `vzdSearchSet.entry.resource [Typ: HealthcareService]` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| `vzdSearchSet.entry.resource [Typ: HealthcareService].telecom` | `bfarmOrganization.telecom` | Copy telecom to HealthcareService |
| `vzdSearchSet.entry.resource [Typ: Location]` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| `vzdSearchSet.entry.resource [Typ: Location].address` | `bfarmOrganization.address` | Copy address to Location |
