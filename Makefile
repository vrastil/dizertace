# main file
MAIN := thesis

all: $(MAIN).pdf

# recursive wildcard, from https://stackoverflow.com/questions/2483182/recursive-wildcards-in-gnu-make
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

# LaTeX must be run multiple times to get references right
TEX_CMD := pdflatex -interaction=nonstopmode -halt-on-error $(MAIN).tex
BIB_CMD := biber # bibtex
EPS_CMD := ps2pdf -q -dEPSCrop -dBATCH -dNOPAUSE -sDEVICE\#pdfwrite \
			      -dPDFA -dPDFACompatibilityPolicy\#1 \
				  -sProcessColorModel\#DeviceRGB -dUseCIEColor
CP_DEST := /mnt/c/Users/micha/Downloads/thesis/
# All eps files in img directory
EPS_FILES := $(call rwildcard,img,*.eps)
PDF_FILES := $(EPS_FILES:.eps=-eps-converted-to.pdf)
LOGO := img/logo-en.pdf
LOGO_CON := $(LOGO:.pdf=-converted-to.pdf)

$(MAIN).pdf: FORCE $(PDF_FILES) $(LOGO_CON)
	-@rm $(MAIN).xmpdata
	@echo "Building, latex, 1/4"
	-@$(TEX_CMD) > /dev/null
	@echo "Building, bibtex, 2/4"
	-@$(BIB_CMD) $(MAIN)
	@echo "Building, latex, 3/4"
	-@$(TEX_CMD) > /dev/null
	@echo "Building, latex, 4/4" 
	@$(TEX_CMD)
	-@cp $(MAIN).pdf $(CP_DEST)

eps: $(PDF_FILES) $(LOGO_CON)

$(PDF_FILES): %-eps-converted-to.pdf: %.eps
	@echo "Converting file  $<"
	@$(EPS_CMD) -sOutputFile\#$@ $<

$(LOGO_CON): $(LOGO)
	@echo "Converting file  $<"
	@$(EPS_CMD) -sOutputFile\#$@ $<

rebuild: $(PDF_FILES) $(LOGO_CON)
	-@rm $(MAIN).xmpdata
	@$(TEX_CMD)
	-@cp $(MAIN).pdf $(CP_DEST)

tex: $(PDF_FILES) $(LOGO_CON)
	-@rm $(MAIN).xmpdata
	$(TEX_CMD)

bib:
	$(BIB_CMD) $(MAIN)

rtf:
	latex2rtf $(MAIN).tex
	-@cp $(MAIN).rtf /mnt/c/Users/micha/Downloads/


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
	$(PDF_FILES) \
	pdfa.xmpi

clean:
	@echo "Clean old files"
	@rm -f $(TMP_FILES)

FORCE: ;

.PHONY: clean all tex bib eps