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
    select = template.find 'select'
    select.replace old

    value = @getText old.find('option')[0]
    @setText template.find('.placeholder')[0], value

    if @options.class isnt ''
      template.addClass @options.class

    el.replace template
    return

  onChange: (ev)=>
    select = ev.target
    @setText select.previousElementSibling, select.value
    return

  setText: (el,text)->
    if el.textContent
      el.textContent = text
    else
      el.innerText = text
    return

  getText: (el)->
    if el.textContent
      return el.textContent
    else
      return el.innerText

module.exports = CssSelect