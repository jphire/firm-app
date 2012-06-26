window.add_material = (e) ->
  choice = $('#post_material_id').get(0)
  amount = $('#material_amount').get(0).value
  val = choice.value
  div = document.createElement('div')
  div.setAttribute("id", val + "_hidden")
  elem = document.createElement('input')
  
  
  tr_elem = document.createElement('tr')
  tr_elem.id = val
  td_elem = document.createElement('td')
    
  td_elem_remove = document.createElement('td')
  a_elem = document.createElement('a')
  i_elem = document.createElement('i')
  i_elem.setAttribute("class", "icon-remove")
  
  for option in choice
    if option.value == val && option.innerHTML != "Valitse raaka-aine" && amount != ""
      td_elem.innerHTML = option.innerHTML + ", " + amount + " g</br>"  
      a_elem.href = "#"
      a_elem.setAttribute("class","nav-link")
      a_elem.setAttribute("onclick","remove_table_element(#{val})")
      
      material = [val, amount]
      elem.type = "hidden"
      elem.name = "new_materials[" + material + "]"
      elem.value = amount
      
      $('#recipe_materials').append tr_elem
      $('#recipe_materials').append div
      $(div).append elem
      $(tr_elem).append td_elem
      $(tr_elem).append td_elem_remove
      $(td_elem_remove).append a_elem  
      $(a_elem).append i_elem
  
  console.log div
  console.log amount
  
