##
# Personal webpage
#
# @file
# @version 0.1
# Modified from https://stackoverflow.com/a/22091045

SRC=src
HTML_FILES_ALL=$(patsubst $(SRC)/%.org, %.html,$(wildcard $(SRC)/*.org))
HTML_FILES=$(filter-out footer.html, $(HTML_FILES_ALL))

.PHONY: clean publish build

all: build

build: $(HTML_FILES)

publish: build
	git add -A;
	read -p "Commit message: " msg;\
	git commit -m "$$msg";\
	git checkout page;\
	git checkout main $(HTML_FILES) static/;\
	git commit -m "$$msg";\
	git push origin page
	git checkout main
	git push

$(SRC)/footer.html: $(SRC)/footer.org
	rm -f $@
	./gen_html $<

%.html:  $(SRC)/%.org $(SRC)/footer.html static/styles.css
	rm -f $@
	./gen_org $<

clean:
	rm  -f *.html $(SRC)/footer.html
# end
