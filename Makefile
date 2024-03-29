regex.md: regex.Rmd
	Rscript -e "rmarkdown::render('regex.Rmd', rmarkdown::md_document(preserve_yaml = TRUE, variant = 'gfm', pandoc_args = '--markdown-headings=atx'))"

text-manipulation.md: text-manipulation.Rmd
	Rscript -e "rmarkdown::render('text-manipulation.Rmd', rmarkdown::md_document(preserve_yaml = TRUE, variant = 'gfm', pandoc_args = '--markdown-headings=atx'))"  ## atx headers ensures headers are all like #, ##, etc. Shouldn't be necessary as of pandoc >= 2.11.2
## 'gfm' ensures that the 'r' tag is put on chunks, so code coloring/highlighting will be done when html is produced.


# text-manipulation.md: text-manipulation.qmd
#	quarto render text-manipulation.qmd --to html

#regex.html: regex.qmd
#	quarto render regex.qmd --to html
