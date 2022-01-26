"use strict";
console.log("global js");

window.location.href.split("/")[3];

console.log();

document.querySelectorAll(".navbar-nav > li").forEach((li) => {
  if (window.location.pathname != "/") {
    li.classList.remove("active");
  }
  if (
    window.location.pathname ==
    "/" + li.firstChild.textContent.toLowerCase()
  ) {
    li.classList.add("active");
  }
});