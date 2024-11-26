#!/bin/bash

OUTPUT_DIR="$1"
SCRIPT_DIR=$(dirname "$0")

if [[ -z "$OUTPUT_DIR" || ! -d "$OUTPUT_DIR" ]]
then
	echo "Please specify a directory to output the .json files to."
	echo "e.g. ~/code/DigitalLibrary/src/Libronix.DigitalLibrary/CitationStyles"
	exit 1
fi

if ! which python3 > /dev/null
then
	echo 'This script requires `python3` to be in your $PATH and executable.'
	exit 1
fi

for style in american-anthropological-association american-political-science-association american-sociological-association apa apa-6th-edition bibtex chicago-fullnote-bibliography christian-writers-manual-of-style din-1505-2 harvard-cite-them-right modern-humanities-research-association modern-language-association modern-language-association-7th-edition modern-language-association-8th-edition pontifical-athenaeum-regina-apostolorum pontifical-biblical-institute refer-bibix ris society-of-biblical-literature-fullnote-bibliography society-of-biblical-literature-fullnote-bibliography-1st-ed turabian-author-date turabian-fullnote-bibliography unified-style-sheet-for-linguistics
do
	echo "Converting $style from CSL to JSON"

	src_file="$SCRIPT_DIR/../$style.csl"

	if [[ ! -f "$src_file" ]]; then
		echo "Error: $src_file missing."
		exit 1
	fi

	python3 "$SCRIPT_DIR/makejson.py" "$src_file" > "$OUTPUT_DIR/$style.json"
done

git_upstream_revision=$(git rev-parse heads/upstream/v1.0.2)
git_thirdparty_revision=$(git rev-parse master)
echo "CSL JSON files generated from upstream revision $git_upstream_revision, master revision $git_thirdparty_revision \
	on $(date)" | tee "$OUTPUT_DIR/csl_revision_info.txt"
