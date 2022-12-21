##
# Personal webpage
#
# @file
# @version 0.1
# Modified from https://stackoverflow.com/a/22091045

SRC=src

HTML_FILES_ALL=$(patsubst $(SRC)/%.org, %.html,$(wildcard $(SRC)/*.org))
HTML_FILES=$(filter-out footer.html, $(HTML_FILES_ALL))
$(info $$HTML_FILES is [${HTML_FILES}])

.PHONY: all clean publish build

all: build

build: $(HTML_FILES)

publish: build
	git checkout page
	git checkout main $(HTML_FILES)

$(SRC)/footer.html: $(SRC)/footer.org
	emacs $< --batch -f org-babel-tangle --kill

%.html:  $(SRC)/%.org $(SRC)/footer.html
	emacs $< --batch -f org-html-export-to-html --kill

clean:
	rm *.html $(SRC)/footer.html
# end
