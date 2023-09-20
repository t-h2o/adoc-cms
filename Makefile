DADOC	=	adoc
DHTML	=	docs

ADOC	=	$(shell find $(DADOC) -name "*.adoc" -type f)
NOTADOC	=	$(shell find $(DADOC) ! -name "*.adoc" ! -name ".*" -type f)

HTML	=	$(patsubst $(DADOC)/%.adoc, $(DHTML)/%.html, $(ADOC))
NOTHTML	=	$(patsubst $(DADOC)/%, $(DHTML)/%, $(NOTADOC))

CADOC	=	asciidoctor --require=asciidoctor-diagram

site: index $(HTML) copy

index:
	sh ./scripts/index.sh

$(DHTML)/%.html: $(DADOC)/%.adoc
	@mkdir -p $(@D)
	@$(CADOC) $(<) -o $(@)

sitedocker:
	docker run \
	--rm \
	--volume $(shell pwd):/documents/ \
	asciidoctor/docker-asciidoctor \
	make site

re: clean site

clean:
	rm -rf $(DHTML)

copy: $(NOTHTML)

# copy extra contents as files or images
$(DHTML)/%: $(DADOC)/%
	@mkdir -p $(@D)
	@cp $(<) $(@)
