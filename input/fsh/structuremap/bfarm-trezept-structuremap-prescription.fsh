RuleSet: trezept-structuremap-prescription
// Prescription Group
* group[+]
  * name = "PrescriptionMapping"
  * typeMode = #none
  * documentation = "Mapping group for prescription transformation"
// TODO multiple sources to target
// Bugfixing qa.html
  // Input parameters
  * insert sd_input(pkcs7, source)
  * insert sd_input(kbvBundle, source)
  * insert sd_input(kbvPrescription, source)
  * insert sd_input(kbvMedicationPZN, source)
  * insert sd_input(kbvMedicationIngredient, source)
  * insert sd_input(kbvMedicationFreeText, source)
  * insert sd_input(kbvMedicationCompounding, source)
  * insert sd_input(erpTCarbonCopy, target)
  * insert sd_input(bfarmPrescribedMedication, target)
  * insert sd_input(bfarmMedicationRequest, target)
  
// Rules for Parameters
  * rule[+]
    * name = "signatureDate"
    * source[+]
      * context = "pkcs7"
      * element = "2.840.113549.1.9.5"
    * target[+]
      * context = "erpTCarbonCopy"
      * contextType = #variable
      * element = "parameter[rxPrescription].part[prescriptionSignatureDate].value"
      * transform = #dateOp
      * parameter.valueString = "yyyy-MM-dd'T'HH:mm:ss[.SSS]"
    * documentation = "Get the signing time from the pkcs#7 signature and transform to FHIR Instant"
  * rule[+]
    * name = "signatureDate"
    * source[+]
      * context = "pkcs7"
      * element = "2.840.113549.1.9.5"
    * target[+]
      * context = "erpTCarbonCopy"
      * contextType = #variable
      * element = "parameter.part.value"
      * transform = #dateOp
      * parameter.valueString = "yyyy-MM-dd'T'HH:mm:ss[.SSS]"
    * documentation = "Get the signing time from the pkcs#7 signature and transform to FHIR Instant"
  * rule[+]
    * name = "signatureDate"
    * source[+]
      * context = "pkcs7"
      * element = "2.840.113549.1.9.5"
    * target[+]
      * context = "erpTCarbonCopy"
      * contextType = #variable
      * element = "parameter[0].part[0].value"
      * transform = #dateOp
      * parameter.valueString = "yyyy-MM-dd'T'HH:mm:ss[.SSS]"
    * documentation = "Get the signing time from the pkcs#7 signature and transform to FHIR Instant"

  * rule[+]
    * name = "prescriptionId"
    * source[+]
      * context = "kbvBundle"
      * element = "identifier.where(system='https://gematik.de/fhir/erp/NamingSystem/GEM_ERP_NS_PrescriptionId').value"
    * insert targetCopyVariable(erpTCarbonCopy, parameter:rxPrescription.part:prescriptionId.value)
    * documentation = "Copy the prescription ID"

// Rules for MedicationRequest
  * rule[+]
    * name = "prescriptionDate"
    * source[+]
      * context = "kbvPrescription"
      * element = "authoredOn"
    * insert targetCopyVariable(bfarmMedicationRequest, authoredOn)
    * documentation = "Copy the date on which the prescription was authored"

  * rule[+]
    * name = "dosageInstruction"
    * source[+]
      * context = "kbvPrescription"
      * element = "dosageInstruction"
    * insert targetCopyVariable(bfarmMedicationRequest, dosageInstruction)
    * documentation = "Copy dosageInstruction; ensure all subfields (e.g., text, timing, route) are mapped appropriately"

  * rule[+]
    * name = "dispenseRequest"
    * source[+]
      * context = "kbvPrescription"
      * element = "dispenseRequest"
    * insert targetCopyVariable(bfarmMedicationRequest, dispenseRequest)
    * documentation = "Copy dispenseRequest; map quantity, validityPeriod, and performer if required"

  * rule[+]
    * name = "medicationReference"
    * source[+]
      * context = "kbvPrescription"
      * element = "medication"
    * insert targetCopyVariable(bfarmMedicationRequest, medication)
    * documentation = "Copy medication; ensure correct mapping from reference is stated"

// Rules for Prescribed Medication
// PZN
  * rule[+]
    * name = "MedicationCodePZN"
    * source[+]
      * context = "kbvMedicationPZN"
      * variable = "pznMedication"
      * element = "code"
      * min = 0
      * max = "1"
    
  * rule[+]
    * name = "MedicationCodeText"
    * source[+]
      * context = "kbvMedicationCompounding"
      * variable = "compoundingMedication"
      * element = "code.text"
      * min = 0
      * max = "1"
    * source[+]
      * context = "kbvMedicationFreeText"
      * variable = "freeTextMedication"
      * min = 0
      * max = "1"
    * insert targetCopyVariable(bfarmPrescribedMedication, code.text)
    * documentation = "Rules for copying a KBV Medication"



    * rule[+]
      * name = "pznMedicationCode"
      * source[+]
        * context = "kbvMedicationPZN"
        * element = "code"
      * insert targetCopyVariable(bfarmPrescribedMedication, code)

    * rule[+]
      * name = "pznMedicationForm"
      * source[+]
        * context = "kbvMedicationPZN"
        * element = "form"
      * insert targetCopyVariable(bfarmPrescribedMedication, form)

    * rule[+]
      * name = "pznMedicationAmount"
      * source[+]
        * context = "kbvMedicationPZN"
        * element = "amount"
      * insert targetCopyVariable(bfarmPrescribedMedication, amount)

    * rule[+]
      * name = "pznMedicationIngredient"
      * source[+]
        * context = "kbvMedicationPZN"
        * element = "ingredient.itemCodeableConcept.text"
      * insert targetCopyVariable(bfarmPrescribedMedication, ingredient.itemCodeableConcept.text)
      
// Ingredient
  * rule[+]
    * name = "ingredientMedication"
    * source[+]
      * context = "kbvMedicationIngredient"
      * min = 0
      * max = "1"
    * documentation = "Rules for copying an Ingredient Medication"

    * rule[+]
      * name = "ingredientMedicationForm"
      * source[+]
        * context = "kbvMedicationIngredient"
        * element = "form"
      * insert targetCopyVariable(bfarmPrescribedMedication, form)

    * rule[+]
      * name = "ingredientMedicationAmount"
      * source[+]
        * context = "kbvMedicationIngredient"
        * element = "amount"
      * insert targetCopyVariable(bfarmPrescribedMedication, amount)

    * rule[+]
      * name = "ingredientMedicationIngredient"
      * source[+]
        * context = "kbvMedicationIngredient"
        * element = "ingredient.itemCodeableConcept.text"
      * insert targetCopyVariable(bfarmPrescribedMedication, ingredient.itemCodeableConcept.text)

  * rule[+]
    * name = "compundingMedication"
    * source[+]
      * context = "kbvMedicationCompounding"
      * min = 0
      * max = "1"
    * documentation = "Rules for copying a Compounding Medication"
    

    * rule[+]
      * name = "compundingMedicationForm"
      * source[+]
        * context = "kbvMedicationCompounding"
        * element = "form"
      * insert targetCopyVariable(bfarmPrescribedMedication, form)

    * rule[+]
      * name = "compundingMedicationAmount"
      * source[+]
        * context = "kbvMedicationCompounding"
        * element = "amount"
      * insert targetCopyVariable(bfarmPrescribedMedication, amount)

    * rule[+]
      * name = "compundingMedicationIngredient"
      * source[+]
        * context = "kbvMedicationCompounding"
        * element = "ingredient.itemCodeableConcept.text"
      * insert targetCopyVariable(bfarmPrescribedMedication, ingredient.itemCodeableConcept.text)

  * rule[+]
    * name = "freetextMedication"
    * source[+]
      * context = "kbvMedicationFreeText"
      * min = 0
      * max = "1"
    * documentation = "Rules for copying a Freetext Medication"
    * rule[+]
      * name = "freetextMedicationCode"
      * source[+]
        * context = "kbvMedicationFreeText"
        * element = "code.text"
      * insert targetCopyVariable(bfarmPrescribedMedication, code.text)

    * rule[+]
      * name = "freetextMedicationForm"
      * source[+]
        * context = "kbvMedicationFreeText.form"
        * element = "text"
      * insert targetCopyVariable(bfarmPrescribedMedication.form, text)

