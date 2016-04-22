TITLE="millman_ottoboni_stark"

all:
	pdflatex $(TITLE).tex
	bibtex $(TITLE)
	pdflatex $(TITLE).tex
	pdflatex $(TITLE).tex

clean:
	rm -f $(TITLE).{pdf,aux,log,bbl,lof,lot,blg,out}
	rm -f $(TITLE).md $(TITLE)_md.pdf
	rm -f $(TITLE)_clean.tex
	rm -f $(TITLE).tex.bak

markdown:
	sed '/\pagebreak/,/\end{document}/d' $(TITLE).tex > $(TITLE)_clean.tex
	echo '\end{document}' >> $(TITLE)_clean.tex
	pandoc -s $(TITLE)_clean.tex --natbib -o $(TITLE).md
	perl -pi -e 's:Figure \[fig\:work~p~rocess\]: Figure 1:g' $(TITLE).md
	perl -pi -e 's:\[fig\:work~p~rocess\]::g' $(TITLE).md
	perl -pi -e 's:\[key-tools\]:\[Key tools and practices\](#key-tools):g' $(TITLE).md
	perl -pi -e 's:\[subsec\:understand-result\]:\[Understand result\](#subsec\:understand-result):g' $(TITLE).md
	perl -pi -e 's:\[table\:mapping\]:1:g' $(TITLE).md
	perl -pi -e 's: \(see Figure \[fig\:pull-request\]\)::g' $(TITLE).md
	echo "" >> $(TITLE).md
	echo "# References" >> $(TITLE).md
	pandoc $(TITLE).md --filter=pandoc-citeproc -f markdown -o $(TITLE)_md.pdf
