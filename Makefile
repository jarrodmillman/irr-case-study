TITLE="millman_ottoboni_stark"

all:
	pdflatex $(TITLE).tex
	bibtex $(TITLE)
	pdflatex $(TITLE).tex
	pdflatex $(TITLE).tex

clean:
	rm -f $(TITLE).{pdf,aux,log,bbl,lof,lot,blg,out}
	rm -f $(TITLE).md $(TITLE)_md.pdf

markdown:
	sed '/\pagebreak/,/\end{document}/d' $(TITLE).tex > $(TITLE)_clean.tex
	echo '\end{document}' >> $(TITLE)_clean.tex
	pandoc -s $(TITLE)_clean.tex --natbib -o $(TITLE).md
	echo "" >> $(TITLE).md
	echo "# References" >> $(TITLE).md
	pandoc $(TITLE).md --filter=pandoc-citeproc -o $(TITLE)_md.pdf
