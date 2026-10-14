(function () {
  var root = document.documentElement;
  var btns = document.querySelectorAll('.js-theme');
  var modes = ['system', 'light', 'dark'];
  function get() { try { return localStorage.getItem('theme') || 'system'; } catch (e) { return 'system'; } }
  function apply(m) {
    if (m === 'system') root.removeAttribute('data-theme'); else root.setAttribute('data-theme', m);
    btns.forEach(function (b) { b.textContent = 'Theme: ' + m; });
  }
  apply(get());
  btns.forEach(function (b) { b.addEventListener('click', function () {
    var next = modes[(modes.indexOf(get()) + 1) % modes.length];
    try { if (next === 'system') localStorage.removeItem('theme'); else localStorage.setItem('theme', next); } catch (e) {}
    apply(next);
  }); });
  var mt = document.getElementById('menu-toggle'), nav = document.getElementById('nav');
  function menu(open) {
    nav.classList.toggle('open', open); mt.setAttribute('aria-expanded', open);
    document.body.classList.toggle('menu-open', open);
    document.documentElement.style.setProperty('--menu-top', document.querySelector('.site-header').offsetHeight + 'px');
  }
  if (mt && nav) {
    mt.addEventListener('click', function () { menu(!nav.classList.contains('open')); });
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') menu(false); });
    window.addEventListener('resize', function () { if (window.innerWidth > 760) menu(false); });
  }
})();
