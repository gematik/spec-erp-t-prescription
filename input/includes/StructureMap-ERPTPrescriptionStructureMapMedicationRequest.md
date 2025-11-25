
**Titel:** E-T-Rezept Structure Map for MedicationRequest

**Beschreibung:** Mapping-Anweisungen zur Transformation von KBV MedicationRequest zu BfArM T-Prescription MedicationRequest

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `kbvMedicationRequest.status` | `bfarmMedicationRequest.status` | Setzt den Status auf 'completed' für den digitalen Durchschlag (Verschreibung ist bereits abgeschlossen)<br>→ setzt Wert 'completed' |
| `kbvMedicationRequest.intent` | `bfarmMedicationRequest.intent` | Setzt den Intent auf 'order' entsprechend der BfArM-Spezifikation für T-Prescription<br>→ setzt Wert 'order' |
| `kbvMedicationRequest.extension` | `bfarmMedicationRequest.extension` | Mappt T-Rezept spezifische Extensions vom KBV- zum BfArM-Format |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic]` | `bfarmMedicationRequest.extension.url` | Kopiert teratogene Extensions für T-Rezept Kennzeichnung<br>→ setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/epa-teratogenic-extension' |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extension` | `bfarmMedicationRequest.extension.url.extension` | Mappt die Unter-Extensions der teratogenen Extension mit angepassten URLs |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [Off-Label]` | *(wird bestimmt durch Kontext)* | Mappt Off-Label Extension |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [Off-Label].valueBoolean` | `url` | Übernimmt den Off-Label Booleschen Wert<br>→ setzt Wert 'off-label' |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [Off-Label].valueBoolean` | `valueBoolean` | Übernimmt den Off-Label Booleschen Wert<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [GebaerfaehigeFrau]` | *(wird bestimmt durch Kontext)* | Mappt GebaerfaehigeFrau Extension zu childbearing-potential |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [GebaerfaehigeFrau].valueBoolean` | `valueBoolean` | Übernimmt den Booleschen Wert für childbearing-potential<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [GebaerfaehigeFrau].valueBoolean` | `url` | Übernimmt den Booleschen Wert für childbearing-potential<br>→ setzt Wert 'childbearing-potential' |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [EinhaltungSicherheitsmassnahmen]` | *(wird bestimmt durch Kontext)* | Mappt EinhaltungSicherheitsmassnahmen Extension zu security-compliance |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [EinhaltungSicherheitsmassnahmen].valueBoolean` | `valueBoolean` | Übernimmt den Booleschen Wert für security-compliance<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [EinhaltungSicherheitsmassnahmen].valueBoolean` | `url` | Übernimmt den Booleschen Wert für security-compliance<br>→ setzt Wert 'security-compliance' |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [AushaendigungInformationsmaterialien]` | *(wird bestimmt durch Kontext)* | Mappt AushaendigungInformationsmaterialien Extension zu hand-out-information-material |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [AushaendigungInformationsmaterialien].valueBoolean` | `valueBoolean` | Übernimmt den Booleschen Wert für hand-out-information-material<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [AushaendigungInformationsmaterialien].valueBoolean` | `url` | Übernimmt den Booleschen Wert für hand-out-information-material<br>→ setzt Wert 'hand-out-information-material' |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [ErklaerungSachkenntnis]` | *(wird bestimmt durch Kontext)* | Mappt ErklaerungSachkenntnis Extension zu declaration-of-expertise |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [ErklaerungSachkenntnis].valueBoolean` | `valueBoolean` | Übernimmt den Booleschen Wert für declaration-of-expertise<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.extension [KBV_EX_ERP_Teratogenic].extensionExt [ErklaerungSachkenntnis].valueBoolean` | `url` | Übernimmt den Booleschen Wert für declaration-of-expertise<br>→ setzt Wert 'declaration-of-expertise' |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject` | Entfernt Patientenbezug durch data-absent-reason Extension für Datenschutz im digitalen Durchschlag |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension` | Erstellt data-absent-reason Extension für Subject |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension.url` | Setzt data-absent-reason auf 'not-permitted' um Patientendaten zu anonymisieren<br>→ setzt URL 'http://hl7.org/fhir/StructureDefinition/data-absent-reason' |
| `kbvMedicationRequest.subject` | `bfarmMedicationRequest.subject.extension.value` | Setzt data-absent-reason auf 'not-permitted' um Patientendaten zu anonymisieren |
| `kbvMedicationRequest.authoredOn` | `bfarmMedicationRequest.authoredOn` | Übernimmt das Verschreibungsdatum unverändert vom KBV MedicationRequest<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.dosageInstruction` | `bfarmMedicationRequest.dosageInstruction` | Kopiert die Dosierungsanweisungen vollständig für den digitalen Durchschlag<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.dispenseRequest` | `bfarmMedicationRequest.dispenseRequest` | Übernimmt Abgabeanweisungen (Menge, Wiederholungen) aus der ursprünglichen Verschreibung<br>→ übernimmt Wert aus Quellvariable |
| `kbvMedicationRequest.medicationReference.reference` | `bfarmMedicationRequest.medicationReference.reference` | Normalisiert Medikamentenreferenzen auf urn:uuid:<id>, das referenzierte Medication wird separat gemappt |
