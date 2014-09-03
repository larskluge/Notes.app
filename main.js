require('coffee-script/register')

global.document = window.document
global.navigator = window.navigator

var $ = global.$ = require('jquery')
global.Mousetrap = require('mousetrap')

require('./js/main.coffee')

