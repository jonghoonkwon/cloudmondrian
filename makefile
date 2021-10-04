PAPERNAME=paper

FIGURES=img/*.png
TEXFILES=sec/*.tex
BIBFILES=*.bib

$(PAPERNAME).pdf: $(PAPERNAME).tex ${TEXFILES} ${FIGURES} ${BIBFILES}
	pdflatex -synctex=1 $(PAPERNAME)
	bibtex --min-crossrefs=100 $(PAPERNAME)
	pdflatex -synctex=1 $(PAPERNAME)
	pdflatex -synctex=1 $(PAPERNAME)


mate: *.tex
	pdflatex -synctex=1 -interaction nonstopmode $(PAPERNAME)
	bibtex --min-crossrefs=100 $(PAPERNAME)


full: *.tex
	latex -synctex=1 $(PAPERNAME)
	bibtex --min-crossrefs=100 $(PAPERNAME)
	latex -synctex=1 $(PAPERNAME)
	latex -synctex=1 $(PAPERNAME)
	dvips -Ppdf -G0 -t letter -o $(PAPERNAME).ps $(PAPERNAME)
	ps2pdf -dCompatibilityLevel=1.3 $(PAPERNAME).ps


force:
	rm -f $(PAPERNAME).pdf
	make


clean:
	rm -f $(PAPERNAME).ps $(PAPERNAME).pdf *~ *.dvi *.xcp *.log *.aux *.out *.blg *.bbl *.toc *.ent *.fls *.backup *.bak *.fdb_latexmk $(PAPER).synctex.gz


tar:
	make clean
	tar czf $(PAPERNAME).tar.gz *
