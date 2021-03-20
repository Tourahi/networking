return function(menu)
  local active_element_idx = 1
  for idx, element in ipairs(menu.elements) do
    if element == menu.active_element then
      active_element_idx = idx
    end
  end
  if active_element_idx == #menu.elements then
    menu.active_element = menu.elements[1]
  else
    menu.active_element = menu.elements[active_element_idx + 1]
  end
end
