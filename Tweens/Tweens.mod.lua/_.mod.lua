local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin  = math.asin

local tweens = {}

function tweens.linear(t, b, c, d)
  return c * t / d + b
end

function tweens.inQuad(t, b, c, d)
  t = t / d
  return c * pow(t, 2) + b
end

function tweens.outQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end

function tweens.inCubic (t, b, c, d)
  t = t / d
  return c * pow(t, 3) + b
end

function tweens.outCubic(t, b, c, d)
  t = t / d - 1
  return c * (pow(t, 3) + 1) + b
end

function tweens.inQuart(t, b, c, d)
  t = t / d
  return c * pow(t, 4) + b
end

function tweens.outQuart(t, b, c, d)
  t = t / d - 1
  return -c * (pow(t, 4) - 1) + b
end

function tweens.inQuint(t, b, c, d)
  t = t / d
  return c * pow(t, 5) + b
end

function tweens.outQuint(t, b, c, d)
  t = t / d - 1
  return c * (pow(t, 5) + 1) + b
end

function tweens.inSine(t, b, c, d)
  return -c * cos(t / d * (pi / 2)) + c + b
end

function tweens.outSine(t, b, c, d)
  return c * sin(t / d * (pi / 2)) + b
end

function tweens.inExpo(t, b, c, d)
  if t == 0 then
    return b
  else
    return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
  end
end

function tweens.outExpo(t, b, c, d)
  if t == d then
    return b + c
  else
    return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
  end
end

function tweens.inCirc(t, b, c, d)
  t = t / d
  return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end

function tweens.outCirc(t, b, c, d)
  t = t / d - 1
  return(c * sqrt(1 - pow(t, 2)) + b)
end

function tweens.inElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d

  if t == 1  then return b + c end

  if not p then p = d * 0.3 end

  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end

  t = t - 1

  return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

-- a: amplitud
-- p: period
function tweens.outElastic(t, b, c, d, a, p)
  if t == 0 then return b end

  t = t / d

  if t == 1 then return b + c end

  if not p then p = d * 0.3 end

  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end

  return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

function tweens.inBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d
  return c * t * t * ((s + 1) * t - s) + b
end

function tweens.outBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end

function tweens.outBounce(t, b, c, d)
  t = t / d
  if t < 1 / 2.75 then
    return c * (7.5625 * t * t) + b
  elseif t < 2 / 2.75 then
    t = t - (1.5 / 2.75)
    return c * (7.5625 * t * t + 0.75) + b
  elseif t < 2.5 / 2.75 then
    t = t - (2.25 / 2.75)
    return c * (7.5625 * t * t + 0.9375) + b
  else
    t = t - (2.625 / 2.75)
    return c * (7.5625 * t * t + 0.984375) + b
  end
end

function tweens.inBounce(t, b, c, d)
  return c - tweens.outBounce(d - t, 0, c, d) + b
end

tweens.Factored = require(script.Factored)


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
local function combinedTween(tweenA, tweenB, t, b, c, d, ...)
  if t < d*0.5 then
    return tweenA(t*2, b, c*0.5, d, ...)
  else
    return tweenB(t*2 - d, b + c*0.5, c*0.5, d, ...)
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
