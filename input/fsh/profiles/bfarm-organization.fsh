Profile: ERP_TPrescription_Organization
Parent: TIOrganization
Id: erp-tprescription-organization
Title: "E-T-Rezept Organization"
Description: "Anagaben zu einer Apotheke, die der E-Rezept Fachdienst für das T-Register bereitstellt."
* insert Profile(erp-tprescription-organization)

* telecom MS
* name MS
* address MS

// Forbidden Elements
* identifier 0..0
* active 0..0
* type 0..0
* alias 0..0
* partOf 0..0
* contact 0..0
* endpoint 0..0