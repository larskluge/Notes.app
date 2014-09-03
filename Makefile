.PHONY : init clean build dist install

init:
	npm install

clean:
	rm -rf build/*

build:
	zip -r build/app.nw css js node_modules index.html main.js npm-shrinkwrap.json package.json
	cp -r resources/node-webkit.app build/Notes.app
	cp build/app.nw build/Notes.app/Contents/Resources/

dist: clean init build

install:
	cp -r build/Notes.app ~/Applications/

