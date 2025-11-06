
**Titel:** E-T-Rezept Structure Map for CarbonCopy

**Beschreibung:** Diese Ressource beschreibt das Mapping und führt die Mappings aller Teilressourcen zusammen. Weitere Informationen und Beschreibungen zum Mapping können auf der Seite [Mapping des digitalen Durchschlag E-T-Rezept](./trezept.html#mapping-des-digitalen-durchschlags-e-t-rezept) eingesehen werden.

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
|  | `erpTCarbonCopy.meta` | Setzt die Metadaten für den digitalen Durchschlag |
|  | `CarbonCopy.meta.profile` | Setzt das meta.profile des digitalen Durchschlags T-Rezept<br>→ setzt URL 'https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-carbon-copy|1.0' |
|  | `CarbonCopy.parameter` | Erstellt den rxPrescription Parameter mit allen Verschreibungsinformationen |
| `entry` | *(wird bestimmt durch Kontext)* | Verarbeitet alle Einträge des Quell-Bundles für Verschreibungsinformationen |
| `entry.resource` | *(wird bestimmt durch Kontext)* | Extrahiert relevante Ressourcen für die Verschreibung |
| `entry.resource [Typ: Task]` | `parameter.name` | Extrahiert die E-Rezept-ID aus dem Task und erstellt den prescriptionId Parameter<br>→ erstellt neues Identifier |
| `entry.resource [Typ: Task]` | *(wird bestimmt durch Kontext)* | Mappt Task-Informationen auf Identifier für die Rezept-ID<br>Verwendet Mapping: [Task](./StructureMap-ERPTPrescriptionStructureMapTask.html) |
| `entry.resource [Typ: MedicationRequest]` | `parameter.name` | Erstellt den medicationRequest Parameter für Verschreibungsdetails |
| `entry.resource [Typ: MedicationRequest]` | `parameter.resource` | Transformiert KBV-MedicationRequest in BfArM MedicationRequest Format<br>→ erstellt neues MedicationRequest |
| `entry.resource [Typ: MedicationRequest]` | *(wird bestimmt durch Kontext)* | Führt die detaillierte MedicationRequest-Transformation durch<br>Verwendet Mapping: [MedicationRequest](./StructureMap-ERPTPrescriptionStructureMapMedicationRequest.html) |
| `entry.resource [Typ: MedicationRequest]` | `parameter.name` | Erstellt den medication Parameter für das verschriebene Arzneimittel |
| `entry.resource [Typ: MedicationRequest].entry` | *(wird bestimmt durch Kontext)* | Bereitet die Suche nach der referenzierten Medication vor |
| `entry.resource [Typ: MedicationRequest].entry [Typ: Medication]` | `parameter.resource` | Findet die vom MedicationRequest referenzierte Medication und transformiert sie in BfArM Format<br>→ erstellt neues Medication |
| `entry.resource [Typ: MedicationRequest].entry [Typ: Medication].resource` | *(wird bestimmt durch Kontext)* | Führt die detaillierte Medication-Transformation für das verschriebene Arzneimittel durch<br>Verwendet Mapping: [Medication](./StructureMap-ERPTPrescriptionStructureMapMedication.html) |
|  | `CarbonCopy.parameter` | Erstellt den rxDispensation Parameter mit allen Abgabeinformationen |
| `entry` | *(wird bestimmt durch Kontext)* | Verarbeitet alle Einträge des Quell-Bundles für Abgabeinformationen |
| `entry.resource` | *(wird bestimmt durch Kontext)* | Extrahiert relevante Ressourcen für die Abgabe |
| `entry.resource [Typ: Bundle]` | `parameter.name` | Identifiziert VZD SearchSet Bundle für Apothekeninformationen |
| `entry.resource [Typ: Bundle]` | `parameter.resource` | Transformiert VZD SearchSet in BfArM Organization Format für die abgebende Apotheke<br>→ erstellt neues Organization |
| `entry.resource [Typ: Bundle]` | *(wird bestimmt durch Kontext)* | Führt die detaillierte Organization-Transformation durch<br>Verwendet Mapping: [Organization](./StructureMap-ERPTPrescriptionStructureMapOrganization.html) |
| `entry.resource [Typ: MedicationDispense]` | `part` | Erstellt eine dispenseInformation Part pro abgegebener MedicationDispense |
| `entry.resource [Typ: MedicationDispense]` | `parameter.part.name` | Bündelt MedicationDispense und zugehörige Medication unter dispenseInformation |
| `entry.resource [Typ: MedicationDispense]` | `part.name.name` | Transformiert gematik MedicationDispense in BfArM MedicationDispense Format<br>→ erstellt neues MedicationDispense |
| `entry.resource [Typ: MedicationDispense]` | *(wird bestimmt durch Kontext)* | Führt die detaillierte MedicationDispense-Transformation durch<br>Verwendet Mapping: [MedicationDispense](./StructureMap-ERPTPrescriptionStructureMapMedicationDispense.html) |
| `entry.resource [Typ: MedicationDispense]` | `part.name.name` | Findet die vom MedicationDispense referenzierte Medication und transformiert sie in BfArM Format |
| `entry.resource [Typ: MedicationDispense].entry` | *(wird bestimmt durch Kontext)* | Bereitet die Suche nach der referenzierten Medication im Bundle vor |
| `entry.resource [Typ: MedicationDispense].entry [Typ: Medication]` | `parameter.resource` | → erstellt neues Medication |
| `entry.resource [Typ: MedicationDispense].entry [Typ: Medication].resource` | *(wird bestimmt durch Kontext)* | Führt die detaillierte Medication-Transformation für das abgegebene Arzneimittel durch<br>Verwendet Mapping: [Medication](./StructureMap-ERPTPrescriptionStructureMapMedication.html) |
