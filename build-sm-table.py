import re

def clean_path(path):
    path = re.sub(r'\s+as\s+\w+', '', path)
    path = re.sub(r'(\.\w+)\s*=\s*([a-zA-Z_]\w*)', r'\1', path)
    return path.strip()

def parse_fml_hierarchical(fml_lines):
    var_stack = [{}]
    mappings = []

    rule_re = re.compile(
        r'(?P<src>[\w.]+)(?:\s+as\s+(?P<srcvar>\w+))?(?:\s+where\s+(?P<srcwhere>[^-]+))?\s*->\s*'
        r'(?P<tgt>[\w.]+)(?:\s+as\s+(?P<tgtvar>\w+))?(?:\s*=\s*(?P<tgtassign>[^ "]+))?(?:\s*"(?P<desc>[^"]*)")?'
    )
    open_block_re = re.compile(r'\bthen\s*{')
    close_block_re = re.compile(r'^}')
    comment_re = re.compile(r'//.*')

    for line in fml_lines:
        line = comment_re.sub('', line).strip()
        if not line:
            continue

        m = rule_re.match(line)
        if m:
            src = m.group('src')
            srcvar = m.group('srcvar')
            srcwhere = m.group('srcwhere')
            tgt = m.group('tgt')
            tgtvar = m.group('tgtvar')
            tgtassign = m.group('tgtassign')
            desc = m.group('desc') or ""

            # Build full source path and where clause (recursive, propagating where)
            src_full, src_where = resolve_var_path_with_where(src, var_stack)
            if srcwhere:
                src_where = srcwhere.strip()

            src_full_with_where = src_full
            if src_where:
                src_full_with_where += f" [where {src_where}]"

            if srcvar:
                var_stack[-1][srcvar] = (src_full, src_where)

            tgt_full, _ = resolve_var_path_with_where(tgt, var_stack, include_where=False)
            if tgtassign:
                if tgtassign.startswith("'") or tgtassign.startswith('"') or tgtassign.replace('.', '', 1).isdigit():
                    tgt_full += f" = {tgtassign.strip()}"
            if tgtvar:
                var_stack[-1][tgtvar] = (tgt_full, None)

            src_full_clean = clean_path(src_full_with_where)
            tgt_full_clean = clean_path(tgt_full)

            mappings.append((src_full_clean, tgt_full_clean, desc.strip()))

        if open_block_re.search(line):
            var_stack.append(var_stack[-1].copy())

        if close_block_re.match(line):
            if len(var_stack) > 1:
                var_stack.pop()

    return mappings

def resolve_var_path_with_where(path, var_stack, include_where=True):
    parts = path.split('.')
    where_clause = None
    current_path = []
    for i, part in enumerate(parts):
        found = False
        for scope in reversed(var_stack):
            if part in scope:
                base_path, base_where = scope[part]
                current_path = base_path.split('.')  # absolute path
                if base_where:
                    where_clause = base_where
                found = True
                break
        if not found:
            current_path.append(part)
    full_path = '.'.join(current_path)
    if include_where:
        return full_path, where_clause
    else:
        return full_path, None

def fml_to_markdown_table_hier_from_string(fml_string):
    fml_lines = fml_string.splitlines()
    mappings = parse_fml_hierarchical(fml_lines)
    table = [
        "| Quell-Element (Source) | Ziel-Element (Target) | Beschreibung |",
        "|------------------------|-----------------------|--------------|"
    ]
    for src, tgt, desc in mappings:
        table.append(f"| `{src}` | `{tgt}` | {desc} |")
    return "\n".join(table)

# For CLI usage
if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python fml2md_hier.py <path_to_fml_file>")
        sys.exit(1)
    fml_path = sys.argv[1]
    with open(fml_path, encoding="utf-8") as f:
        fml_string = f.read()
    md_table = fml_to_markdown_table_hier_from_string(fml_string)
    print(md_table)
