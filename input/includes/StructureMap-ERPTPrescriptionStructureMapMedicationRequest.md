
**Titel:** E-T-Rezept Structure Map for MedicationRequest

**Beschreibung:** Mapping-Anweisungen zur Transformation von KBV MedicationRequest zu BfArM T-Prescription MedicationRequest

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `kbvMedicationRequest.status` | `bfarmMedicationRequest.status` | Setzt den Status auf 'completed' für den digitalen Durchschlag (Verschreibung ist bereits abgeschlossen) |
| `kbvMedicationRequest.intent` | `bfarmMedicationRequest.intent` | Setzt den Intent auf 'order' entsprechend der BfArM-Spezifikation für T-Prescription |
| `kbvMedicationRequest.extension` | `bfarmMedicationRequest.extension` | Mappt T-Rezept spezifische Extensions vom KBV- zum BfArM-Format |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic]` | `bfarmMedicationRequest.extension.url` | Kopiert teratogene Extensions für T-Rezept Kennzeichnung<br>→ setzt URL 'https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Teratogenic' |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extension` | `bfarmMedicationRequest.extension.url.extension` | Übernimmt den Wert der teratogenen Extension unverändert |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject` | Entfernt Patientenbezug durch data-absent-reason Extension für Datenschutz im digitalen Durchschlag |
| `kbvMedicationRequest.subject.kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension` | Erstellt data-absent-reason Extension für Subject |
| `kbvMedicationRequest.subject.kbvMedicationRequest.subject.kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension.url` | Setzt data-absent-reason auf 'not-permitted' um Patientendaten zu anonymisieren<br>→ setzt URL 'http://hl7.org/fhir/StructureDefinition/data-absent-reason' |
| `kbvMedicationRequest.authoredOn` | `bfarmMedicationRequest.authoredOn` | Übernimmt das Verschreibungsdatum unverändert vom KBV MedicationRequest |
| `kbvMedicationRequest.dosageInstruction` | `bfarmMedicationRequest.dosageInstruction` | Kopiert die Dosierungsanweisungen vollständig für den digitalen Durchschlag |
| `kbvMedicationRequest.dispenseRequest` | `bfarmMedicationRequest.dispenseRequest` | Übernimmt Abgabeanweisungen (Menge, Wiederholungen) aus der ursprünglichen Verschreibung |
| `kbvMedicationRequest.medication` | `bfarmMedicationRequest.medication` | Kopiert die Medikamentenreferenz - das referenzierte Medication wird separat gemappt |
