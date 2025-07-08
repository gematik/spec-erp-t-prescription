
**Titel:** E-T-Rezept Structure Map for Medication

**Beschreibung:** Maps GEM ERP Medication to BfArM T-Prescription Medication format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `gematikMedication.id` | `bfarmMedication.id` | Übernimmt die eindeutige Medication-ID unverändert |
| `gematikMedication.contained` | `bfarmMedication.contained` | Kopiert eingebettete Ressourcen (z.B. referenzierte Medications oder Organizations) |
| `gematikMedication.extension` | `bfarmMedication.extension` | Mappt gematik-spezifische Medication-Extensions zu BfArM-Format |
| `gematikMedication.extension [normgroesse]` | `bfarmMedication.extension.url` | Übernimmt die Normgröße-Extension unverändert (deutsche Packungsgrößenangabe N1, N2, N3)<br>→ setzt URL 'http://fhir.de/StructureDefinition/normgroesse' |
| `gematikMedication.extension [normgroesse].value` | `bfarmMedication.extension.url.value` | Kopiert den Wert der Normgröße-Extension |
| `gematikMedication.extension [medication-formulation-packaging-extension]` | `bfarmMedication.extension.url` | Übernimmt die gematik-Verpackungs-Extension für Formulierungen<br>→ setzt URL 'https://gematik.de/fhir/epa-medication/StructureDefinition/medication-formulation-packaging-extension' |
| `gematikMedication.extension [medication-formulation-packaging-extension].value` | `bfarmMedication.extension.url.value` | Kopiert den Wert der Verpackungs-Extension |
| `gematikMedication.code` | `bfarmMedication.code` | Kopiert den Medikamentencode (PZN oder andere Identifikation) des abgegebenen Arzneimittels |
| `gematikMedication.form` | `bfarmMedication.form` | Übernimmt die Darreichungsform des tatsächlich abgegebenen Arzneimittels |
| `gematikMedication.amount` | `bfarmMedication.amount` | Kopiert die Mengenangaben des abgegebenen Arzneimittels (tatsächlich ausgehändigte Menge) |
| `gematikMedication.ingredient` | `bfarmMedication.ingredient` | Übernimmt Wirkstoffinformationen des abgegebenen Arzneimittels (falls vorhanden) |
