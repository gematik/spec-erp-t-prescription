
**Titel:** E-T-Rezept Structure Map for CarbonCopy

**Beschreibung:** Diese Ressource beschreibt das Mapping und führt die Mappings aller Teilressourcen zusammen. Weitere Informationen und Beschreibungen zum Mapping können auf der Seite [Mapping des digitalen Durchschlag E-T-Rezept](./trezept.html#mapping-des-digitalen-durchschlags-e-t-rezept) eingesehen werden.

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
|  | `CarbonCopy.meta.profile` | Setzt das meta.profile des digitalen Durchschlags T-Rezept<br>→ setzt URL 'https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-carbon-copy|1.0' |
|  | `CarbonCopy.parameter` | Mapping der Rezeptinformationen |
| `entry.resource [Typ: Task]` | `parameter.name` | Mappt die E-Rezept-ID des Tasks in den digitalen Durchschlag<br>→ erstellt neues Identifier |
| `entry.resource [Typ: Task]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [Task](./StructureMap-ERPTPrescriptionStructureMapTask.html) |
| `entry.resource [Typ: MedicationRequest]` | `parameter.name` | *(direkte Kopie)* |
| `entry.resource [Typ: MedicationRequest]` | `parameter.resource` | Mappt den KBV-MedicationRequest auf das BfArM MedicationRequest Zielprofil<br>→ erstellt neues MedicationRequest |
| `entry.resource [Typ: MedicationRequest]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [MedicationRequest](./StructureMap-ERPTPrescriptionStructureMapMedicationRequest.html) |
| `entry.resource [Typ: MedicationRequest]` | `parameter.name` | *(direkte Kopie)* |
| `entry.resource [Typ: MedicationRequest].entry [Typ: Medication]` | `parameter.resource` | Mappt die KBV-Medication auf das BfArM Medication Zielprofil<br>→ erstellt neues Medication |
| `entry.resource [Typ: MedicationRequest].entry [Typ: Medication].resource` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [Medication](./StructureMap-ERPTPrescriptionStructureMapMedication.html) |
|  | `CarbonCopy.parameter` | Mapping der Abgabeinformationen |
| `entry.resource [Typ: Bundle]` | `parameter.name` | *(direkte Kopie)* |
| `entry.resource [Typ: Bundle]` | `parameter.resource` | Mapping des FHIR-VZD Search Sets in eine BfArM Organization<br>→ erstellt neues Organization |
| `entry.resource [Typ: Bundle]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [Organization](./StructureMap-ERPTPrescriptionStructureMapOrganization.html) |
| `entry.resource [Typ: MedicationDispense]` | `part` | *(direkte Kopie)* |
| `entry.resource [Typ: MedicationDispense]` | `parameter.part.name` | Mappt die Abgabeinforamtionen der Apotheke auf das BfArM MedicationDispense Zielprofil<br>→ erstellt neues MedicationDispense |
| `entry.resource [Typ: MedicationDispense]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [MedicationDispense](./StructureMap-ERPTPrescriptionStructureMapMedicationDispense.html) |
| `entry.resource [Typ: MedicationDispense]` | `part` | *(direkte Kopie)* |
| `entry.resource [Typ: MedicationDispense].entry [Typ: Medication]` | `parameter.resource` | Mappt die Informationen des abgegebenen Arzneimittels auf das BfArM Medication Zielprofil<br>→ erstellt neues Medication |
| `entry.resource [Typ: MedicationDispense].entry [Typ: Medication].resource` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [Medication](./StructureMap-ERPTPrescriptionStructureMapMedication.html) |
