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

RuleSet: targetCopyVariable(context, to)
* target[+]
  * context = "{context}"
  * contextType = #variable
  * element = "{to}"
  * transform = #copy
