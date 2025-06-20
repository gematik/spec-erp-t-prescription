Instance: ERP-TPrescription-StructureMap-Medication
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for Medication"
Description: "Maps a Medication to BfArM T-Prescription Medication format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-Medication)

* import[+] = Canonical(ERP-TPrescription-StructureMap-GEM-Medication)
* import[+] = Canonical(ERP-TPrescription-StructureMap-KBV-Compounding-Medication)
* import[+] = Canonical(ERP-TPrescription-StructureMap-KBV-PZN-Medication)
* import[+] = Canonical(ERP-TPrescription-StructureMap-KBV-FreeText-Medication)
* import[+] = Canonical(ERP-TPrescription-StructureMap-KBV-Ingredient-Medication)

* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, source, srcMedication)
* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Medication, target, tgtMedication)

* group[+]
  * name = "erpTMedicationMapping"
  * typeMode = #none
  * documentation = "Mapping group for medication information transformation"

  * insert sd_input(srcMedication, source)
  * insert sd_input(tgtMedication, target)

  // PZN
  * rule[+]
    * name = "decideOnMedication"
    * source[+].context = "srcMedication"
    * source[=].variable = "srcPZN"
    * source[=].condition = "meta.profile.contains('KBV_PR_ERP_Medication_PZN')"
    
    * rule[+]
      * name = "mapPZN"
      * source[+].context = "srcPZN"
      * insert dependent(KBVPZNMedicationMapping, srcMedication, tgtMedication)
  
  // FreeText
  * rule[+]
    * name = "decideOnMedication"
    * source[+].context = "srcMedication"
    * source[=].variable = "srcFreeText"
    * source[=].condition = "meta.profile.contains('KBV_PR_ERP_Medication_FreeText')"
    
    * rule[+]
      * name = "mapFreeText"
      * source[+].context = "srcFreeText"
      * insert dependent(KBVFreeTextMedicationMapping, srcMedication, tgtMedication)
  
  // Ingredient
  * rule[+]
    * name = "decideOnMedication"
    * source[+].context = "srcMedication"
    * source[=].variable = "srcIngredient"
    * source[=].condition = "meta.profile.contains('KBV_PR_ERP_Medication_Ingredient')"
    
    * rule[+]
      * name = "mapIngredient"
      * source[+].context = "srcIngredient"
      * insert dependent(KBVIngredientMedicationMapping, srcMedication, tgtMedication)
  
  // Compounding
  * rule[+]
    * name = "decideOnMedication"
    * source[+].context = "srcMedication"
    * source[=].variable = "srcCompounding"
    * source[=].condition = "meta.profile.contains('KBV_PR_ERP_Medication_Compounding')"
    
    * rule[+]
      * name = "mapCompounding"
      * source[+].context = "srcCompounding"
      * insert dependent(KBVCompoundingMedicationMapping, srcMedication, tgtMedication)
  
  // GematikMedication
  * rule[+]
    * name = "decideOnMedication"
    * source[+].context = "srcMedication"
    * source[=].variable = "srcGemMed"
    * source[=].condition = "meta.profile.contains('GEM_ERP_PR_Medication')"
    
    * rule[+]
      * name = "mapGemMed"
      * source[+].context = "srcGemMed"
      * insert dependent(erpTGemMedicationMapping, srcMedication, tgtMedication)
    

