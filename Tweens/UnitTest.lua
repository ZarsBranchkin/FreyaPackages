package.path = package.path .. ";./Tweens.mod.lua/?.mod.lua"
local lu = require "luaunit"

local origTweens = require "_"
local factTweens = require "Factored"

testTweens = {}

-- Generate test units
for tween, fun in pairs(factTweens) do
  local unitName = "test" .. tween:gsub("^%l", string.upper)

  testTweens[unitName] = function(self)
    for i=0,10 do
      lu.assertAlmostEquals(fun(i/10), origTweens[tween](i, 0, 1, 10), 0.00001)
    end
  end
end

os.exit(lu.LuaUnit.run())
