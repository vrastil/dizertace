# main file
MAIN := thesis

all: $(MAIN).pdf

# LaTeX must be run multiple times to get references right
TEX_CMD := pdflatex -interaction=nonstopmode -halt-on-error $(MAIN).tex
BIB_BACKEND := biber # bibtex
$(MAIN).pdf: FORCE
	@echo "Building, latex, 1/4"
	-@$(TEX_CMD) > /dev/null
	@echo "Building, bibtex, 2/4"
	-@$(BIB_BACKEND) $(MAIN)
	@echo "Building, latex, 3/4"
	-@$(TEX_CMD) > /dev/null
	@echo "Building, latex, 4/4" 
	@$(TEX_CMD)
	-@cp $(MAIN).pdf /mnt/c/Users/micha/Downloads/

rebuild:
	@$(TEX_CMD)
	-@cp $(MAIN).pdf /mnt/c/Users/micha/Downloads/

tex:
	$(TEX_CMD)

bib:
	$(BIB_BACKEND) $(MAIN)

TMP_FILES := $(MAIN).pdf \
	$(MAIN).aux $(wildcard **/*.aux) \
	$(MAIN).out \
	$(MAIN).bbl \
	$(MAIN).blg \
	$(MAIN).log \
	$(MAIN).toc \
	$(MAIN).ptb \
	$(MAIN).tod \
	$(MAIN).fls \
	$(MAIN).lot \
	$(MAIN).lof \
	$(MAIN).fdb_latexmk \
	$(MAIN).synctex.gz \
	$(MAIN).xmpdata \
	pdfa.xmpi

clean:
	@echo "Clean old files"
	@rm -f $(TMP_FILES)

FORCE: ;

.PHONY: clean all tex bib