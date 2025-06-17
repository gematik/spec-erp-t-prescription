Instance: ExampleOrganization-T
InstanceOf: ERP_TPrescription_Organization
Title: "Example Organization"
Description: "An example pharmacy organization"
* name = "Stadt-Apotheke"
* address[+]
  * line[+] = "Hauptstraße 10"
  * city = "Beispielstadt"
  * postalCode = "54321"
  * country = "DE"
* telecom[+]
  * system = #phone
  * value = "+49 987 6543210"
