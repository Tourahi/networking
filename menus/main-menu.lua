return function()
  local start_server = require('menus.menu-actions.start-server');
  local start_client = require('menus.menu-actions.start-client');
  local quit_game = require('menus.menu-actions.quit-game');
  local element_previous = require('menus.menu-actions.prev_elem');
  local element_next = require('menus.menu-actions.next_elem');

  local default_color = { 1, 1, 0, 0.8 };

  local btn_host = {
    text = 'Host',
    color = default_color,
    input_actions = {
      ['return'] = start_server
    },
    pos_x = 0.4,
    pos_y = 0.3
  };

  local btn_join = {
    text = 'Join',
    color = default_color,
    input_actions = {
      ['return'] = start_client
    },
    pos_x = 0.4,
    pos_y = 0.4
  };

  local btn_quit = {
    text = 'Quit',
    color = default_color,
    input_actions = {
      ['return'] = quit_game
    },
    pos_x = 0.4,
    pos_y = 0.5
  };

  return {
    input_actions = {
      up = element_previous,
      down = element_next,
      escape = quit_game
    },
    elements = {
      btn_host,
      btn_join,
      btn_quit
    }
  };
end
