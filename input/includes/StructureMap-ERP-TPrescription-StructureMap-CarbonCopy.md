| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |
|------------------------|-----------------------|--------------|
| `bundle` | `erpTCarbonCopy.meta` | TODO |
| `bundle.bundle` | `erpTCarbonCopy.meta.erpTCarbonCopyMeta.profile` |  |
| `bundle` | `erpTCarbonCopy.parameter` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryResourceVar [where ofType(Task)]` | `tgtRxPrescriptionPartId.name` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryResourceVar [where ofType(MedicationRequest)]` | `tgtRxPrescriptionPartMR.name` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryResourceVar [where ofType(MedicationRequest)].srcEntryBundleMRVar` | `tgtRxPrescriptionPartMR.name.tgtRxPrescriptionPartMR.resource` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryVar [where resource.ofType(MedicationRequest)]` | `tgtRxPrescriptionPartMed.name` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryVar [where resource.ofType(MedicationRequest)].bundle.entry.srcEntryVar2 [where resource.ofType(Medication).where(id=%srcMedicationRequestId.resource.medication.reference.replace('Medication/', '').toString())]` | `tgtRxPrescriptionPartMed.resource` |  |
| `bundle` | `erpTCarbonCopy.parameter` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryResourceVar [where ofType(Bundle).where(entry.first().fullUrl.contains('fhir-directory'))]` | `tgtRxDispensationPartOrg.name` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryResourceVar [where ofType(Bundle).where(entry.first().fullUrl.contains('fhir-directory'))].srcEntryBundleOrgVar` | `tgtRxDispensationPartOrg.name.tgtRxDispensationPartOrg.resource` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryResourceVar [where ofType(MedicationDispense)]` | `tgtRxDispensation.part` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryResourceVar [where ofType(MedicationDispense)].srcEntryBundleMDVar` | `tgtRxDispensation.part.tgtRxDispensationPartMD.name` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryVar [where resource.ofType(MedicationDispense)]` | `tgtRxDispensation.part` |  |
| `bundle.bundle.entry.srcEntryVar.resource.srcEntryVar [where resource.ofType(MedicationDispense)].bundle.entry.srcEntryVar2 [where resource.ofType(Medication).where(id=%srcMedicationDispenseId.resource.medication.reference.replace('Medication/', '').toString())]` | `tgtRxDispensationPartDispMed.resource` |  |
