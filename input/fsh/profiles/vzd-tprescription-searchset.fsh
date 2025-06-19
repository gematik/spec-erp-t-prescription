Profile: ERP_TPrescription_VZD_SearchSet
Parent: Bundle
Id: erp-tprescription-vzd-searchset
Title: "E-T-Rezept vzd-searchset"
Description: "vzd-searchset Profile for exchange between E-Rezept-Fachdienst and BfArM T-Register"
* insert Profile(erp-tprescription-vzd-searchset)

* entry
  * ^slicing.discriminator.type = #type
  * ^slicing.discriminator.path = "resource"
  * ^slicing.rules = #open
  * ^slicing.description = "Slicing for Bundle Entries of VZD Searchset"
  * ^slicing.ordered = false

* entry contains 
organization 1..1 
and healthcareservice 1..1 
and location 1..1

* entry[organization].resource only OrganizationDirectory
* entry[healthcareservice].resource only HealthcareServiceDirectory
* entry[location].resource only LocationDirectory
  