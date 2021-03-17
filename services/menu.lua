local menu_service = {};

local window_width, window_height = love.graphics.getDimensions();

-- List of menus
local menus = {

};

-- the loaded menu table
menu_service.active_menu = nil;

function menu_service.load(menu_name)
  assert(
    type(menu_name) == 'string',
    'Expected menu name, but got ' .. type(menu_name)
  );
  local menu_factory = menus[menu_name];
  assert(
    type(menu_factory) == 'function',
    'Expected a function menu_factory , but got' .. type(menu_factory)
  );
  local menu = menu_factory();
  type(menu) == 'table',
  'Expecting menu to return a table, but got ' .. type(menu)
  );

  menu_service.active_menu = menu;
  -- Activate the first element by default
  menu.active_element = menu.active_element or menu.elements[1];
end

function menu_service.unload()
  menu_service.active_menu = nil;
end

function menu_service.update()
  local menu = menu_service.active_menu;
  if not menu then return end
  if not menu.update then return end
  menu.update();
end

return menu_service;
