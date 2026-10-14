/* Adapted from the MDN accessible tabs example
 * https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/tab_role#example */
(function () {
  var root = document.querySelector(".dl-content");
  if (!root) return;
  root.classList.add("js");
  var tabs = root.querySelectorAll('[role="tab"]');
  var panels = root.querySelectorAll('[role="tabpanel"]');

  function figureOutDefaultTab() {
    var ua = navigator.userAgent;
    // Android UA also has "Linux" in it, so check for Android first
    if (ua.includes("Android")) return "android";
    if (ua.includes("iPhone") || ua.includes("iPad")) return "ios";
    if (ua.includes("Windows")) return "windows";
    if (ua.includes("Mac")) return "macos";
    if (ua.includes("Linux")) return "linux";
    return "sources";
  }

  function select(name, updateHash) {
    var tab = root.querySelector('[id="tab-' + name + '"]');
    if (!tab) return false;
    tabs.forEach(function (t) { t.setAttribute("aria-selected", t === tab ? "true" : "false"); });
    panels.forEach(function (p) { p.setAttribute("hidden", ""); });
    root.querySelector("#" + tab.getAttribute("aria-controls")).removeAttribute("hidden");
    if (updateHash && window.location.hash !== "#" + name) window.location.hash = "#" + name;
    return true;
  }

  function fromHash() {
    var name = window.location.hash.replace("#", "");
    if (name) {
      if (select(name, false)) return;
      // Anchors inside a panel (e.g. #toolchain-compatibility-notes)
      var el = null;
      try { el = document.getElementById(decodeURIComponent(name)); } catch (e) {}
      var panel = el && el.closest('[role="tabpanel"]');
      if (panel) {
        select(panel.id.replace("panel-", ""), false);
        el.scrollIntoView();
        return;
      }
    }
    select(figureOutDefaultTab(), false);
  }

  tabs.forEach(function (t) {
    t.addEventListener("click", function () { select(t.id.replace("tab-", ""), true); });
  });
  window.addEventListener("hashchange", fromHash);
  fromHash();
})();
