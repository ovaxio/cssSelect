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
    @el.on 'click', 'select', @onChange, false

  # set all the select
  load: ()->
    @select = @el.find 'select'
    old = @select
    @transform el for el in @select

  # transform the HTML select to a 'everywhere the same' select
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
    select = ev.target ? ev.srcElement # srcElement for IE
    value = @getText(select.options[select.selectedIndex])
    @setText @previousElementSibling(select), value
    return

  setText: (el,text)->
    if el.textContent?
      el.textContent = text
    else
      el.innerText = text
    return

  getText: (el)->
    if el.textContent?
      return el.textContent
    else
      return el.innerText

  previousElementSibling: (el)->
    prev = null

    if el.previousElementSibling?
      prev = el.previousElementSibling
    else
      cur = el.previousSibling
      while cur.nodeType != 1
        cur = cur.previousSibling
      prev = cur

    return prev

module.exports = CssSelect