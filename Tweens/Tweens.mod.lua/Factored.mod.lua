local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin  = math.asin

local function linear(i)
  return i
end

local function inQuad(i)
  return i*i
end

local function outQuad(i)
  return -i * (i - 2)
end

local function inOutQuad(i)
  i = i * 2
  if i < 1 then
    return 0.5 * i^2
  else
    return -0.5 * ((i - 1) * (i - 3) - 1)
  end
end

local function outInQuad(i)
  if i < 0.5 then
    return outQuad(i*2)*0.5
  else
    return 0.5 + inQuad(i*2)*0.5
  end
end

local function inCubic (i)
  return i*i*i
end

local function outCubic(i)
  i = i - 1
  return i*i*i + 1
end

local function inOutCubic(i)
  i = i * 2
  if i < 1 then
    return i*i*i*0.5
  else
    i = i - 2
    return (i * i * i + 2) * 0.5
  end
end

local function outInCubic(i)
  if i < 0.5 then
    return outCubic(i*2)*0.5
  else
    return 0.5+inCubic((i * 2) - 1)*2
  end
end

local function inQuart(i)
  return i*i*i*i
end

local function outQuart(i)
  i = i-1
  return (-i*i*i*i - 1)
end

local function inOutQuart(i)
  i = i * 2
  if i < 1 then
    return 0.5 * i*i*i*i
  else
    i = i - 2
    return -0.5*(i*i*i*i - 2)
  end
end

local function outInQuart(i)
  if i < 0.5 then
    return outQuart(i*2)*0.5
  else
    return 0.5+inQuart((i * 2) - 1)*0.5
  end
end

local function inQuint(i)
  return i*i*i*i*i
end

local function outQuint(i)
  i = i - 1
  return i*i*i*i*i + 1
end

local function inOutQuint(i)
  i = i * 2
  if i < 1 then
    return 0.5*i*i*i*i*i
  else
    i = i - 2
    return 0.5 * (i*i*i*i*i + 2)
  end
end

local function outInQuint(i)
  if i < 0.5 then
    return outQuint(i*2)*0.5
  else
    return 0.5+inQuint((i * 2) - 1)*0.5
  end
end

local function inSine(i)
  return 1 - cos(i * pi * 0.5)
end

local function outSine(i)
  return sin(i * pi * 0.5)
end

local function inOutSine(i)
  return -0.5 * (cos(pi * i) - 1)
end

local function outInSine(i)
  if i < 0.5 then
    return outSine(i * 2)*0.5
  else
    return 0.5+inSine((i * 2)-1)*0.5
  end
end

local function inExpo(i)
  if i == 0 then
    return 0
  else
    return 2 ^ (10 * (i - 1)) - 0.001
  end
end

local function outExpo(i)
  if i == 1 then
    return 1
  else
    return 1.001 * (-1 * 2 ^ -10 * t / d) + 1) + b
  end
end

local function inOutExpo(i)
  if i == 0 then return 0 end
  if i == 1 then return 1 end
  i = i*2
  if i < 1 then
    return 0.5 * 2 ^ (10 * (i - 1)) - 0.0005
  else
    i = i - 1
    return 0.50025 * (2-(2 ^ (-10 * i))
  end
end

local function outInExpo(t, b, c, d)
  if t < d / 2 then
    return outExpo(t * 2, b, c / 2, d)
  else
    return inExpo((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local function inCirc(t, b, c, d)
  t = t / d
  return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end

local function outCirc(t, b, c, d)
  t = t / d - 1
  return(c * sqrt(1 - pow(t, 2)) + b)
end

local function inOutCirc(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return -c / 2 * (sqrt(1 - t * t) - 1) + b
  else
    t = t - 2
    return c / 2 * (sqrt(1 - t * t) + 1) + b
  end
end

local function outInCirc(t, b, c, d)
  if t < d / 2 then
    return outCirc(t * 2, b, c / 2, d)
  else
    return inCirc((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local function inBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d
  return c * t * t * ((s + 1) * t - s) + b
end

local function outBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end

local function inOutBack(t, b, c, d, s)
  if not s then s = 1.70158 end
  s = s * 1.525
  t = t / d * 2
  if t < 1 then
    return c / 2 * (t * t * ((s + 1) * t - s)) + b
  else
    t = t - 2
    return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
  end
end

local function outInBack(t, b, c, d, s)
  if t < d / 2 then
    return outBack(t * 2, b, c / 2, d, s)
  else
    return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
  end
end

local function outBounce(t, b, c, d)
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

local function inBounce(t, b, c, d)
  return c - outBounce(d - t, 0, c, d) + b
end

local function inOutBounce(t, b, c, d)
  if t < d / 2 then
    return inBounce(t * 2, 0, c, d) * 0.5 + b
  else
    return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
  end
end

local function outInBounce(t, b, c, d)
  if t < d / 2 then
    return outBounce(t * 2, b, c / 2, d)
  else
    return inBounce((t * 2) - d, b + c / 2, c / 2, d)
  end
end

local ret = {
  linear = linear,
  inQuad = inQuad,
  outQuad = outQuad,
  inOutQuad = inOutQuad,
  outInQuad = outInQuad,
  inCubic  = inCubic ,
  outCubic = outCubic,
  inOutCubic = inOutCubic,
  outInCubic = outInCubic,
  inQuart = inQuart,
  outQuart = outQuart,
  inOutQuart = inOutQuart,
  outInQuart = outInQuart,
  inQuint = inQuint,
  outQuint = outQuint,
  inOutQuint = inOutQuint,
  outInQuint = outInQuint,
  inSine = inSine,
  outSine = outSine,
  inOutSine = inOutSine,
  outInSine = outInSine,
  inExpo = inExpo,
  outExpo = outExpo,
  inOutExpo = inOutExpo,
  outInExpo = outInExpo,
  inCirc = inCirc,
  outCirc = outCirc,
  inOutCirc = inOutCirc,
  outInCirc = outInCirc,
  inElastic = inElastic,
  outElastic = outElastic,
  inOutElastic = inOutElastic,
  outInElastic = outInElastic,
  inBack = inBack,
  outBack = outBack,
  inOutBack = inOutBack,
  outInBack = outInBack,
  inBounce = inBounce,
  outBounce = outBounce,
  inOutBounce = inOutBounce,
  outInBounce = outInBounce,
}

local copy = {};
for k, v in next, ret do
	copy[k] = v;
end
for k, v in next, copy do
	ret[k:lower()] = v;
end

return ret;
