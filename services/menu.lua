local menu_service = {};

local window_width, window_height = love.graphics.getDimensions();

-- List of menus
local menus = {
  ['main-menu'] = require('menus.main-menu'),
  ['client-lobby'] = require('menus.client-lobby'),
  ['server-lobby'] = require('menus.server-lobby')
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

menu_service.draw = function()
  local menu = menu_service.active_menu;
  if not menu then return end

  for _, element in ipairs(menu:getElements())
    local color = { unpack(element.color) };
    if element == menu.active_element then
      color[1] = 1;
      color[2] = 1;
      color[3] = 1;
      color[4] = 1;
    end
    love.graphics.print(
      { color, element.text },
      math.floor(element.pos_x * window_width),
      math.floor(element.pos_y * window_height),
      0,
      2
    );
  end
end

menu_service.handle_keypress = function(pressed_key)
  local menu = menu_service.active_menu;
  if not menu then return end

  local input_action
  if (menu.active_element:getInputActions) then
    input_action = menu.active_element.input_actions[pressed_key];
  end

  input_action = input_action or menu.input_actions[pressed_key];

  if not input_action then return end

  input_action(menu);
end

return menu_service;
