#!/usr/bin/env python3
import sys
import json

def build_path(parents, context, element):
    path = ".".join(parents + [context]) if context else ".".join(parents)
    if element:
        path = f"{path}.{element}" if path else element
    return path

def extract_rules(rules, src_parents=None, tgt_parents=None, mappings=None):
    if mappings is None:
        mappings = []
    if src_parents is None:
        src_parents = []
    if tgt_parents is None:
        tgt_parents = []

    for rule in rules:
        # Only output a row if both 'source' and 'target' are present
        has_source = 'source' in rule and rule['source']
        has_target = 'target' in rule and rule['target']

        if has_source:
            src = rule['source'][0]
            src_path = build_path(src_parents, src.get('context', ''), src.get('element', ''))
            if src.get('condition'):
                src_path += f" [where {src['condition']}]"
        else:
            src_path = ""

        if has_target:
            tgt = rule['target'][0]
            tgt_path = build_path(tgt_parents, tgt.get('context', ''), tgt.get('element', ''))
        else:
            tgt_path = ""

        desc = rule.get('documentation', '')

        if has_source and has_target:
            mappings.append((src_path, tgt_path, desc))

        # Nested rules: update parent paths for recursion
        next_src_parents = src_path.split('.') if src_path else []
        next_tgt_parents = tgt_path.split('.') if tgt_path else []
        if 'rule' in rule:
            extract_rules(rule['rule'], next_src_parents, next_tgt_parents, mappings)
    return mappings

def structuremap_to_markdown(json_data):
    group = json_data['group'][0]
    mappings = extract_rules(group['rule'])
    rows = [
        "| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |",
        "|------------------------|-----------------------|--------------|",
    ]
    for src, tgt, desc in mappings:
        rows.append(f"| `{src}` | `{tgt}` | {desc} |")
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
