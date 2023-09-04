DADOC	=	adoc
DHTML	=	html

ADOC	=	$(shell find $(DADOC) -name "*.adoc" -type f)

HTML	=	$(patsubst $(DADOC)/%.adoc, $(DHTML)/%.html, $(ADOC))

CADOC	=	asciidoctor --require=asciidoctor-diagram

site: index $(HTML)

index:
	sh ./scripts/index.sh
	
$(DHTML)/%.html: $(DADOC)/%.adoc
	@mkdir -p $(@D)
	@$(CADOC) $(<) -o $(@)

re: clean site

clean:
	rm -rf $(DHTML)
