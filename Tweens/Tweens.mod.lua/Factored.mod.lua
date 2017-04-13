local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin  = math.asin

local tweens = {}

function tweens.linear(i)
  return i
end

function tweens.inQuad(i)
  return i*i
end

function tweens.outQuad(i)
  return -i * (i - 2)
end

function tweens.inCubic (i)
  return i*i*i
end

function tweens.outCubic(i)
  i = i - 1
  return i*i*i + 1
end

function tweens.inQuart(i)
  return i*i*i*i
end

function tweens.outQuart(i)
  i = i-1
  return -(i*i*i*i - 1)
end

function tweens.inQuint(i)
  return i*i*i*i*i
end

function tweens.outQuint(i)
  i = i - 1
  return i*i*i*i*i + 1
end

function tweens.inSine(i)
  return 1 - cos(i * pi * 0.5)
end

function tweens.outSine(i)
  return sin(i * pi * 0.5)
end

function tweens.inExpo(i)
  if i == 0 then
    return 0
  else
    return 2 ^ (10 * (i - 1)) - 0.001
  end
end

function tweens.outExpo(i)
  if i == 1 then
    return 1
  else
    return 1.001 * (-1 * 2 ^ (-10 * i) + 1)
  end
end

function tweens.inCirc(i)
  return 1 - sqrt(1 - i*i)
end

function tweens.outCirc(i)
  i = i - 1
  return sqrt(1 - i*i)
end

-- a: amplitude
-- p: period
function tweens.inElastic(i, a, p)
  local s

  if i == 0  or i == 1 then
    return i
  end

  p = p or 0.3
  a = a or 1

  if a <= 1 then
    s = p / 4
  else
    s = p / (2 * pi) * asin(1/a)
  end

  i = i - 1

  return -(a * pow(2, 10*i) * sin((i - s) * (2*pi) / p))
end

function tweens.outElastic(i, a, p)
  local s

  if i == 0  or i == 1 then
    return i
  end

  p = p or 0.3
  a = a or 1

  if a <= 1 then
    s = p / 4
  else
    s = p / (2 * pi) * asin(1/a)
  end

  return a * pow(2, -10 * i) * sin((i - s) * (2*pi) / p) + 1
end

function tweens.inBack(i, s)
  s = s or 1.70158
  return i*i * ((s + 1)*i - s)
end

function tweens.outBack(i, s)
  s = s or 1.70158
  i = i - 1
  return i*i * ((s + 1)*i + s) + 1
end

function tweens.outBounce(i)
  if i < 1 / 2.75 then
    return 7.5625 * i*i
  elseif i < 2 / 2.75 then
    i = i - (1.5 / 2.75)
    return 7.5625 * i*i + 0.75
  elseif i < 2.5 / 2.75 then
    i = i - (2.25 / 2.75)
    return 7.5625 * i*i + 0.9375
  else
    i = i - (2.625 / 2.75)
    return 7.5625 * i*i + 0.984375
  end
end

function tweens.inBounce(i)
  return 1 - tweens.outBounce(1 - i)
end

local directionalTweens = {
  "Quad",
  "Cubic",
  "Quart",
  "Quint",
  "Sine",
  "Expo",
  "Circ",
  "Elastic",
  "Back",
  "Bounce"
}

-- InOut/OutIn tween generation
local function combinedTween(tweenA, tweenB, i, ...)
  if i < 0.5 then
    return tweenA(i*2, ...)*0.5
  else
    return 0.5 + tweenB(i*2 - 1, ...)*0.5
  end
end

for i, tween in next, directionalTweens do
  local inTween = tweens["in" .. tween]
  local outTween = tweens["out" .. tween]

  tweens["inOut" .. tween] = function(...)
    return combinedTween(inTween, outTween, ...)
  end

  tweens["outIn" .. tween] = function(...)
    return combinedTween(outTween, inTween, ...)
  end
end


-- Lowercase tween aliases
local copy = {};
for k, v in next, tweens do
  copy[k] = v;
end
for k, v in next, copy do
  tweens[k:lower()] = v;
end

return tweens;
