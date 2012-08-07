window.add_order = (e) ->
  choice = $('#post_order_id').get(0)
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
    if option.value == val && option.innerHTML != "Valitse tilaus"
      td_elem.innerHTML = option.innerHTML  
      a_elem.href = "#"
      a_elem.setAttribute("class","nav-link")
      a_elem.setAttribute("onclick","remove_table_element(#{val})")
      
      elem.type = "hidden"
      elem.name = "new_orders[" + val + "]"
      elem.value = val
      
      $('#bill_orders').append tr_elem
      $('#bill_orders').append div
      $(div).append elem
      $(tr_elem).append td_elem
      $(tr_elem).append td_elem_remove
      $(td_elem_remove).append a_elem  
      $(a_elem).append i_elem
  
  console.log div
  
