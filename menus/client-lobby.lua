local Menu = require('menus.C_menu');

-- menu Actions

local load_main_menu =  require('menus.menu-actions.load-main-menu');
local strat_game_as_client =  require('menus.menu-actions.start-game-as-client');

local default_color = { 1, 1, 0, 0.8 };

local btn_host = {
  text = 'Go back',
  color = default_color,
  pos_x = 0.4,
  pos_y = 0.3
};

local btn_join = {
  text = 'Waiting for server...',
  color = default_color,
  pos_x = 0.4,
  pos_y = 0.4
};

local input_actions = {
  escape = load_main_menu,
  ['return'] = load_main_menu
};

local elements = {
  btn_host,
  btn_join
};

return Menu.create(elements, input_action, start_game_as_client);