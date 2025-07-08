
**Titel:** E-T-Rezept Structure Map for KBV FreeText Medication

**Beschreibung:** Maps KBV FreeText Medication to BfArM T-Prescription Medication format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `kbvMedicationFreeText.id` | `bfarmMedication.id` | Copies the Medication Id |
| `kbvMedicationFreeText.code` | `bfarmMedication.code` | Copies the Medication Code |
| `kbvMedicationFreeText.code.text` | `bfarmMedication.code.text` | Copies the Medication Code Text |
| `kbvMedicationFreeText.form` | `bfarmMedication.form` | Copies the Medication Form |
| `kbvMedicationFreeText.form.text` | `bfarmMedication.form.text` | Copies the Medication form Text |
