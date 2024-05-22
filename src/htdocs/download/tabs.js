/* Adapted from the MDN accessible tabs example
 * https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/tab_role#example */

window.addEventListener("DOMContentLoaded", () => {
  const tabs = document.querySelectorAll('[role="tab"]');
  tabs.forEach((tab) => tab.addEventListener("click", changeTab));

  // Catch URLs pointing to a specific tab
  handleHashUrl();
  window.addEventListener('hashchange', handleHashUrl);
});

function figureOutDefaultTab() {
  const userAgent = navigator.userAgent;

  // Android UA also has "Linux" in it, so check for Android first
  if (userAgent.includes("Android")) return "#android";
  if (userAgent.includes("iPhone") || userAgent.includes("iPad")) return "#ios";

  if (userAgent.includes("Windows")) return "#windows";
  if (userAgent.includes("Mac")) return "#macos";
  if (userAgent.includes("Linux")) return "#linux";

  return "#sources";
}

function handleHashUrl() {
  let hash = window.location.hash;
  if (!hash) hash = figureOutDefaultTab();

  const tabName = hash.replace("#", "tab-");
  const tab = document.querySelector(`[id="${tabName}"]`);
  if (tab) tab.click();
}

function changeTab(event) {
  const newTab = event.target;
  const parent = newTab.parentNode;
  const grandparent = parent.parentNode;

  parent
    .querySelectorAll('[aria-selected="true"]')
    .forEach((t) => t.setAttribute("aria-selected", false));

  newTab.setAttribute("aria-selected", true);

  grandparent
    .querySelectorAll('[role="tabpanel"]')
    .forEach((p) => p.setAttribute("hidden", true));

  grandparent.parentNode
    .querySelector(`#${newTab.getAttribute("aria-controls")}`)
    .removeAttribute("hidden");

  const newHash = newTab.getAttribute("id").replace("tab-", "#");
  if (window.location.hash !== newHash) {
    window.location.hash = newHash;
  }
}
