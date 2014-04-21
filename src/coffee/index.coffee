dom = require 'dom'
html = dom require('./template.html')
extend = require 'extend'

class CssSelect
  constructor: (@el, @options)->

    defaults =
      class: ''

    @options = extend {}, defaults, @options

    @el = dom @el
    # loading template and replace current selects
    @load()

    # new selects binding
    @bind()

  bind: ()->
    @el.on 'change', 'select', @onChange

  load: ()->
    @select = @el.find 'select'
    old = @select
    @transform el for el in @select

  transform: (el)->
    el = dom el
    old = el.clone()
    template = html.clone()
    template.find 'select'
      .replace old


    # template.find 'select'
    #   .forEach (select,i)->
    #     template.find '.placeholder'
    #       .forEach (placeholder,j)->
    #         # placeholder.style = window.getComputedStyle select
    #         console.log window.getComputedStyle select
    #         # console.log 1,select.style.background
    #         # console.log 2,placeholder.style.background
    #   # .css 'height', el[0].offsetHeight

    if @options.class isnt ''
      template.addClass @options.class

    el.replace template

  onChange: (ev)->
    select = ev.target
    select.previousElementSibling.innerText = select.value

module.exports = CssSelect