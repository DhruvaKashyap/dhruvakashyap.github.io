##
# Personal webpage
#
# @file
# @version 0.1
# Modified from https://stackoverflow.com/a/22091045

SRC=src
OUT_DIR=site


HTML_FILES_ALL=$(patsubst $(SRC)/%.org, $(OUT_DIR)/%.html,$(wildcard $(SRC)/*.org))
HTML_FILES_ALL+=$(patsubst $(SRC)/blogs/%.org, $(OUT_DIR)/blogs/%.html,$(wildcard $(SRC)/blogs/*.org))
HTML_FILES=$(filter-out site/footer.html, $(HTML_FILES_ALL))
$(info $$HTML_FILES is [${HTML_FILES}])

.PHONY: all clean setup publish build

all: build

build: setup $(HTML_FILES)

publish: setup $(HTML_FILES)
	git checkout $(OUT_DIR)
	mv $(OUT_DIR)/* .
	rmdir $(OUT_DIR)/
	rm -rf $(SRC)/

$(SRC)/footer.html: $(SRC)/footer.org
	emacs $< --batch -f org-babel-tangle --kill

$(OUT_DIR)/%.html:  $(SRC)/%.org $(SRC)/footer.html
	emacs $< --batch -f org-html-export-to-html --kill

$(OUT_DIR)/blogs/%.html: $(SRC)/blogs/%.org $(SRC)/footer.html
	emacs $< --batch -f org-html-export-to-html --kill

setup:
	mkdir -p $(OUT_DIR)/blogs/

clean:
	rm *.html $(SRC)/footer.html
	rm -rf $(OUT_DIR)/
# end
