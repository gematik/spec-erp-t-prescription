
**Titel:** E-T-Rezept Structure Map for Task

**Beschreibung:** Mappt die E-Rezept ID aus dem Task in ein Identifier Objekt

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `task.identifier [Bedingung: $this.system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId']` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| `task.identifier [Bedingung: $this.system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId'].value` | `system` | Mappt die E-Rezept-ID aus dem Task in den Identifier<br>→ setzt URL 'https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId' |
