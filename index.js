(function() {
  var CssSelect, dom, extend, html;

  dom = require('dom');

  html = dom(require('./template.html'));

  extend = require('extend');

  CssSelect = (function() {
    function CssSelect(el, options) {
      var defaults;
      this.el = el;
      this.options = options;
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
      var old, template;
      el = dom(el);
      old = el.clone();
      template = html.clone();
      template.find('select').replace(old);
      if (this.options["class"] !== '') {
        template.addClass(this.options["class"]);
      }
      return el.replace(template);
    };

    CssSelect.prototype.onChange = function(ev) {
      var select;
      select = ev.target;
      return select.previousElementSibling.innerText = select.value;
    };

    return CssSelect;

  })();

  module.exports = CssSelect;

}).call(this);
