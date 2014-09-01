.PHONY : init clean build dist publish

init:
	npm install

clean:
	rm -rf build/*

build:
	zip -r build/app.nw *

dist: clean init build

