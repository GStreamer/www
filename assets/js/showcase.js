// Show the products in a random order on every visit. The first and the last
// ones (data-pin) keep their place. Without JavaScript the list stays alphabetical.
(function () {
  var list = document.querySelector('ul.showcase');
  if (!list) return;
  var items = Array.prototype.slice.call(list.children);
  var movable = items.filter(function (li) { return !li.hasAttribute('data-pin'); });
  for (var i = movable.length - 1; i > 0; i--) {
    var j = Math.floor(Math.random() * (i + 1));
    var t = movable[i]; movable[i] = movable[j]; movable[j] = t;
  }
  var first = items.filter(function (li) { return li.getAttribute('data-pin') === 'first'; });
  var last = items.filter(function (li) { return li.getAttribute('data-pin') === 'last'; });
  first.concat(movable, last).forEach(function (li) { list.appendChild(li); });
})();
