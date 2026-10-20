// Refresh the activity numbers and the recent commits on the home page from
// /activity.json, a file of this site that a cron job on the server rewrites
// regularly (tools/fetch-activity.py), so the visitors never query GitLab. The
// values rendered by the build stay when it is missing
// or without JavaScript.
(function () {
  var nodes = document.querySelectorAll('[data-activity]');
  if (!nodes.length) return;

  var src = document.querySelector('[data-activity-src]');
  if (!src) return;

  function find(name) { return document.querySelector('[data-activity="' + name + '"]'); }
  function day(d) { return new Date(d).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }); }

  function show(a) {
    ['commits_total', 'mrs_merged_30d', 'mrs_merged_12m', 'contributors'].forEach(function (k) {
      var el = find(k);
      if (el && a[k] !== undefined) el.textContent = a[k].toLocaleString('en') + (k === 'contributors' ? '+' : '');
    });
    var date = find('date');
    if (date) date.textContent = day(a.fetchedAt);
    var list = find('recent');
    if (!list) return;
    var limit = parseInt(list.getAttribute('data-limit'), 10) || 8;
    list.textContent = '';
    a.recent_commits.slice(0, limit).forEach(function (c) {
      var li = document.createElement('li');
      var link = document.createElement('a');
      link.href = c.web_url;
      link.textContent = c.title;
      var meta = document.createElement('span');
      meta.className = 'meta';
      meta.textContent = c.author + ', ' + day(c.date) + ' in ' + c.repo;
      li.appendChild(link);
      li.appendChild(document.createElement('br'));
      li.appendChild(meta);
      list.appendChild(li);
    });
  }

  fetch(src.getAttribute('data-activity-src'), { cache: 'no-cache' })
    .then(function (r) { return r.ok ? r.json() : Promise.reject(r.status); })
    .then(function (a) {
      if (a && a.recent_commits && a.fetchedAt) show(a);
    })
    .catch(function () {});
})();
