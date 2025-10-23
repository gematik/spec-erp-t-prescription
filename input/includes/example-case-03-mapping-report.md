# StructureMap Transformation Report


## Summary

- **Source Resources:** 6
- **Target Parameters:** 5

## Resource Mapping Details

### Medication

#### Source: `Medication/a3ca01a4-92c1-422a-87d9-ef046e94527f`

**Target:** `rxPrescription.medication:Medication` (`Medication`)  
**Coverage:** 28.6% (2/7 fields mapped)

| Source Field | Source Value | Target Field | Target Value | Status |
|--------------|--------------|--------------|--------------|--------|
| `code.text` | Thalidomid 50 mg Hartkapseln 28 Stück | `code.text` | Thalidomid 50 mg Hartkapseln 28 Stück | ✅ |
| `id` | a3ca01a4-92c1-422a-87d9-ef046e94527f | `id` | a3ca01a4-92c1-422a-87d9-ef046e94527f | ✅ |
| `code.coding.code` | freitext | - | - | ⚠️ |
| `code.coding.system` | https://fhir.kbv.de/CodeSystem/KBV_CS_ERP_Medic... | - | - | ⚠️ |
| `extension[0].valueCoding.code` | 02 | - | - | ⚠️ |
| `extension[0].valueCoding.system` | https://fhir.kbv.de/CodeSystem/KBV_CS_ERP_Medic... | - | - | ⚠️ |
| `extension[1].valueBoolean` | false | - | - | ⚠️ |

---

#### Source: `Medication/8e2e5e65-4c5d-49f2-8efc-c30e40838273`

**Target:** `rxDispensation.medication:Medication` (`Medication`)  
**Coverage:** 93.8% (15/16 fields mapped)

| Source Field | Source Value | Target Field | Target Value | Status |
|--------------|--------------|--------------|--------------|--------|
| `amount.denominator.value` | 1 | `amount.denominator.value` | 1 | ✅ |
| `amount.numerator.extension.valueString` | 28 | `amount.numerator.extension[0].valueString` | 28 | ✅ |
| `amount.numerator.unit` | St | `amount.numerator.unit` | St | ✅ |
| `code.coding.code` | 16880629 | `code.coding[0].code` | 16880629 | ✅ |
| `code.coding.system` | http://fhir.de/CodeSystem/ifa/pzn | `code.coding[0].system` | http://fhir.de/CodeSystem/ifa/pzn | ✅ |
| `code.text` | THALIDOMID BMS 50 mg Hartkapseln | `code.text` | THALIDOMID BMS 50 mg Hartkapseln | ✅ |
| `form.coding.code` | TAB | `form.coding[0].code` | TAB | ✅ |
| `form.coding.display` | Tabletten | `form.coding[0].display` | Tabletten | ✅ |
| `form.coding.system` | https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_KBV... | `form.coding[0].system` | https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_KBV... | ✅ |
| `id` | 8e2e5e65-4c5d-49f2-8efc-c30e40838273 | `id` | 8e2e5e65-4c5d-49f2-8efc-c30e40838273 | ✅ |
| `ingredient.itemCodeableConcept.text` | Thalidomid | `ingredient[0].itemCodeableConcept.text` | Thalidomid | ✅ |
| `ingredient.strength.denominator.unit` | Tbl. | `ingredient[0].strength.denominator.unit` | Tbl. | ✅ |
| `ingredient.strength.denominator.value` | 1 | `ingredient[0].strength.denominator.value` | 1 | ✅ |
| `ingredient.strength.numerator.unit` | mg | `ingredient[0].strength.numerator.unit` | mg | ✅ |
| `ingredient.strength.numerator.value` | 50 | `ingredient[0].strength.numerator.value` | 50 | ✅ |
| `batch.lotNumber` | A123456789-1 | - | - | ⚠️ |

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

#### Source: `MedicationRequest/7d871b93-e18c-4865-bad0-6b55196be46b`

**Target:** `rxPrescription.medicationRequest:MedicationRequest` (`MedicationRequest`)  
**Coverage:** 47.1% (8/17 fields mapped)

| Source Field | Source Value | Target Field | Target Value | Status |
|--------------|--------------|--------------|--------------|--------|
| `authoredOn` | 2025-05-20 | `authoredOn` | 2025-05-20 | ✅ |
| `dispenseRequest.expectedSupplyDuration.unit` | Woche(n) | `dispenseRequest.expectedSupplyDuration.unit` | Woche(n) | ✅ |
| `dispenseRequest.expectedSupplyDuration.value` | 9 | `dispenseRequest.expectedSupplyDuration.value` | 9 | ✅ |
| `dispenseRequest.quantity.unit` | Packung | `dispenseRequest.quantity.unit` | Packung | ✅ |
| `dispenseRequest.quantity.value` | 1 | `dispenseRequest.quantity.value` | 1 | ✅ |
| `intent` | order | `intent` | order | ✅ |
| `medicationReference.reference` | urn:uuid:a3ca01a4-92c1-422a-87d9-ef046e94527f | `medicationReference.reference` | urn:uuid:a3ca01a4-92c1-422a-87d9-ef046e94527f | ✅ |
| `status` | active | `status` | completed | ✅ |
| `extension[0].valueCoding.code` | 0 | - | - | ⚠️ |
| `extension[0].valueCoding.system` | https://fhir.kbv.de/CodeSystem/KBV_CS_FOR_Statu... | - | - | ⚠️ |
| `extension[4].extension[4].valueBoolean` | true | - | - | ⚠️ |
| `extension[5].valueBoolean` | false | - | - | ⚠️ |
| `id` | 7d871b93-e18c-4865-bad0-6b55196be46b | - | - | ⚠️ |
| `insurance.reference` | urn:uuid:e51239e1-ba74-48e0-97fb-9754d2b05c60 | - | - | ⚠️ |
| `requester.reference` | urn:uuid:0c4e1a54-8a42-4d3d-a12c-0bbf2db48570 | - | - | ⚠️ |
| `subject.reference` | urn:uuid:30635f5d-c233-4500-94e8-6414940236aa | - | - | ⚠️ |
| `substitution.allowedBoolean` | true | - | - | ⚠️ |

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
