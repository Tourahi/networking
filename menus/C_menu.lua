local Menu = {};



local getElements = function(self)
  return self.elements;
end

local getInputActions = function(self)
  return self.input_action;
end

Menu.create = function(elements, input_action, updateCb)
  local ent = {};
  assert(
    type(input_action) == 'table',
    'Expected a table input_action , but got' .. type(input_action)
  );
  assert(
    type(elements) == 'table',
    'Expected a table elements , but got' .. type(elements)
  );
  ent.input_action = input_action;
  ent.elements = elements;
  ent.active_menu = elements[1];

  -- Methods
  ent.getElements = getElements;
  ent.getInputActions = getInputActions;
  ent.update = updateCb or nil;

  return ent;
end

return Menu;
