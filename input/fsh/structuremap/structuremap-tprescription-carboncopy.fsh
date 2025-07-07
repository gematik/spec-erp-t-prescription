Instance: ERP-TPrescription-StructureMap-CarbonCopy
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for CarbonCopy"
Description: "Diese Ressource beschreibt das Mapping und führt die Mappings aller Teilressourcen zusammen. Weitere Informationen und Beschreibungen zum Mapping können auf der Seite [Mapping des digitalen Durchschlag E-T-Rezept](./trezept.html#mapping-des-digitalen-durchschlag-e-t-rezept) eingesehen werden."
* insert Instance(StructureMap, ERP-TPrescription-StructureMap-CarbonCopy)

* import[+] = Canonical(ERP-TPrescription-StructureMap-MedicationDispense)
* import[+] = Canonical(ERP-TPrescription-StructureMap-MedicationRequest)
* import[+] = Canonical(ERP-TPrescription-StructureMap-Organization)
* import[+] = Canonical(ERP-TPrescription-StructureMap-Task)
* import[+] = Canonical(ERP-TPrescription-StructureMap-Medication)

* insert sd_structure(http://hl7.org/fhir/StructureDefinition/Bundle, source, bundle)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-carbon-copy, target, erpTCarbonCopy)

// Map rxDispense
* group[+]
  * name = "erpTPrescriptionCarbonCopy"
  * typeMode = #none
  * documentation = "Mapping des digitalen Durchschlags T-Rezept"

  * insert sd_input(bundle, source)
  * insert sd_input(erpTCarbonCopy, target)

  // set status to completed
  * rule[+]
    * name = "tgtMeta"
    * source.context = "bundle"
    * insert treeTarget(erpTCarbonCopy, meta, erpTCarbonCopyMeta)
    * rule[+]
      * name = "tgtMetaProfile"
      * source.context = "bundle"
      * insert setMetaProfileCC(erpTCarbonCopyMeta, profile)
      * documentation = "Setzt das meta.profile des digitalen Durchschlags T-Rezept"

  // Parameter rxPrescription
  * rule[+]
    * name = "rxPrescriptionRule"
    * source.context = "bundle"
    * documentation = "Mapping der Rezeptinformationen"
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
          * insert createType(tgtRxPrescriptionPartId, value, newIdentifier, Identifier)
          * documentation = "Mappt die E-Rezept-ID des Tasks in den digitalen Durchschlag"
          * rule[+]
            * name = "parameterrXPrescriptionPartIdentifier"
            * source.context = "srcEntryTaskVar"
            * insert dependent(ERP-TPrescription-StructureMap-Task, srcEntryTaskVar, newIdentifier)
          
        
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
            * documentation = "Mappt den KBV-MedicationRequest auf das BfArM MedicationRequest Zielprofil"
            * rule[+]
              * name = "entryMedicationRequestPartResourceSet"
              * source.context = "srcEntryBundleMRVar"
              * insert dependent(ERP-TPrescription-StructureMap-MedicationRequest, srcEntryBundleMRVar, newMedicationRequest)

        // part Medication
        * rule[+]
          * name = "entryMedicationRequestMedication"
          * source[+].context = "srcEntryVar"
          * source[=].variable = "srcMedicationRequestId"
          * source[=].condition = "resource.ofType(MedicationRequest)"
          // * source[=].logMessage = "resource.ofType(MedicationRequest)"
          * insert targetSetStringVariable(tgtRxPrescriptionPartMed, name, medication)
          * rule[+]
            * name = "prepMedication"
            * insert treeSource(bundle, entry, srcEntryVar2)
            * rule[+]
              * name = "entryMedicationPrescriptionMedicationPart"
              * source[+].context = "srcEntryVar2"
              * source[=].variable = "srcEntryBundleMRMedIdVar"
              * source[=].condition = "resource.ofType(Medication).where(id=%srcMedicationRequestId.resource.medication.reference.replace('Medication/', '').toString())"
              // * source[=].logMessage = "resource.ofType(Medication).where(id=%srcMedicationRequestId.resource.medication.reference.replace('Medication/', '').toString())"
              * insert createType(tgtRxPrescriptionPartMed, resource, newMedicationPrescriptionMedication, Medication)
              * documentation = "Mappt die KBV-Medication auf das BfArM Medication Zielprofil"
              * rule[+]
                * name = "entryMedicationPrescriptionMedicationPartResourceSet"
                * source[+].context = "srcEntryBundleMRMedIdVar"
                * source[=].variable = "srcEntryBundleMRMedIdVarRes"
                * source[=].element = "resource"
                // * source[=].logMessage = "%srcEntryBundleMRMedIdVar"
                * insert dependent(ERP-TPrescription-StructureMap-Medication, srcEntryBundleMRMedIdVarRes, newMedicationPrescriptionMedication)

  // Parameter rxDispensation
  * rule[+]
    * name = "MedicationDispenseFromBundle"
    * source.context = "bundle"
    * documentation = "Mapping der Abgabeinformationen"
    * insert treeTarget(erpTCarbonCopy, parameter, tgtRxDispensation)
    * insert treeTarget(tgtRxDispensation, part, tgtRxDispensationPartOrg)
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
            * documentation = "Mapping des FHIR-VZD Search Sets in eine BfArM Organization"
            * rule[+]
              * name = "entryOrganizationPartResourceSet"
              * source.context = "srcEntryBundleOrgVar"
              * insert dependent(ERP-TPrescription-StructureMap-Organization, srcEntryBundleOrgVar, newOrganization)

        // part MedicationDispense
        * rule[+]
          * name = "entryMedicationDispense"
          * source[+].context = "srcEntryResourceVar"
          * source[=].variable = "srcEntryBundleMDVar"
          * source[=].condition = "ofType(MedicationDispense)"
          //* source[=].logMessage = "ofType(MedicationDispense)"
          * insert treeTarget(tgtRxDispensation, part, tgtRxDispensationPartMD)
          * rule[+]
            * name = "entryMedicationDispensePart"
            * source.context = "srcEntryBundleMDVar"
            * insert targetSetStringVariable(tgtRxDispensationPartMD, name, medicationDispense)
            * insert createType(tgtRxDispensationPartMD, resource, newMedicationDispense, MedicationDispense)
            * documentation = "Mappt die Abgabeinforamtionen der Apotheke auf das BfArM MedicationDispense Zielprofil"
            * rule[+]
              * name = "entryMedicationDispensePartResourceSet"
              * source.context = "srcEntryBundleMDVar"
              * insert dependent(ERP-TPrescription-StructureMap-MedicationDispense, srcEntryBundleMDVar, newMedicationDispense)
        
        // part Medication
        * rule[+]
          * name = "entryMedicationDispenseMedication"
          * source[+].context = "srcEntryVar"
          * source[=].variable = "srcMedicationDispenseId"
          * source[=].condition = "resource.ofType(MedicationDispense)"
          //* source[=].logMessage = "resource.ofType(MedicationDispense)"
          * insert treeTarget(tgtRxDispensation, part, tgtRxDispensationPartDispMed)
          * insert targetSetStringVariable(tgtRxDispensationPartDispMed, name, medication)
          * rule[+]
            * name = "prepMedication"
            * insert treeSource(bundle, entry, srcEntryVar2)
            * rule[+]
              * name = "entryMedicationDispensationMedicationPart"
              * source[+].context = "srcEntryVar2"
              * source[=].variable = "srcEntryBundleMDMedIdVar"
              * source[=].condition = "resource.ofType(Medication).where(id=%srcMedicationDispenseId.resource.medication.reference.replace('Medication/', '').toString())"
              // * source[=].logMessage = "resource.ofType(Medication).where(id=%srcMedicationDispenseId.resource.medication.reference.replace('Medication/', '').toString())"
              * documentation = "Mappt die Informationen des abgegebenen Arzneimittels auf das BfArM Medication Zielprofil"
              * insert createType(tgtRxDispensationPartDispMed, resource, newMedicationDispensationMedication, Medication)
              * rule[+]
                * name = "entryMedicationDispensationMedicationPartResourceSet"
                * source[+].context = "srcEntryBundleMDMedIdVar"
                * source[=].variable = "srcEntryBundleMDMedIdVarRes"
                * source[=].element = "resource"
                // * source[=].logMessage = "%srcEntryBundleMDMedIdVar"
                * insert dependent(ERP-TPrescription-StructureMap-Medication, srcEntryBundleMDMedIdVarRes, newMedicationDispensationMedication)





