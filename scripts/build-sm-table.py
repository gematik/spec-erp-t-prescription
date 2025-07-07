import sys
import json

def build_fhir_path(parents, context, element):
    # Only include non-variable context parts (skip those starting with 'src' or 'tgt')
    def is_real(part):
        return part and not part.startswith('src') and not part.startswith('tgt')
    parts = [p for p in parents if is_real(p)]
    if is_real(context):
        parts.append(context)
    if element:
        parts.append(element)
    return ".".join(parts)

def should_include(rule):
    return (
        rule.get('documentation') or
        rule.get('dependent') or
        not rule.get('rule')
    )

def extract_relevant_rules(rules, src_parents=None, tgt_parents=None, mappings=None):
    if mappings is None:
        mappings = []
    if src_parents is None:
        src_parents = []
    if tgt_parents is None:
        tgt_parents = []

    for rule in rules:
        has_source = 'source' in rule and rule['source']
        has_target = 'target' in rule and rule['target']

        if has_source:
            src = rule['source'][0]
            src_path = build_fhir_path(src_parents, src.get('context', ''), src.get('element', ''))
            if src.get('condition'):
                src_path += f" [where {src['condition']}]"
        else:
            src_path = ""

        if has_target:
            tgt = rule['target'][0]
            tgt_path = build_fhir_path(tgt_parents, tgt.get('context', ''), tgt.get('element', ''))
        else:
            tgt_path = ""

        desc = rule.get('documentation', '')

        # Gather dependent mapping references
        dependent_links = []
        if 'dependent' in rule:
            for dep in rule['dependent']:
                dep_name = dep.get('name')
                if dep_name:
                    link = f"[{dep_name}](./StructureMap-{dep_name}.html)"
                    dependent_links.append(link)
        # Combine description and mapping references
        if dependent_links:
            ref_text = "Verwendet Mapping: " + ", ".join(dependent_links)
            desc = (desc + "<br>" if desc else "") + ref_text


        # Merge: If this rule has both a target and a dependent, or just one, show them together
        if should_include(rule) and (src_path or tgt_path or desc):
            mappings.append((src_path, tgt_path, desc))

        # Always recurse into nested rules
        if 'rule' in rule:
            next_src_parents = src_path.split('.') if src_path else []
            next_tgt_parents = tgt_path.split('.') if tgt_path else []
            extract_relevant_rules(rule['rule'], next_src_parents, next_tgt_parents, mappings)
    return mappings

def merge_rows(mappings):
    merged = []
    i = 0
    while i < len(mappings):
        src, tgt, desc = mappings[i]
        # Check next row for same source and empty target
        if i+1 < len(mappings):
            next_src, next_tgt, next_desc = mappings[i+1]
            if src == next_src and (tgt == next_tgt or next_tgt == "" or tgt == ""):
                # Merge descriptions, using <br> for line breaks
                combined_desc = "<br>".join(filter(None, [desc, next_desc]))
                merged.append((src, tgt if tgt else next_tgt, combined_desc))
                i += 2
                continue
        merged.append((src, tgt, desc))
        i += 1
    return merged

def structuremap_to_markdown(json_data):
    group = json_data['group'][0]
    mappings = extract_relevant_rules(group['rule'])
    merged_mappings = merge_rows(mappings)
    rows = [
        "| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |",
        "|------------------------|-----------------------|--------------|",
    ]
    for src, tgt, desc in merged_mappings:
        src_simple = src
        tgt_simple = tgt
        rows.append(f"| `{src_simple}` | `{tgt_simple}` | {desc} |")
    return "\n".join(rows)

def main():
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} <StructureMap-file>")
        sys.exit(1)

    file_path = sys.argv[1]
    with open(file_path, encoding="utf-8") as f:
        data = json.load(f)

    print(structuremap_to_markdown(data))

if __name__ == "__main__":
    main()
