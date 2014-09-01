require('coffee-script/register')

global.document = window.document
global.navigator = window.navigator

var $ = global.$ = require('jquery')

require('./js/mousetrap.min.js')
global.Mousetrap = window.Mousetrap


require('./js/main.coffee')

