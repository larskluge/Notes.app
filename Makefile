.PHONY : init clean build dist

init:
	npm install

clean:
	rm -rf build/*

build:
	zip -r build/notes.nw *

dist: clean init build

