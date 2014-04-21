(function() {
  var CssSelect, dom, extend, html,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  dom = require('dom');

  html = dom(require('./template.html'));

  extend = require('extend');

  CssSelect = (function() {
    function CssSelect(el, options) {
      var defaults;
      this.el = el;
      this.options = options;
      this.onChange = __bind(this.onChange, this);
      defaults = {
        "class": ''
      };
      this.options = extend({}, defaults, this.options);
      this.el = dom(this.el);
      this.load();
      this.bind();
    }

    CssSelect.prototype.bind = function() {
      return this.el.on('change', 'select', this.onChange);
    };

    CssSelect.prototype.load = function() {
      var el, old, _i, _len, _ref, _results;
      this.select = this.el.find('select');
      old = this.select;
      _ref = this.select;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        el = _ref[_i];
        _results.push(this.transform(el));
      }
      return _results;
    };

    CssSelect.prototype.transform = function(el) {
      var old, select, template, value;
      el = dom(el);
      old = el.clone();
      template = html.clone();
      select = template.find('select');
      select.replace(old);
      value = this.getText(old.find('option')[0]);
      this.setText(template.find('.placeholder')[0], value);
      if (this.options["class"] !== '') {
        template.addClass(this.options["class"]);
      }
      el.replace(template);
    };

    CssSelect.prototype.onChange = function(ev) {
      var select;
      select = ev.target;
      this.setText(select.previousElementSibling, select.value);
    };

    CssSelect.prototype.setText = function(el, text) {
      if (el.textContent) {
        el.textContent = text;
      } else {
        el.innerText = text;
      }
    };

    CssSelect.prototype.getText = function(el) {
      if (el.textContent) {
        return el.textContent;
      } else {
        return el.innerText;
      }
    };

    return CssSelect;

  })();

  module.exports = CssSelect;

}).call(this);
