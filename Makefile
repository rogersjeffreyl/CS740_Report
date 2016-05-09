LATEX=pdflatex

NONSTOP=--interaction=nonstopmode # Let pdflatex compile without interactive user input.

LATEXMK=latexmk
LATEXMKOPT=-pdf
PREVIEW=-pv # Preview 

# Code inspired from - https://drewsilcock.co.uk/using-make-and-latexmk/
MAIN=report
TEX_FILES := $(shell ls *.tex)
SOURCES=$(MAIN).tex Makefile $(TEX_FILES)
#FIGURES := $(shell find pictures/* -type f)

all :	$(MAIN).pdf

.refresh : 
	touch .refresh

$(MAIN).pdf:	$(MAIN).tex .refresh $(SOURCES)
	$(LATEXMK) $(LATEXMKOPT) $(PREVIEW) -pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)
         
force:
	touch .refresh  
	rm $(MAIN).pdf 
	$(LATEXMK) $(LATEXMKOPT) $(PREVIEW) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:  
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk

once:  
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

debug: 
	$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: 
	clean force once all 
