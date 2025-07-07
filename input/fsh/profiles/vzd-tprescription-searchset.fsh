Profile: ERP_TPrescription_VZD_SearchSet
Parent: Bundle
Id: erp-tprescription-vzd-searchset
Title: "E-T-Rezept VZD-Searchset"
Description: "Dieses Profil beschreibt die Datenstruktur, die der E-Rezept-Fachdienst nach Suche am FHIR-VZD zurück erhält. Die Angaben einer Apotheke zu Name, Adresse und Telefonnummer sind in den FHIR-Ressourcen Organization, HealthcareService und Location am FHIR-VZD hinterlegt. Dieses Profil dient dazu das Mapping zu beschreiben und zu verstehen."
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
and location 0..1

* entry[organization].resource only OrganizationDirectory
* entry[healthcareservice].resource only HealthcareServiceDirectory
* entry[location].resource only LocationDirectory
  