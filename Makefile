TITLE="millman_ottoboni_stark"

all:
	pdflatex $(TITLE).tex
	bibtex $(TITLE)
	pdflatex $(TITLE).tex
	pdflatex $(TITLE).tex

clean:
	rm -f $(TITLE).{pdf,aux,log,bbl,lof,lot,blg,out}
	rm -f $(TITLE).md $(TITLE)_md.pdf

figure:
	neato -n -Tpng work_process.dot -o work_process.png

markdown:
	pandoc -s $(TITLE).tex -o $(TITLE).md
	pandoc $(TITLE).md -o $(TITLE)_md.pdf
