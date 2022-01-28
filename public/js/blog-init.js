const deletePostBtns = document.querySelectorAll(".deleteBtn");
const deleteCategoryBtns = document.querySelectorAll(".deleteCategoryBtn");
const updateCategoryBtns = document.querySelectorAll(".updateCategoryBtn");

//this function call deletes a single post via ajax
deletePostBtns.forEach((btn) =>
  btn.addEventListener("click", function (e) {
    e.preventDefault();
    showPopUp(
      "¿Estás segura de que quieres eliminar este post?",
      function () {
        deleteOneById(btn.id, "/ccb/admin/ajax/delete-single-post");
      },
      "Eliminar"
    );
  })
);

deleteCategoryBtns.forEach((btn) =>
  btn.addEventListener("click", function (e) {
    e.preventDefault();
    showPopUp(
      "¿Estás segura de que quieres eliminar esta categoría?",
      function () {
        deleteOneById(btn.id, "/ccb/admin/ajax/delete-single-category");
      },
      "Eliminar"
    );
  })
);

updateCategoryBtns.forEach((btn) =>
  btn.addEventListener("click", function (e) {
    e.preventDefault();
    showPopUp(
      `¿Estás segura de que quieres actualizar esta categoría a ${categoryInput.value} ?`,
      function () {
        updateOneById(
          btn.id,
          categoryInput.value,
          "/ccb/admin/ajax/updateSingleCategory"
        );
      },
      "Actualizar"
    );
  })
);

async function deleteOneById(id, url) {
  const data = await fetch(url, {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ id: id }),
  });
  const content = await data.json();
  if (content) {
    location.reload();
  }
}

async function updateOneById(id, name, url) {
  const data = await fetch(url, {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ id: id, name: name }),
  });
  const content = await data.json();
  console.log(content);
  if (content) {
    location.reload();
  }
}
