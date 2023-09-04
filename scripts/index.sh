#!/bin/sh

FILE_INDEX=adoc/index.adoc
INDEX_TITLE="My main title"

cat > ${FILE_INDEX} << header
= ${INDEX_TITLE}
:nofooter:
:toc: left
:sectnums:
header

for SECTION in $(find adoc/* -type d -print)
do
	TITLE=$(basename ${SECTION})
	cat >> ${FILE_INDEX} <<- section

	== ${TITLE}

	section
	for PAGE in $(find adoc/${TITLE} -type f)
	do
		CROSS_REF=$(echo ${PAGE} | sed 's/^adoc\///')
		POST=$(basename $PAGE | sed 's/\.adoc//' | sed 's/[-_]/ /g')
		cat >> ${FILE_INDEX} <<- section
		* xref:${CROSS_REF}[${POST}]
		section
	done
done
