// Selecting all the required DOM elements
const menuName = document.getElementById("menu_name")
const menuNameForm = document.getElementById("menu_name_form")
const menuNameHidden = document.getElementById("menu_hidden_name")
const menuEditItemBtns = document.querySelectorAll(".menu__edititem--action")

// For editing the menu name
let currentMenuName = ""

menuName.addEventListener("focus", () => {
  currentMenuName = menuName.innerText
})

menuName.addEventListener("blur", () => {
  if (currentMenuName === menuName.innerText) {
    return
  }

  menuNameHidden.value = menuName.innerText
  menuNameForm.submit()
})

// For editing the individual menu items
menuEditItemBtns.forEach((actionBtn) => [

  // Adding click event listener to every edit button for the menu item
  actionBtn.addEventListener("click", () => {
    const menuItemId = actionBtn.dataset.menuItemId

    const editBtnState = actionBtn.dataset.state

    if (editBtnState === "save") {

      // Assigning the new values to the hidden fields of the menu item
      const classNameSuffixes = ["name", "desc", "price", "category"]
      classNameSuffixes.forEach(classNameSuffix => {
        changeHiddenFieldValue(`menu_hidden_${classNameSuffix}_${menuItemId}`, `menu_edititem_${classNameSuffix}_${menuItemId}`)
      })

      // Converting save icon to the edit icon and setting the state to "edit"
      changeActionState(actionBtn, "edit")

      // Submitting the form to post the changes
      const menuItemForm = document.getElementById(`menu_edititem_form_${menuItemId}`)
      menuItemForm.submit()

      return
    }

    // Converting edit icon to the save icon and setting the state to "save"
    changeActionState(actionBtn, "save")
    showEditForm(menuItemId)
  })
])

function showEditForm(menuItemId) {

  const elementClassName = "menu__edititem--input"

  // Setting current element to name field
  let currentElementId = `menu_edititem_name_${menuItemId}`
  let currentElement = document.getElementById(currentElementId)

  let newCurrentElement = document.createElement("input")
  newCurrentElement.classList.add(elementClassName)
  newCurrentElement.id = currentElementId
  newCurrentElement.value = currentElement.innerText
  currentElement.parentElement.replaceChild(newCurrentElement, currentElement)

  // Setting current element to description field
  currentElementId = `menu_edititem_desc_${menuItemId}`
  currentElement = document.getElementById(currentElementId)

  newCurrentElement = document.createElement("input")
  newCurrentElement.classList.add(elementClassName)
  newCurrentElement.id = currentElementId
  newCurrentElement.value = currentElement.innerText
  currentElement.parentElement.replaceChild(newCurrentElement, currentElement)

  // Setting current element to price field
  currentElementId = `menu_edititem_price_${menuItemId}`
  currentElement = document.getElementById(currentElementId)

  newCurrentElement = document.createElement("input")
  newCurrentElement.type= "number"
  newCurrentElement.classList.add(elementClassName)
  newCurrentElement.id = currentElementId
  newCurrentElement.value = currentElement.innerText.slice(2)
  currentElement.parentElement.replaceChild(newCurrentElement, currentElement)

  // Setting current element to category field
  currentElementId = `menu_edititem_category_${menuItemId}`
  currentElement = document.getElementById(currentElementId)

  newCurrentElement = document.createElement("select")
  newCurrentElement.classList.add(elementClassName)
  newCurrentElement.id = currentElementId
  newCurrentElement.innerHTML = `
    <option value="Breakfast">Breakfast</option>
    <option value="Lunch">Lunch</option>
    <option value="Dinner">Dinner</option>
  `
  currentElement.parentElement.replaceChild(newCurrentElement, currentElement)
}

function changeActionState(btn, state) {
  btn.dataset.state = state

  if (state === "save") {
    btn.src = btn.dataset.tickIcon
    return
  }

  btn.src = btn.dataset.editIcon
}

function changeHiddenFieldValue(hiddenFieldClass, inputFieldClass) {
  const hiddenField = document.getElementById(hiddenFieldClass)
  hiddenField.value = document.getElementById(inputFieldClass).value
}