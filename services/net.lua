local enet = require('enet');
local net = {
  -- config Properties
  port = '6789',
  ip = 'localhost',
  -- server Properties
  peers = {},

  received_data = false
};

-- Populate one or the other depending if you start a server or client.
local client_host;
local server_host;

net.start_server = function(self)
  server_host = enet.host_create(self.ip..':'..self.port);
end

net.start_client = function(self)
  client_host = enet.host_create();
  server_host = client_host:connect(self.ip..':'..self.port);
end

net.is_connected = function(self)
  return self.received_data;
end

net.is_client = function(self)
  return client_host and true or false;
end

net.is_server = function(self)
  return server_host and not client_host;
end

net.disconnect = function(self)
  for _, peer in ipairs(self.peers) do
    self.peer:disconnect_now();
  end
  self.peers = {};
  if self.is_client() then
    self.server_host:disconnect_now();
    client_host = nil;
  end
  self.server_host = nil;
  self.received_data = false;
end

net.send = function(self, message)
  if self.is_client() then
    server_host:send(message); -- here server_host is the peer
  else
    server_host:broadcast(message); -- here server_host is the host
  end
end

net.update = function(self)
  local host = client_host or server_host;
  if not host then return end
  local event = host:service();
  if event then
    self.received_data = true;
    -- Handle the event
    print('---------');
    for k, v in pairs(events) do
      print(k, v);
    end
  end
end

net.hellrr = 'lol';

return net;
