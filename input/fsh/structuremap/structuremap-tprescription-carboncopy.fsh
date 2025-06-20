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
    * source.context = "bundle"
    * insert treeTarget(erpTCarbonCopy, parameter, tgtRxPrescription)
    * insert treeTarget(tgtRxPrescription, part, tgtRxPrescriptionPartId)
    * insert treeTarget(tgtRxPrescription, part, tgtRxPrescriptionPartMR)
    * insert treeTarget(tgtRxPrescription, part, tgtRxPrescriptionPartMed)
    * insert targetSetStringVariable(tgtRxPrescription, name, rxPrescription)

    * rule[+]
      * name = "bundleEntries"
      * insert treeSource(bundle, entry, srcEntryVar)

      * rule[+]
        * name = "rxPrescriptionParameter"
        * insert treeSource(srcEntryVar, resource, srcEntryResourceVar)
        
        // part prescriptionId
        * rule[+]
          * name = "parameterrXPrescriptionPart"
          * source[+].context = "srcEntryResourceVar"
          * source[=].variable = "srcEntryTaskVar"
          * source[=].condition = "ofType(Task)"
          // * source[=].logMessage = "ofType(Task)"
          * insert targetSetStringVariable(tgtRxPrescriptionPartId, name, prescriptionId)
          * insert treeTarget(tgtRxPrescriptionPartId, valueIdentifier, tgtRxPrescriptionPartIdValue)
          * rule[+]
            * name = "parameterrXPrescriptionPartIdentifier"
            * source.context = "srcEntryTaskVar"
            * insert dependent(erpTTaskMapping, srcEntryTaskVar, tgtRxPrescriptionPartIdValue)
        
        // part medicationRequest
        * rule[+]
          * name = "entryMedicationRequest"
          * source[+].context = "srcEntryResourceVar"
          * source[=].variable = "srcEntryBundleMRVar"
          * source[=].condition = "ofType(MedicationRequest)"
          // * source[=].logMessage = "ofType(MedicationRequest)"
          * insert targetSetStringVariable(tgtRxPrescriptionPartMR, name, medicationRequest)
          * rule[+]
            * name = "entryMedicationRequestPart"
            * source.context = "srcEntryBundleMRVar"
            * insert createType(tgtRxPrescriptionPartMR, resource, newMedicationRequest, MedicationRequest)
            * rule[+]
              * name = "entryMedicationRequestPartResourceSet"
              * source.context = "srcEntryBundleMRVar"
              * insert dependent(erpTRequestMapping, srcEntryBundleMRVar, newMedicationRequest)

        // part Medication
        * rule[+]
          * name = "entryMedicationRequestMedication"
          * source[+].context = "srcEntryVar"
          * source[=].variable = "srcMedicationRequestId"
          * source[=].condition = "resource.ofType(MedicationRequest)"
          * source[=].logMessage = "resource.ofType(MedicationRequest)"
          * insert targetSetStringVariable(tgtRxPrescriptionPartMed, name, medication)
          * rule[+]
            * name = "prepMedication"
            * insert treeSource(bundle, entry, srcEntryVar2)
            * rule[+]
              * name = "entryMedicationPrescriptionMedicationPart"
              * source[+].context = "srcEntryVar2"
              * source[=].variable = "srcEntryBundleMRMedIdVar"
              * source[=].condition = "resource.ofType(Medication).where(id=%srcMedicationRequestId.resource.medication.reference.replace('Medication/', '').toString())"
              * source[=].logMessage = "resource.ofType(Medication).where(id=%srcMedicationRequestId.resource.medication.reference.replace('Medication/', '').toString())"
              * insert createType(tgtRxPrescriptionPartMed, resource, newMedicationPrescriptionMedication, Medication)
              * rule[+]
                * name = "entryMedicationPrescriptionMedicationPartResourceSet"
                * source[+].context = "srcEntryBundleMRMedIdVar"
                * source[=].variable = "srcEntryBundleMRMedIdVarRes"
                * source[=].element = "resource"
                * source[=].logMessage = "%srcEntryBundleMRMedIdVar"
                * insert dependent(KBVPZNMedicationMapping, srcEntryBundleMRMedIdVarRes, newMedicationPrescriptionMedication)
                * insert dependent(KBVCompoundingMedicationMapping, srcEntryBundleMRMedIdVarRes, newMedicationPrescriptionMedication)
                * insert dependent(KBVIngredientMedicationMapping, srcEntryBundleMRMedIdVarRes, newMedicationPrescriptionMedication)
                * insert dependent(KBVFreeTextMedicationMapping, srcEntryBundleMRMedIdVarRes, newMedicationPrescriptionMedication)

      // part medication
        // * rule[+]
        //   * name = "entryMedication"
        //   * source[+].context = "bundle"
        //   * source[=].variable = "srcEntryBundlerxPrescriptionMedVar"
        //   // * source[=].condition = "ofType(Medication).where(id=%context.ofType(MedicationRequest).first().medication.reference.replace('Medication/', '')).first()"
        //   * source[=].condition = "%context.entry.where(resource.ofType(Medication) and resource.id=%context.entry.resource.ofType(MedicationRequest).medication.reference.replace('Medication/', ''))"
        //   // * source[=].logMessage = "%context"
        //   * source[=].element = "entry"
        //   * insert targetSetStringVariable(tgtRxPrescriptionPartMed, name, medication)
        //   * insert createType(tgtRxPrescriptionPartMed, resource, newPrescriptionMedication, Medication)
        //   * rule[+]
        //     * name = "entryMedicationPartResourceSet"
        //     * insert treeSource(srcEntryBundlerxPrescriptionMedVar, entry, srcEntryXXVar)
        //     * insert targetSetIdVariable(tgtRxPrescriptionPartMed, resource, srcEntryXXVar)
        //     * rule[+]
            //   * name = "lalala"
            //   * source.context = "srcEntryXXVar"
            // // * source.condition = "ofType(Medication)"
            // // * source.logMessage = "ofType(Medication)"
            //   * insert targetSetIdVariable(tgtRxPrescriptionPartMed, resource, srcEntryXXVar)
            //* insert dependent(KBVPZNMedicationMapping, srcEntryBundlerxPrescriptionMedVar, newPrescriptionMedication)
            // * rule[+]
            //   * name = "createrxPrescriptionMedication"
            //   * source.context = "srcEntryBundlerxPrescriptionMedVar"
            //   // * insert dependent(KBVPZNMedicationMapping, srcEntryBundlerxPrescriptionMedVar, newPrescriptionMedication)
        //   * insert dependent(KBVCompoundingMedicationMapping, srcEntryBundlerxPrescriptionMedVar, newPrescriptionMedication)
        //   * insert dependent(KBVIngredientMedicationMapping, srcEntryBundlerxPrescriptionMedVar, newPrescriptionMedication)
        //   * insert dependent(KBVFreeTextMedicationMapping, srcEntryBundlerxPrescriptionMedVar, newPrescriptionMedication)



  // Parameter rxDispensation
  * rule[+]
    * name = "MedicationDispenseFromBundle"
    * source.context = "bundle"
    * insert treeTarget(erpTCarbonCopy, parameter, tgtRxDispensation)
    * insert treeTarget(tgtRxDispensation, part, tgtRxDispensationPartOrg)
    * insert treeTarget(tgtRxDispensation, part, tgtRxDispensationPartMD)
    * insert treeTarget(tgtRxDispensation, part, tgtRxDispensationPartDispMed)
    * insert targetSetStringVariable(tgtRxDispensation, name, rxDispensation)

    * rule[+]
      * name = "bundleEntries"
      * insert treeSource(bundle, entry, srcEntryVar)

      * rule[+]
        * name = "rxDispensationParameter"
        * insert treeSource(srcEntryVar, resource, srcEntryResourceVar)

        // part Organization
        * rule[+]
          * name = "entryVZDSearchSet"
          * source[+].context = "srcEntryResourceVar"
          * source[=].variable = "srcEntryBundleOrgVar"
          * source[=].condition = "ofType(Bundle).where(entry.first().fullUrl.contains('fhir-directory'))"
          // * source[=].logMessage = "ofType(Bundle).where(entry.first().fullUrl.contains('fhir-directory'))"
          * insert targetSetStringVariable(tgtRxDispensationPartOrg, name, organization)
          * rule[+]
            * name = "entryOrganizationPart"
            * source.context = "srcEntryBundleOrgVar"
            * insert createType(tgtRxDispensationPartOrg, resource, newOrganization, Organization)
            * rule[+]
              * name = "entryOrganizationPartResourceSet"
              * source.context = "srcEntryBundleOrgVar"
              * insert dependent(erpTOrganizationMapping, srcEntryBundleOrgVar, newOrganization)

        // part MedicationDispense
        * rule[+]
          * name = "entryMedicationDispense"
          * source[+].context = "srcEntryResourceVar"
          * source[=].variable = "srcEntryBundleMDVar"
          * source[=].condition = "ofType(MedicationDispense)"
          // * source[=].logMessage = "ofType(MedicationDispense)"
          * insert targetSetStringVariable(tgtRxDispensationPartMD, name, medicationDispense)
          * rule[+]
            * name = "entryMedicationDispensePart"
            * source.context = "srcEntryBundleMDVar"
            * insert createType(tgtRxDispensationPartMD, resource, newMedicationDispense, MedicationDispense)
            * rule[+]
              * name = "entryMedicationDispensePartResourceSet"
              * source.context = "srcEntryBundleMDVar"
              * insert dependent(erpTDispenseMapping, srcEntryBundleMDVar, newMedicationDispense)
        





