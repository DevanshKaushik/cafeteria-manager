const menu_name = document.getElementById("edit_menu_name")
const edit_menu_form = document.getElementById("edit_menu_form")
const hidden_field = document.getElementById("menu_name")
const edit_menu_items = document.querySelectorAll(".emenu__item--edit")

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

edit_menu_items.forEach((item) => [
  item.addEventListener("click", () => {
    id = item.dataset.id

    if (item.src.substring(item.src.lastIndexOf("/assets")) === item.dataset.tickIcon) {
      const hidden_name = document.querySelector(`#hidden_name_${id}`)
      hidden_name.value = document.getElementById(`menu_item_${id}_name`).value

      const hidden_desc = document.querySelector(`#hidden_desc_${id}`)
      hidden_desc.value = document.getElementById(`menu_item_${id}_desc`).value

      const hidden_price = document.querySelector(`#hidden_price_${id}`)
      hidden_price.value = document.getElementById(`menu_item_${id}_price`).value

      const hidden_category = document.querySelector(`#hidden_category_${id}`)
      hidden_category.value = document.getElementById(`menu_item_${id}_category`).value

      item.src = item.dataset.editIcon

      console.log(hidden_name, hidden_desc, hidden_price, hidden_category)

      const menu_item_form = document.getElementById(`edit_menu_item_form_${id}`)
      menu_item_form.submit()

      return
    }

    item.src = item.dataset.tickIcon
    showEditForm(id)
  })
])

function showEditForm(id) {
  const menu_item_name = document.getElementById(`menu_item_${id}_name`)

  const new_menu_item_name = document.createElement("input")
  new_menu_item_name.classList.add("emenu__item--input")
  new_menu_item_name.id = `menu_item_${id}_name`
  new_menu_item_name.value = menu_item_name.innerText
  menu_item_name.parentElement.replaceChild(new_menu_item_name, menu_item_name)

  const menu_item_desc = document.getElementById(`menu_item_${id}_desc`)

  const new_menu_item_desc = document.createElement("input")
  new_menu_item_desc.classList.add("emenu__item--input")
  new_menu_item_desc.id = `menu_item_${id}_desc`
  new_menu_item_desc.value = menu_item_desc.innerText
  menu_item_desc.parentElement.replaceChild(new_menu_item_desc, menu_item_desc)

  const menu_item_price = document.getElementById(`menu_item_${id}_price`)

  const new_menu_item_price = document.createElement("input")
  new_menu_item_price.type= "number"
  new_menu_item_price.classList.add("emenu__item--input")
  new_menu_item_price.id = `menu_item_${id}_price`
  new_menu_item_price.value = menu_item_price.innerText.slice(2)
  menu_item_price.parentElement.replaceChild(new_menu_item_price, menu_item_price)

  const menu_item_category = document.getElementById(`menu_item_${id}_category`)

  const new_menu_item_category = document.createElement("select")
  new_menu_item_category.classList.add("emenu__item--input")
  new_menu_item_category.id = `menu_item_${id}_category`
  new_menu_item_category.innerHTML = `
    <option value="Breakfast">Breakfast</option>
    <option value="Lunch">Lunch</option>
    <option value="Dinner">Dinner</option>
  `
  menu_item_category.parentElement.replaceChild(new_menu_item_category, menu_item_category)
}