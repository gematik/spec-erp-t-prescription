RuleSet: sd_structure(url, mode, alias)
* structure[+]
  * url = "{url}"
  * mode = #{mode}
  * alias = "{alias}"

RuleSet: sd_input(name, mode)
* input[+]
  * name = "{name}"
  * type = "{name}"
  * mode = #{mode}

RuleSet: targetCopyVariable(context, to, id)
* target[+]
  * context = "{context}"
  * contextType = #variable
  * element = "{to}"
  * transform = #copy
  * parameter.valueId = "{id}"

RuleSet: treeSource(context, element, variable)
* source[+]
  * context = "{context}"
  * element = "{element}"
  * variable = "{variable}"

RuleSet: treeTarget(context, element, variable)
* target[+]
  * contextType = #variable
  * context = "{context}"
  * element = "{element}"
  * variable = "{variable}"