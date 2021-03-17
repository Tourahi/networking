local entity_service = {};
local input_service = require('services.input');

entity_service.entities = {}; -- Hold all entities

function entity_service.spawn(player_id, x, y, speed)
  return {
    color = {1,1,1,1},
    id = player_id,
    shape = love.physics.newPolygonShape(0, 0, 50, 0, 50, 50, 0, 50),
    x = x,
    y = y,
    speed = speed
  };
end

function entity_service.draw(entity)
  love.graphics.setColor(entity.color);
  local point = { entity.shape:getPoints() };
  for i, point in ipairs(points) do
    if i % 2 == 1 then
      points[i] = point + entity.x;
    else
      points[i] = point + entity.y;
    end
  end
  love.graphics.polygon('line', points);
end

function entity_service.move(player_id, x, y)
  local player =  entity_service.entities[player_id];

  -- Don't let the player press up and down at the same time
  if input_service.up and not input_service.down then
    player.y = player.y - player.speed;
  elseif input_service.down and not input_service.up then
    player.y = player.y + player.speed;
  end

  -- Don't let the player press left and right at the same time
  if input_service.left and not input_service.right then
    player.x = player.x - player.speed;
  elseif input_service.right and not input_service.left then
    player.x = player.x + player.speed;
  end
  end

end


return entity_service;
