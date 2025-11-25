Instance: ERPTPrescriptionStructureMapMedicationRequest
InstanceOf: StructureMap
Usage: #definition
Title: "E-T-Rezept Structure Map for MedicationRequest"
Description: "Mapping-Anweisungen zur Transformation von KBV MedicationRequest zu BfArM T-Prescription MedicationRequest"
* insert Instance(StructureMap, ERPTPrescriptionStructureMapMedicationRequest)
* insert sd_structure(https://fhir.kbv.de/StructureDefinition/KBV_PR_ERP_Prescription, source, kbvMedicationRequest)
* insert sd_structure(https://gematik.de/fhir/erp-t-prescription/StructureDefinition/erp-tprescription-medication-request, target, bfarmMedicationRequest)

* group[+]
  * name = "ERPTPrescriptionStructureMapMedicationRequest"
  * typeMode = #none
  * documentation = "Mapping-Anweisungen zur Transformation von KBV MedicationRequest zu BfArM T-Prescription MedicationRequest"

  * insert sd_input(kbvMedicationRequest, source)
  * insert sd_input(bfarmMedicationRequest, target)

  // set status to completed
  * rule[+]
    * name = "medicationRequestStatus"
    * insert treeSource(kbvMedicationRequest, status, srcStatus)
    * insert targetSetStringVariable(bfarmMedicationRequest, status, completed)
    * documentation = "Setzt den Status auf 'completed' für den digitalen Durchschlag (Verschreibung ist bereits abgeschlossen)"

  // set intent to order
  * rule[+]
    * name = "medicationRequestIntent"
    * source.context = "kbvMedicationRequest"
    * source.element = "intent"
    * insert targetSetStringVariable(bfarmMedicationRequest, intent, order)
    * documentation = "Setzt den Intent auf 'order' entsprechend der BfArM-Spezifikation für T-Prescription"

  //Copy T-Prescription Extensions
  * rule[+]
    * name = "medicationRequestExt"
    * documentation = "Mappt T-Rezept spezifische Extensions vom KBV- zum BfArM-Format"
    * insert treeSource(kbvMedicationRequest, extension, extVar)
    * source[=].condition = "url='https://fhir.kbv.de/StructureDefinition/KBV_EX_ERP_Teratogenic'"
    * insert treeTarget(bfarmMedicationRequest, extension, tgtExtVar)
    * rule[+]
      * name = "copyTPrescriptionExtensionUrl"
      * documentation = "Kopiert teratogene Extensions für T-Rezept Kennzeichnung"
      * source[+].context = "extVar"
      * source[=].variable = "extMatchVar"
      * insert targetSetStringVariable(tgtExtVar, url,  https://gematik.de/fhir/epa-medication/StructureDefinition/epa-teratogenic-extension)
    * rule[+]
      * name = "mapOffLabelExtension"
      * documentation = "Mappt Off-Label Extension"
      * insert treeSource(extVar, extension, offLabelVar)
      * source[=].condition = "url='Off-Label'"
      * insert createType(tgtExtVar, extension, tgtOffLabelExt, Extension)
      * insert targetSetStringVariable(tgtOffLabelExt, url, off-label)
      * rule[+]
        * name = "mapOffLabelValue"
        * documentation = "Übernimmt den Off-Label Booleschen Wert"
        * insert treeSource(offLabelVar, valueBoolean, offLabelValue)
        * insert targetSetIdVariable(tgtOffLabelExt, valueBoolean, offLabelValue)
    * rule[+]
      * name = "mapGebaerfaehigeFrauExtension"
      * documentation = "Mappt GebaerfaehigeFrau Extension zu childbearing-potential"
      * insert treeSource(extVar, extension, gebaerfaehigeFrauVar)
      * source[=].condition = "url='GebaerfaehigeFrau'"
      * insert createType(tgtExtVar, extension, tgtGebaerfaehigeFrauExt, Extension)
      * insert targetSetStringVariable(tgtGebaerfaehigeFrauExt, url, childbearing-potential)
      * rule[+]
        * name = "mapGebaerfaehigeFrauValue"
        * documentation = "Übernimmt den Booleschen Wert für childbearing-potential"
        * insert treeSource(gebaerfaehigeFrauVar, valueBoolean, gebaerfaehigeFrauValue)
        * insert targetSetIdVariable(tgtGebaerfaehigeFrauExt, valueBoolean, gebaerfaehigeFrauValue)
    * rule[+]
      * name = "mapEinhaltungSicherheitsmassnahmenExtension"
      * documentation = "Mappt EinhaltungSicherheitsmassnahmen Extension zu security-compliance"
      * insert treeSource(extVar, extension, sicherheitsVar)
      * source[=].condition = "url='EinhaltungSicherheitsmassnahmen'"
      * insert createType(tgtExtVar, extension, tgtSicherheitsExt, Extension)
      * insert targetSetStringVariable(tgtSicherheitsExt, url, security-compliance)
      * rule[+]
        * name = "mapEinhaltungSicherheitsmassnahmenValue"
        * documentation = "Übernimmt den Booleschen Wert für security-compliance"
        * insert treeSource(sicherheitsVar, valueBoolean, sicherheitsValue)
        * insert targetSetIdVariable(tgtSicherheitsExt, valueBoolean, sicherheitsValue)
    * rule[+]
      * name = "mapAushaendigungInformationsmaterialienExtension"
      * documentation = "Mappt AushaendigungInformationsmaterialien Extension zu hand-out-information-material"
      * insert treeSource(extVar, extension, infoMatVar)
      * source[=].condition = "url='AushaendigungInformationsmaterialien'"
      * insert createType(tgtExtVar, extension, tgtInfoMatExt, Extension)
      * insert targetSetStringVariable(tgtInfoMatExt, url, hand-out-information-material)
      * rule[+]
        * name = "mapAushaendigungInformationsmaterialienValue"
        * documentation = "Übernimmt den Booleschen Wert für hand-out-information-material"
        * insert treeSource(infoMatVar, valueBoolean, infoMatValue)
        * insert targetSetIdVariable(tgtInfoMatExt, valueBoolean, infoMatValue)
    * rule[+]
      * name = "mapErklaerungSachkenntnisExtension"
      * documentation = "Mappt ErklaerungSachkenntnis Extension zu declaration-of-expertise"
      * insert treeSource(extVar, extension, sachkenntnisVar)
      * source[=].condition = "url='ErklaerungSachkenntnis'"
      * insert createType(tgtExtVar, extension, tgtSachkenntnisExt, Extension)
      * insert targetSetStringVariable(tgtSachkenntnisExt, url, declaration-of-expertise)
      * rule[+]
        * name = "mapErklaerungSachkenntnisValue"
        * documentation = "Übernimmt den Booleschen Wert für declaration-of-expertise"
        * insert treeSource(sachkenntnisVar, valueBoolean, sachkenntnisValue)
        * insert targetSetIdVariable(tgtSachkenntnisExt, valueBoolean, sachkenntnisValue)

  // set subject to not-permitted
  * rule[+]
    * name = "medicationRequestsubject"
    * documentation = "Entfernt Patientenbezug durch data-absent-reason Extension für Datenschutz im digitalen Durchschlag"
    * insert treeSource(kbvMedicationRequest, subject, srcSubject)
    * insert treeTarget(bfarmMedicationRequest, subject, tgtSubject)
    * rule[+]
      * name = "medicationRequestsubjectExtension"
      * documentation = "Erstellt data-absent-reason Extension für Subject"
      * insert treeSource(kbvMedicationRequest, subject, srcSubject)
      * insert treeTarget(tgtSubject, extension, tgtSubjectExtension)
      * rule[+]
        * name = "medicationRequestsubjectExtensionContent"
        * documentation = "Setzt data-absent-reason auf 'not-permitted' um Patientendaten zu anonymisieren"
        * insert treeSource(kbvMedicationRequest, subject, srcSubject)
        * insert targetSetStringVariable(tgtSubjectExtension, url, http://hl7.org/fhir/StructureDefinition/data-absent-reason)
        * insert targetSetCodeVariable(tgtSubjectExtension, value, not-permitted)

  // authoredOn
  * rule[+]
    * name = "medicationRequestAuthoredOn"
    * insert treeSource(kbvMedicationRequest, authoredOn, srcAuthoredOnVar)
    * insert targetSetIdVariable(bfarmMedicationRequest, authoredOn, srcAuthoredOnVar)
    * documentation = "Übernimmt das Verschreibungsdatum unverändert vom KBV MedicationRequest"

  // dosageInstruction
  * rule[+]
    * name = "medicationRequestDosageInstruction"
    * insert treeSource(kbvMedicationRequest, dosageInstruction, srcDosageInstructionVar)
    * insert targetSetIdVariable(bfarmMedicationRequest, dosageInstruction, srcDosageInstructionVar)
    * documentation = "Kopiert die Dosierungsanweisungen vollständig für den digitalen Durchschlag"

  // dispenseRequest
  * rule[+]
    * name = "medicationRequestDispenseRequest"
    * insert treeSource(kbvMedicationRequest, dispenseRequest, srcDispenseRequestVar)
    * insert targetSetIdVariable(bfarmMedicationRequest, dispenseRequest, srcDispenseRequestVar)
    * documentation = "Übernimmt Abgabeanweisungen (Menge, Wiederholungen) aus der ursprünglichen Verschreibung"

  // reference to Medication
  * rule[+]
    * name = "medicationReference"
    * insert treeSource(kbvMedicationRequest, medicationReference, medicationVar)
    * insert treeTarget(bfarmMedicationRequest, medicationReference, tgtMedicationVar)
    * target[+]
      * context = "tgtMedicationVar"
      * contextType = #variable
      * element = "reference"
      * transform = #evaluate
      * parameter[+].valueString = "iif(%medicationVar.reference.startsWith('urn:uuid:'), %medicationVar.reference, 'urn:uuid:' & %medicationVar.reference.replaceMatches('.*[:/]', '')).toString()"
     