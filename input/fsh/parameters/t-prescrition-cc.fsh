Profile: ERP_TPrescription_CarbonCopy
Id: gem-erp-pr-t-carbon-copy
Parent: Parameters
Title: "Digitaler Durchschlag T-Rezept"
Description: "Parameters to send t-prescription Data to BfArM"
* insert Profile(gem-erp-pr-t-carbon-copy)

* parameter ^slicing.discriminator.type = #value
* parameter ^slicing.discriminator.path = "name"
* parameter ^slicing.rules = #closed

* parameter contains 
rxPrescription 1..1 
and rxDispensation 1..1 

* parameter[rxPrescription]
  * name 1..1 MS
  * name = "rxPrescription" (exactly)
  * value[x] 0..0
  * resource 0..0
  * part MS
    * ^slicing.discriminator.type = #value
    * ^slicing.discriminator.path = "name"
    * ^slicing.rules = #open
  * part contains
    prescriptionSignatureDate 1..1 and
    prescriptionId 1..1 and
    medicationRequest 1..1 and
    medication 1..1

  * part[prescriptionSignatureDate]
    * name MS
    * name = "prescriptionSignatureDate"
    * value[x] 1..1 MS
    * value[x] only instant
    * resource 0..0
    * part 0..0
  * part[prescriptionId]
    * name MS
    * name = "prescriptionId"
    * value[x] 1..1 MS
    * value[x] only EPrescriptionId
    * resource 0..0
    * part 0..0 
  * part[medicationRequest]
    * name MS
    * name = "medicationRequest"
    * value[x] 0..0
    * resource 1..1
    * resource only BfArMMedicationRequest
    * part 0..0 
  * part[medication]
    * name MS
    * name = "medication"
    * value[x] 0..0
    * resource 1..1
    * resource only BfArMMedication
    * part 0..0 

* parameter[rxDispensation]
  * name 1..1 MS
  * name = "rxDispensation" (exactly)
  * value[x] 0..0
  * resource 0..0
  * part MS
    * ^slicing.discriminator.type = #value
    * ^slicing.discriminator.path = "name"
    * ^slicing.rules = #open
  * part contains
    medicationDispense 1.. and
    medication 1.. and
    organization 1..1
  * part[medicationDispense]
    * name MS
    * name = "medicationDispense"
    * value[x] 0..0
    * resource 1..1
    * resource only BfArMMedicationDispense
    * part 0..0 
  * part[medication]
    * name MS
    * name = "medication"
    * value[x] 0..0
    * resource 1..1
    * resource only BfArMMedication
    * part 0..0 
  * part[organization]
    * name MS
    * name = "organization"
    * value[x] 0..0
    * resource 1..1
    * resource only TIOrganization //TODO: BfArM Organization
    * part 0..0








