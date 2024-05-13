/* Adapted from the MDN accessible tabs example
 * https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/tab_role#example */

window.addEventListener("DOMContentLoaded", () => {
  const tabs = document.querySelectorAll('[role="tab"]');
  tabs.forEach((tab) => tab.addEventListener("click", changeTab));
});

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
}
