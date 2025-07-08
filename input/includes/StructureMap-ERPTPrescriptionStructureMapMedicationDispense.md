
**Titel:** E-T-Rezept Structure Map for MedicationDispense

**Beschreibung:** Maps GEM ERP MedicationDispense BfArM T-Prescription MedicationDispense format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| `gematikMedicationDispense.dosageInstruction` | `bfarmMedicationDispense.dosageInstruction` | TODO |
| `gematikMedicationDispense.whenHandedOver` | `bfarmMedicationDispense.whenHandedOver` | TODO |
| `gematikMedicationDispense.medication` | `bfarmMedicationDispense.medication` | Copy medication; ensure correct mapping from reference is stated |
| `gematikMedicationDispense.status` | `bfarmMedicationDispense.status` | TODO |
| `gematikMedicationDispense.quantity` | `bfarmMedicationDispense.quantity` | TODO |
| `gematikMedicationDispense.performer` | `bfarmMedicationDispense.performer` | Map performer.identifier to a reference to Organization with the identifier value |
