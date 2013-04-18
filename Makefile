LATEX = pdflatex -shell-escape

TEXDEPS = analysis.tex github.bib

all: github.pdf

%.pdf %.aux %.bbl: %.tex $(TEXDEPS)
	$(LATEX) $<
	bibtex $*
	$(LATEX) $<
	while fgrep -is 'Rerun to get' $*.log; do $(LATEX) $<; done

analysis.tex: analysis.texw
	Pweave -f texminted $^

analysis.py: analysis.texw
	Ptangle $^

clean:
	git clean -fdX *

.PHONY: all clean
.DELETE_ON_ERROR:
