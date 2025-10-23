# StructureMap Transformation Report


## Summary

- **Source Resources:** 4
- **Target Parameters:** 2

## Resource Mapping Details

### Medication

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
