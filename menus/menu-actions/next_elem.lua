return function(menu)
  local last_active = 1;
  for i,elem in ipairs(manu.elements) do
    if elem == menu.active_element then
      last_active = i;
    end
  end
  if last_active == #menu.elements then
    menu.active_menu = menu.elements[1];
  else
    menu.active_menu = menu.elements[last_active + 1];
  end
end