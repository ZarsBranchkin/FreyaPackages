local Identities = setmetatable({}, {__mode = 'k'});
local CheckTools = {};

local typeof = typeof;

local type = function(o)
  local t = Identities[o];
  if t then return t end;
  t = typeof(o);
  if t ~= 'userdata' then return t end;
  for k,v in next, CheckTools do
    if v(o) then return k end;
  end;
  return t
end

local Controller = {};

Controller.AddIdentity = function(o, k)
  Identities[o] = k;
end;

Controller.AddCheck = function(k, f)
  CheckTools[k] = f;
end;

Controller.GetType = type;

local ni = newproxy(true);
local mt = getmetatable(ni);
mt.__index = Controller;
mt.__tostring = function() return "Freya DataType controller" end;
mt.__metatable = "Locked Metatable: Freya"

for k,v in next, Controller do
  Controller[k] = function(i,...)
    if i == ni then
      return v(...);
    else
      return v(i, ...);
    end;
  end;
end;

return ni
