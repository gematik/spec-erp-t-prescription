# Test Case Template

This directory should contain the following FHIR resource JSON files:

## Required Files

### 1. KBV_Prescription.json
- **Resource Type:** MedicationRequest
- **Profile:** https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Prescription
- **Description:** The prescription from the doctor (Verordnung)
- **Key Fields:**
  - status: "active" or "completed"
  - intent: "order"
  - medicationReference: Reference to the KBV Medication
  - dosageInstruction
  - dispenseRequest
  - extension: KBV_EX_ERP_Teratogenic (T-Rezept marker)

### 2. KBV_Medication_*.json (one of the following)

Choose ONE medication type:

#### Option A: KBV_Medication_PZN.json
- **Profile:** https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_PZN
- **Description:** Medication identified by PZN (Pharmazentralnummer)

#### Option B: KBV_Medication_Ingredient.json
- **Profile:** https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_Ingredient
- **Description:** Medication defined by ingredients

#### Option C: KBV_Medication_Compounding.json
- **Profile:** https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_Compounding
- **Description:** Compounded medication (Rezeptur)

#### Option D: KBV_Medication_FreeText.json
- **Profile:** https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Medication_FreeText
- **Description:** Free text medication

### 3. GEM_MedicationDispense.json
- **Resource Type:** MedicationDispense
- **Profile:** https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_MedicationDispense
- **Description:** Dispensing information from pharmacy (Abgabe)
- **Key Fields:**
  - status: "completed"
  - medicationReference: Reference to dispensed medication
  - whenHandedOver: Dispensing timestamp
  - performer: Reference to pharmacy

### 4. GEM_ERP_PR_Medication.json (Optional)
- **Resource Type:** Medication
- **Profile:** https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_Medication
- **Description:** The actual dispensed medication (if different from prescribed)

### 5. VZDSearchSet.json
- **Resource Type:** Bundle
- **Type:** searchset
- **Profile:** Custom VZD SearchSet
- **Description:** Organization data from FHIR-VZD (Verzeichnisdienst)
- **Contains:** Organization resource for the pharmacy

### 6. Task.json
- **Resource Type:** Task
- **Profile:** https://gematik.de/fhir/erp/StructureDefinition/GEM_ERP_PR_Task
- **Description:** E-Rezept Task in closed state
- **Key Fields:**
  - status: "completed"
  - intent: "order"
  - for: Patient reference (can be minimal)
  - authoredOn: Creation timestamp
  - lastModified: Last modification timestamp

## Example Structure

```json
{
  "resourceType": "MedicationRequest",
  "id": "example-prescription-1",
  "meta": {
    "profile": [
      "https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Prescription|1.4"
    ]
  },
  "status": "completed",
  "intent": "order",
  ...
}
```

## Where to Find Examples

Look at the existing mapping bundle example:
```
fsh-generated/resources/Bundle-Mapping-Bundle.json
```

Extract individual resources from this bundle and save them as separate files.

## Quick Start

1. Copy JSON resources into this directory
2. Name them according to the convention above
3. Run the test pipeline: `../../run-all-tests.sh`

## Notes

- All files must be valid JSON
- Resources must conform to their respective profiles
- The T-Rezept extension is required on KBV_Prescription
- VZDSearchSet must contain at least one Organization entry
