
**Titel:** E-T-Rezept Structure Map for MedicationRequest

**Beschreibung:** Mapping-Anweisungen zur Transformation von KBV MedicationRequest zu BfArM T-Prescription MedicationRequest

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `kbvMedicationRequest.status` | `bfarmMedicationRequest.status` | Setzt den Status auf 'completed' für den digitalen Durchschlag (Verschreibung ist bereits abgeschlossen)<br>→ setzt Wert 'completed' |
| `kbvMedicationRequest.intent` | `bfarmMedicationRequest.intent` | Setzt den Intent auf 'order' entsprechend der BfArM-Spezifikation für T-Prescription<br>→ setzt Wert 'order' |
| `kbvMedicationRequest.extension` | `bfarmMedicationRequest.extension` | Mappt T-Rezept spezifische Extensions vom KBV- zum BfArM-Format |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic]` | `bfarmMedicationRequest.extension.url` | Kopiert teratogene Extensions für T-Rezept Kennzeichnung<br>→ setzt URL 'https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Teratogenic' |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extension` | `bfarmMedicationRequest.extension.url.extension` | Übernimmt den Wert der teratogenen Extension unverändert<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject` | Entfernt Patientenbezug durch data-absent-reason Extension für Datenschutz im digitalen Durchschlag |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension` | Erstellt data-absent-reason Extension für Subject |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension.url` | Setzt data-absent-reason auf 'not-permitted' um Patientendaten zu anonymisieren<br>→ setzt URL 'http://hl7.org/fhir/StructureDefinition/data-absent-reason' |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension.value` | Setzt data-absent-reason auf 'not-permitted' um Patientendaten zu anonymisieren |
| `kbvMedicationRequest.authoredOn` | `bfarmMedicationRequest.authoredOn` | Übernimmt das Verschreibungsdatum unverändert vom KBV MedicationRequest<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.dosageInstruction` | `bfarmMedicationRequest.dosageInstruction` | Kopiert die Dosierungsanweisungen vollständig für den digitalen Durchschlag<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.dispenseRequest` | `bfarmMedicationRequest.dispenseRequest` | Übernimmt Abgabeanweisungen (Menge, Wiederholungen) aus der ursprünglichen Verschreibung<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.medication` | `bfarmMedicationRequest.medication` | Kopiert die Medikamentenreferenz - das referenzierte Medication wird separat gemappt<br>→ übernimmt Wert aus Quellvariable |
