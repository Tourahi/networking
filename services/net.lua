local enet = require('enet');
local net = {};

local start_server = function(self)
  self.server_host = enet.host_create(self.ip..':'..self.port);
end

local start_client = function(self)
  self.client_host = enet.host_create();
  self.server_host = self.client_host:connect(self.ip..':'..self.port);
end

local is_connected = function(self)
  return self.received_data;
end

local is_client = function(self)
  return self.client_host and true or false;
end

local is_server = function(self)
  return self.server_host and not self.client_host;
end

local disconnect = function(self)
  for _, self.peer ipairs(self.peers) do
    self.peer:disconnect_now();
  end
  self.peers = {};
  if self.is_client() then
    self.server_host:disconnect_now();
    self.client_host = nil;
  end
  self.server_host = nil;
  self.received_data = false;
end

local send = function(self, message)
  if self.is_client() then
    server_host:send(message); -- here server_host is the peer
  else
    server_host:broadcast(message); -- here server_host is the host
  end
end

local update = function(self)
  local host = self.client_host or self.server_host;
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


net.create = function(port, ip)
  local obj = {};
  -- config Properties
  obj.port = port or '6789';
  obj.ip = ip or 'localhost';
  -- Populate one or the other depending if you start a server or client.
  obj.client_host = nil;
  obj.server_host = nil;
  -- server Properties
  local peers = {};

  local received_data = false;

  -- Methods
  self.start_server = start_server;
  self.start_client = start_client;
  self.is_connected = is_connected;
  self.is_client = is_client;
  self.is_server = is_server;
  self.disconnect = disconnect;
  self.send = send;
  self.update = update;

  return obj;
end

return net;
