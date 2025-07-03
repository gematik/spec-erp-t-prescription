| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `gematikMedicationDispense.dosageInstruction` | `bfarmMedicationDispense.dosageInstruction` | TODO |
| `gematikMedicationDispense.whenHandedOver` | `bfarmMedicationDispense.whenHandedOver` | TODO |
| `gematikMedicationDispense.medication` | `bfarmMedicationDispense.medication` | Copy medication; ensure correct mapping from reference is stated |
| `gematikMedicationDispense.status` | `bfarmMedicationDispense.status` | TODO |
| `gematikMedicationDispense.quantity` | `bfarmMedicationDispense.quantity` | TODO |
| `gematikMedicationDispense.performer` | `bfarmMedicationDispense.performer` | Map performer.identifier to a reference to Organization with the identifier value |
| `gematikMedicationDispense.performer.srcPerformerVar.actor` | `bfarmMedicationDispense.performer.tgtPerformerVar.actor` |  |
| `gematikMedicationDispense.performer.srcPerformerVar.actor.srcPerformerActorVar.identifier.srcPerformerActorIdentifierVar.value` | `tgtPerformerActorVar.reference` |  |
