# StructureMap Transformation Report


## Summary

- **Source Resources:** 6
- **Target Parameters:** 3

## Resource Mapping Details

### Medication

#### Source: `Medication/a3ccc266-b033-47cc-9361-98ec450f7db9`

**Target:** ❌ No matching target resource found

---

#### Source: `Medication/8e2e5e65-4c5d-49f2-8efc-c30e40838273`

**Target:** ❌ No matching target resource found

---

### MedicationDispense

#### Source: `MedicationDispense/a7e1d25f-0b0a-40f7-b529-afda48e51b46`

**Target:** `rxDispensation.medicationDispense:MedicationDispense` (`MedicationDispense`)  
**Coverage:** 38.5% (5/13 fields mapped)

| Source Field | Source Value | Target Field | Target Value | Status |
|--------------|--------------|--------------|--------------|--------|
| `medicationReference.reference` | urn:uuid:8e2e5e65-4c5d-49f2-8efc-c30e40838273 | `medicationReference.reference` | urn:uuid:8e2e5e65-4c5d-49f2-8efc-c30e40838273 | ✅ |
| `quantity.unit` | Packung | `quantity.unit` | Packung | ✅ |
| `quantity.value` | 1 | `quantity.value` | 1 | ✅ |
| `status` | completed | `status` | completed | ✅ |
| `whenHandedOver` | 2025-10-30 | `whenHandedOver` | 2025-10-30 | ✅ |
| `id` | a7e1d25f-0b0a-40f7-b529-afda48e51b46 | - | - | ⚠️ |
| `identifier.system` | https://gematik.de/fhir/erp/NamingSystem/GEM_ER... | - | - | ⚠️ |
| `identifier.value` | 160.100.000.000.021.76 | - | - | ⚠️ |
| `performer.actor.identifier.system` | https://gematik.de/fhir/sid/telematik-id | - | - | ⚠️ |
| `performer.actor.identifier.value` | 3-07.2.1234560000.10.789 | - | - | ⚠️ |
| `subject.identifier.system` | http://fhir.de/sid/gkv/kvid-10 | - | - | ⚠️ |
| `subject.identifier.value` | X234567890 | - | - | ⚠️ |
| `substitution.wasSubstituted` | true | - | - | ⚠️ |

**New fields created by transformation:**

| Target Field | Target Value | Status |
|--------------|--------------|--------|
| `performer[0].actor.reference` | Organization/3-07.2.1234560000.10.789 | 🆕 |

---

### MedicationRequest

#### Source: `MedicationRequest/0886a530-68ef-4517-9999-b24f79b08da1`

**Target:** `rxPrescription.medicationRequest:MedicationRequest` (`MedicationRequest`)  
**Coverage:** 55.6% (15/27 fields mapped)

| Source Field | Source Value | Target Field | Target Value | Status |
|--------------|--------------|--------------|--------------|--------|
| `authoredOn` | 2025-05-20 | `authoredOn` | 2025-05-20 | ✅ |
| `dispenseRequest.expectedSupplyDuration.unit` | Woche(n) | `dispenseRequest.expectedSupplyDuration.unit` | Woche(n) | ✅ |
| `dispenseRequest.expectedSupplyDuration.value` | 3 | `dispenseRequest.expectedSupplyDuration.value` | 3 | ✅ |
| `dispenseRequest.quantity.unit` | Packung | `dispenseRequest.quantity.unit` | Packung | ✅ |
| `dispenseRequest.quantity.value` | 1 | `dispenseRequest.quantity.value` | 1 | ✅ |
| `dosageInstruction.doseAndRate.doseQuantity.code` | 1 | `dosageInstruction[0].doseAndRate[0].doseQuantity.code` | 1 | ✅ |
| `dosageInstruction.doseAndRate.doseQuantity.system` | https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP... | `dosageInstruction[0].doseAndRate[0].doseQuantity.system` | https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP... | ✅ |
| `dosageInstruction.doseAndRate.doseQuantity.unit` | Stück | `dosageInstruction[0].doseAndRate[0].doseQuantity.unit` | Stück | ✅ |
| `dosageInstruction.doseAndRate.doseQuantity.value` | 1 | `dosageInstruction[0].doseAndRate[0].doseQuantity.value` | 1 | ✅ |
| `dosageInstruction.timing.repeat.frequency` | 1 | `dosageInstruction[0].timing.repeat.frequency` | 1 | ✅ |
| `dosageInstruction.timing.repeat.period` | 1 | `dosageInstruction[0].timing.repeat.period` | 1 | ✅ |
| `dosageInstruction.timing.repeat.periodUnit` | d | `dosageInstruction[0].timing.repeat.periodUnit` | d | ✅ |
| `intent` | order | `intent` | order | ✅ |
| `medicationReference.reference` | http://pvs.praxis.local/fhir/Medication/a3ccc26... | `medicationReference.reference` | http://pvs.praxis.local/fhir/Medication/a3ccc26... | ✅ |
| `status` | active | `status` | completed | ✅ |
| `dosageInstruction.timing.repeat.when` | MORN | - | - | ⚠️ |
| `extension[0].valueCoding.code` | 0 | - | - | ⚠️ |
| `extension[0].valueCoding.system` | https://fhir.kbv.de/CodeSystem/KBV_CS_FOR_Statu... | - | - | ⚠️ |
| `extension[4].extension[4].valueBoolean` | true | - | - | ⚠️ |
| `extension[5].valueBoolean` | true | - | - | ⚠️ |
| `extension[6].valueMarkdown` | 0-0-1-0 Stück | - | - | ⚠️ |
| `extension[7].extension[0].valueString` | 1.0.0 | - | - | ⚠️ |
| `extension[7].extension[1].valueCode` | de-DE | - | - | ⚠️ |
| `id` | 0886a530-68ef-4517-9999-b24f79b08da1 | - | - | ⚠️ |
| `insurance.reference` | http://pvs.praxis.local/fhir/Coverage/da80211e-... | - | - | ⚠️ |
| `requester.reference` | http://pvs.praxis.local/fhir/Practitioner/d6f3b... | - | - | ⚠️ |
| `subject.reference` | http://pvs.praxis.local/fhir/Patient/ce4104af-b... | - | - | ⚠️ |

**New fields created by transformation:**

| Target Field | Target Value | Status |
|--------------|--------------|--------|
| `subject.extension[0].url` | http://hl7.org/fhir/StructureDefinition/data-ab... | 🆕 |
| `subject.extension[0].valueCode` | not-permitted | 🆕 |

---

### VZDComposite

#### Source: `VZDComposite/VZD-SearchSet-Bundle`

**Target:** `rxDispensation.organization:Organization` (`Organization`)  
**Coverage:** 72.2% (13/18 fields mapped)

| Source Field | Source Value | Target Field | Target Value | Status |
|--------------|--------------|--------------|--------------|--------|
| `address.city` | Großostheim | `address[0].city` | Großostheim | ✅ |
| `address.country` | DE | `address[0].country` | DE | ✅ |
| `address.postalCode` | 63762 | `address[0].postalCode` | 63762 | ✅ |
| `address.state` | Bayern | `address[0].state` | Bayern | ✅ |
| `address.text` | Schwarzwaldstr. 18&#13;&#10;63762&#13;&#10;Groß... | `address[0].text` | Schwarzwaldstr. 18&#13;&#10;63762&#13;&#10;Groß... | ✅ |
| `address.type` | postal | `address[0].type` | postal | ✅ |
| `address.use` | work | `address[0].use` | work | ✅ |
| `identifier[1].system` | https://gematik.de/fhir/sid/telematik-id | `identifier[0].system` | https://gematik.de/fhir/sid/telematik-id | ✅ |
| `identifier[1].value` | 3-Test-APO000053 | `identifier[0].value` | 3-Test-APO000053 | ✅ |
| `name` | Organisation 3-Test-APO000053 | `name` | Organisation 3-Test-APO000053 | ✅ |
| `telecom.system` | phone | `telecom[0].system` | phone | ✅ |
| `telecom.use` | work | `telecom[0].use` | work | ✅ |
| `telecom.value` | 1234 | `telecom[0].value` | 1234 | ✅ |
| `address.line` | Schwarzwaldstr. 18 | - | - | ⚠️ |
| `id` | VZD-SearchSet-Bundle | - | - | ⚠️ |
| `identifier[1].type.coding.code` | PRN | - | - | ⚠️ |
| `identifier[1].type.coding.system` | http://terminology.hl7.org/CodeSystem/v2-0203 | - | - | ⚠️ |
| `sourceResources[2]` | Location | - | - | ⚠️ |

---
