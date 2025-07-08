
**Titel:** E-T-Rezept Structure Map for Medication

**Beschreibung:** Maps a Medication to BfArM T-Prescription Medication format

| Quelle (Eingangsdaten) | Ziel (Ausgabedaten) | Transformation & Beschreibung |
|------------------------|---------------------|-------------------------------|
| ` [Bedingung: meta.profile.contains('KBV_PR_ERP_Medication_PZN')]` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| ` [Bedingung: meta.profile.contains('KBV_PR_ERP_Medication_PZN')]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [KBVPZNMedication](./StructureMap-ERPTPrescriptionStructureMapKBVPZNMedication.html) |
| ` [Bedingung: meta.profile.contains('KBV_PR_ERP_Medication_FreeText')]` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| ` [Bedingung: meta.profile.contains('KBV_PR_ERP_Medication_FreeText')]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [KBVFreeTextMedication](./StructureMap-ERPTPrescriptionStructureMapKBVFreeTextMedication.html) |
| ` [Bedingung: meta.profile.contains('KBV_PR_ERP_Medication_Ingredient')]` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| ` [Bedingung: meta.profile.contains('KBV_PR_ERP_Medication_Ingredient')]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [KBVIngredientMedication](./StructureMap-ERPTPrescriptionStructureMapKBVIngredientMedication.html) |
| ` [Bedingung: meta.profile.contains('KBV_PR_ERP_Medication_Compounding')]` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| ` [Bedingung: meta.profile.contains('KBV_PR_ERP_Medication_Compounding')]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [KBVCompoundingMedication](./StructureMap-ERPTPrescriptionStructureMapKBVCompoundingMedication.html) |
| ` [Bedingung: meta.profile.contains('GEM_ERP_PR_Medication')]` | *(wird bestimmt durch Kontext)* | *(direkte Kopie)* |
| ` [Bedingung: meta.profile.contains('GEM_ERP_PR_Medication')]` | *(wird bestimmt durch Kontext)* | Verwendet Mapping: [GEMMedication](./StructureMap-ERPTPrescriptionStructureMapGEMMedication.html) |
