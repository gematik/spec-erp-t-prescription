Instance: ERP-TPrescription-StructureMap-CarbonCopy
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for CarbonCopy"
Description: "Maps resources to BfArM T-Prescription CarbonCopy format"
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-CarbonCopy)

* import[+] = Canonical(ERP-TPrescription-StructureMap-MedicationDispense)
* import[+] = Canonical(ERP-TPrescription-StructureMap-MedicationRequest)
* import[+] = Canonical(ERP-TPrescription-StructureMap-Organization)
* import[+] = Canonical(ERP-TPrescription-StructureMap-Task)
* import[+] = Canonical(ERP-TPrescription-StructureMap-GEM-Medication)
* import[+] = Canonical(ERP-TPrescription-StructureMap-KBV-Compounding-Medication)
* import[+] = Canonical(ERP-TPrescription-StructureMap-KBV-PZN-Medication)
* import[+] = Canonical(ERP-TPrescription-StructureMap-KBV-FreeText-Medication)
* import[+] = Canonical(ERP-TPrescription-StructureMap-KBV-Ingredient-Medication)

* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Bundle, source, bundle)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-carbon-copy, target, erpTCarbonCopy)

// Map rxDispense
* group[+]
  * name = "rxDispenseMapping"
  * typeMode = #none
  * documentation = "Mapping group for Bundle to CarbonCopy for rxDispensation"

  * insert sd_input(bundle, source)
  * insert sd_input(erpTCarbonCopy, target)

  // Parameter rxPrescription
  * rule[+]
    * name = "r-rxPrescription"
    * insert treeSource(bundle, entry, srcEntryBundleVar)
    * insert treeTarget(erpTCarbonCopy, parameter, tgtRxPrescription)

    * rule[+]
      * name = "rxPrescriptionParameter"
      * insert treeSource(srcEntryBundleVar, resource, srcEntryTaskVar)
      * source[=].condition = "ofType(Task)"
      * source[=].logMessage = "ofType(Task)"
      * insert targetSetStringVariable(tgtRxPrescription, name, rxPrescription)
      * insert treeTarget(tgtRxPrescription, part, tgtRxPrescriptionPart)

       // part prescriptionId
      * rule[+]
        * name = "parameterrXPrescriptionPart"
        * source.context = "srcEntryTaskVar"
        * insert targetSetStringVariable(tgtRxPrescriptionPart, name, prescriptionId)
        * insert treeTarget(tgtRxPrescriptionPart, valueIdentifier, tgtRxPrescriptionPartId)
        * rule[+]
          * name = "parameterrXPrescriptionPartIdentifier"
          * source.context = "srcEntryTaskVar"
          * insert dependent(erpTTaskMapping, srcEntryTaskVar, tgtRxPrescriptionPartId)

  // Parameter rxDispensation
  * rule[+]
    * name = "MedicationDispenseFromBundle"
    * insert treeSource(bundle, entry, srcEntryBundleVar)
    * insert treeTarget(erpTCarbonCopy, parameter, tgtParameterDispense)
    
    * rule[+]
      * name = "entryMedicationDispense"
      * insert treeSource(srcEntryBundleVar, resource, srcEntryBundleMDVar)
      * source[=].condition = "ofType(MedicationDispense)"
      * source[=].logMessage = "ofType(MedicationDispense)"
      * insert targetSetStringVariable(tgtParameterDispense, name, rxDispensation)
      * insert treeTarget(tgtParameterDispense, part, tgtParameterPartDispense)
      * rule[+]
        * name = "entryMedicationDispensePart"
        * insert treeSource(srcEntryBundleVar, resource, srcEntryBundleMDVar)
        * insert targetSetStringVariable(tgtParameterPartDispense, name, medicationDispense)
        * insert createType(tgtParameterPartDispense, resource, newMedicationDispense, MedicationDispense)
        * rule[+]
          * name = "entryMedicationDispensePartResourceSet"
          * insert treeSource(srcEntryBundleVar, resource, srcEntryBundleMDVar)
          * insert dependent(erpTDispenseMapping, srcEntryBundleMDVar, newMedicationDispense)
        * documentation = "TODO"





