##
# Personal webpage
#
# @file
# @version 0.1
# Modified from https://stackoverflow.com/a/22091045

ORG_FILES=index.org about.org projects.org
HTML_FILES=index.html about.html projects.html

.PHONY: all clean

all: footer.html $(HTML_FILES) $(ORG_FILES)

footer.html: footer.org
	emacs footer.org --batch -f org-babel-tangle --kill

%.html: %.org footer.html
	emacs $< --batch -f org-html-export-to-html --kill

clean:
	rm *.html
# end
