millman_ottoboni_stark.pdf:
	pdflatex millman_ottoboni_stark.tex

figure:
	neato -n -Tpng work_process.dot -o work_process.png
