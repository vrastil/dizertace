# main file
MAIN := thesis
DEPENDENCY := $(MAIN).tex

# all tex files in the project
DEPENDENCY += $(wildcard **/*.tex)

# bibliography
DEPENDENCY += bibliography/bibliography.bib

# PDF metadata
DEPENDENCY += preamble/thesis.xmpdata

all: $(MAIN).pdf

# LaTeX must be run multiple times to get references right
$(MAIN).pdf: $(DEPENDENCY)
	pdflatex $<
	bibtex thesis
	pdflatex $<
	pdflatex $<

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
	pdfa.xmpi

clean:
	rm -f $(TMP_FILES)
