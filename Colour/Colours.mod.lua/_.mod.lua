local Colours = {
  Google = require(script.Material);
  IBM = require(script.IBM);
  fromHex = function(h)
    h = h:gsub('^#','');
    return Color3.fromRGB(
      tonumber(h:sub(1,2), 16),
      tonumber(h:sub(3,4), 16),
      tonumber(h:sub(5,6), 16)
    );
  end;
};

Colours.Material = Colours.Google;

return Colours;
