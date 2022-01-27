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

function showPopUp(message, action, actionName = "Si") {
  const container = document.querySelector("div.container");
  const dialog = `<div class="dialog-holder">
                      <div class="dialog">
                        <p>${message}</p>
                        <div>
                          <button id="closePopUp" class="btn">Cancelar</button>
                          <button id="callBack" class="btn">${actionName}</button>
                        </div>
                      </div>
                  </div>`;
  container.insertAdjacentHTML("afterbegin", dialog);

  document.getElementById("callBack").addEventListener("click", function () {
    action();
    document.querySelector(".dialog-holder").remove();
  });

  document.getElementById("closePopUp").addEventListener("click", function () {
    document.querySelector(".dialog-holder").remove();
  });
}

function removeNotification() {
  setTimeout(() => {
    document.querySelectorAll(".alert").forEach((alert) => alert.remove());
  }, 2500);
}

removeNotification();