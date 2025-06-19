Profile: ERP_TPrescription_Organization
//Parent: TIOrganization
Parent: Organization // TODO Change when TI 1.1.0 is released
Id: erp-tprescription-organization
Title: "E-T-Rezept Organization"
Description: "Organization Profile for exchange between E-Rezept-Fachdienst and BfArM T-Register"
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