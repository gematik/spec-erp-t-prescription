
**Titel:** E-T-Rezept Structure Map for Task

**Beschreibung:** Maps resources to BfArM T-Prescription format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `task.identifier [Bedingung: $this.system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId']` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| `task.identifier [Bedingung: $this.system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId'].value` | `system` | → setzt URL 'https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId' |
