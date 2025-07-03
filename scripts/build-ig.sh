
# Generate Sushi
sushi .

# Run scripts that need artifacts from IG Publisher
./scripts/fml_table.sh

# Generate IG Publisher Content
./_genonce.sh -no-sushi
