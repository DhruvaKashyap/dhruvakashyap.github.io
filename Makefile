##
# Personal webpage
#
# @file
# @version 0.1
# Modified from https://stackoverflow.com/a/22091045

ORG_FILES=src/index.org src/about.org src/projects.org
HTML_FILES=site/index.html site/about.html site/projects.html

.PHONY: all clean setup

all: footer.html setup $(HTML_FILES) $(ORG_FILES)
	git checkout site
	mv site/* .
	rmdir site/
	git checkout main
	rm -rf site/

footer.html: src/footer.org
	emacs $< --batch -f org-babel-tangle --kill

site/%.html: src/%.org footer.html setup
	emacs $< --batch -f org-html-export-to-html --kill

setup:
	mkdir -p site

clean:
	rm src/footer.html
	rm -rf site/
# end
