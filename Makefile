SRC = $(wildcard Day*/Session*.Rmd)

PDF   = $(SRC:.Rmd=.pdf)
HTML  = $(SRC:.Rmd=.html)

RENDER_H = @Rscript -e "rmarkdown::render('$<', 'html_document', params=list(presentation=FALSE))"
RENDER_P = @Rscript -e "rmarkdown::render('$<', 'beamer_presentation', params=list(presentation=TRUE))"
RENDER_D = @Rscript -e "rmarkdown::render('$<', 'pdf_document', params=list(presentation=FALSE))"
RENDER_B = @Rscript -e "rmarkdown::render('$<', 'all')"

%.html:%.Rmd
	$(RENDER_H)
	-rm -rf Day*/Session*.log
%Session_Preparation.pdf:%Session_Preparation.Rmd
	$(RENDER_D)
	-rm -rf Day*/Session*.log
%.pdf:%.Rmd
	$(RENDER_P)
	-rm -rf Day*/Session*.log

.PHONY: clean
.PHONY: tidy
.PHONY: pdf
.PHONY: html
.PHONY: all
	
all: 	$(PDF) $(HTML)
pdf:	$(PDF)
html:	$(HTML)
clean:
	-rm -rf Day*/Session*.md
	-rm -rf Day*/Session*.tex
	-rm -rf Day*/Session*.pdf
	-rm -rf Day*/Session*.html
	-rm -rf Day*/Session*.log
	-rm -rf Day*/Session*_files
tidy:
	-rm -rf Day*/Session*.md
	-rm -rf Day*/Session*.tex
	-rm -rf Day*/Session*.log
	-rm -rf Day*/Session*_files
