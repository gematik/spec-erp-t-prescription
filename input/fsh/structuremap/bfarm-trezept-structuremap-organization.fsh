RuleSet: trezept-structuremap-organization

// Directory Group
* group[+]
  * name = "DirectoryMapping"
  * typeMode = #none
  * documentation = "Mapping group for directory information transformation"

  * insert sd_input(OrganizationDirectory, source)
  * insert sd_input(LocationDirectory, source)
  * insert sd_input(HealthcareServiceDirectory, source)
  * insert sd_input(bfarmOrganization, target)

// Directory Rules
  * rule[+]
    * name = "name"
    * source.context = "OrganizationDirectory"
    * source.element = "name"
    * source.variable = "orgname"
    * insert targetCopyVariable(bfarmOrganization, name)
    * target[=].variable = "orgname"
    * documentation = "Copy Name to Organization"

  * rule[+]
    * name = "telecom"
    * source.context = "HealthcareServiceDirectory"
    * source.type = "ContactPoint"
    * source.element = "telecom"
    * insert targetCopyVariable(bfarmOrganization, telecom)
    * documentation = "Copy Phone number to Organization"

  * rule[+]
    * name = "address"
    * source.context = "LocationDirectory"
    * source.element = "address"
    * insert targetCopyVariable(bfarmOrganization, address)
    * documentation = "Copy address to Organization"