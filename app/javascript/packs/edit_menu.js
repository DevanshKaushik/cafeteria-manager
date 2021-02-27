const menu_name = document.getElementById("edit_menu_name")
const edit_menu_form = document.getElementById("edit_menu_form")
const hidden_field = document.getElementById("menu_name")

let curr_value = ""

menu_name.addEventListener("focus", () => {
  curr_value = menu_name.innerText
})

menu_name.addEventListener("blur", () => {
  if (curr_value === menu_name.innerText) {
    return
  }

  hidden_field.value = menu_name.innerText
  edit_menu_form.submit()
})