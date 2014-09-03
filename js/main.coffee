ngrep = require 'ngrep'
rivets = require 'rivets'
open = require 'open'
notesPath = require('../config').notesPath.replace(/^~+/, process.env.HOME || process.env.HOMEPATH || process.env.USERPROFILE)


rivets.binders.input =
  publishes: true
  routine: rivets.binders.value.routine
  bind: (el) ->
    el.addEventListener('input', this.publish)
  unbind: (el) ->
    el.removeEventListener('input', this.publish)


rivets.formatters.string = (value, left, right) ->
  "#{value}"


rivets.formatters.filename = (value, left, right) ->
  value.replace(/^.*\/([^\/]+)$/, '$1')


rivets.formatters.highlight = (value, left, right) ->
  value.replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')



class File
  constructor: (path, context) ->
    @path = path
    @context = context
    @highlightContext = @context.replace(///(#{app.query})///ig, '**$1**')

  active: ->
    @path == app.activeFile()?.path




class View
  constructor: ->
    @query = ''
    @resetSearch()

  resetSearch: ->
    @active = 0
    @results = 0
    @files = []

  search: =>
    @resetSearch()

    if @query.length > 1
      ngrep ///#{@query}///ig, notesPath, (result) =>
        @results++
        @files.push(new File(result.file, result.context))


  activateNext: ->
    if @active < @files.length
      @active++

  activatePrev: ->
    if @active > 0
      @active--

  activeFile: ->
    @files[@active]

  openActive: ->
    if file = @activeFile()
      open file.path
      process.exit()



$ -> $('input').focus()



window.app = app = new View
view = rivets.bind document.body, app: app


Mousetrap.bind 'up',   ->
  app.activatePrev()
  view.sync()
Mousetrap.bind 'down', ->
  app.activateNext()
  view.sync()
Mousetrap.bind 'enter', -> app.openActive()

