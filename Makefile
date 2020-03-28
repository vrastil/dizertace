# main file
MAIN := thesis

all: clean $(MAIN).pdf

# LaTeX must be run multiple times to get references right
TEX_CMD := pdflatex -interaction=nonstopmode -halt-on-error $(MAIN).tex
$(MAIN).pdf:
	$(TEX_CMD)
	bibtex $(MAIN)
	$(TEX_CMD)
	$(TEX_CMD)
	cp $(MAIN).pdf /mnt/c/Users/micha/Downloads/ 

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
	rm -f $(TMP_FILES)
