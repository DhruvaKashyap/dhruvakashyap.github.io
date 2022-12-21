##
# Personal webpage
#
# @file
# @version 0.1
# Modified from https://stackoverflow.com/a/22091045

HTML_FILES=site/index.html site/about.html site/projects.html

.PHONY: all clean setup publish build

all: build

build: setup $(HTML_FILES)

publish: setup $(HTML_FILES)
	git checkout site
	mv site/* .
	rmdir site/
	rm -rf src/

src/footer.html: src/footer.org
	emacs $< --batch -f org-babel-tangle --kill

site/%.html: src/%.org src/footer.html
	emacs $< --batch -f org-html-export-to-html --kill

setup:
	mkdir -p site

clean:
	rm *.html src/footer.html
	rm -rf site/
# end
