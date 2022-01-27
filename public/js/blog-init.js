const deletePostBtns = document.querySelectorAll(".deleteBtn");

deletePostBtns.forEach((btn) =>
  btn.addEventListener("click", function (e) {
    e.preventDefault();
    showPopUp(
      "¿Estás segura de que quieres eliminar este post?",
      function () {
        deleteSinglePost(btn.id);
      },
      "Eliminar"
    );
  })
);

async function deleteSinglePost(id) {
  const data = await fetch("/ccb/admin/ajax/delete-single-post", {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ id: id }),
  });
  const content = await data.json();
  if (content) {
    const notification = document.createElement("div");
    notification.setAttribute("class", "alert");
    notification.textContent = "El post has sido eliminado.";
    document
      .querySelector(".container")
      .insertAdjacentElement("afterbegin", notification);
    removeNotification();
  }
}
