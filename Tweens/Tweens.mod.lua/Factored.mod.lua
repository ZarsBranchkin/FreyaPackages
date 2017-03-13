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
    return 1.001 * (-1 * 2 ^ (-10 * i) + 1)
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

local function outInExpo(i)
  if i < 0.5 then
    return outExpo(i*2)*0.5
  else
    return 0.5+inExpo(i*2)*0.5
  end
end

local function inCirc(i)
  return 1 - sqrt(1 - i*i)
end

local function outCirc(i)
  i = i - 1
  return sqrt(1 - i*i)
end

local function inOutCirc(i)
  i = i*2
  if i < 1 then
    return -0.5 * (sqrt(1 - i*i) - 1) 
  else
    i = i - 2
    return 0.5 * (sqrt(1 - i*i) + 1) 
  end
end

local function outInCirc(i)
  if i < 0.5 then
    return outCirc(i*2)*0.5
  else
    return 0.5+inCirc(i*2)*0.5
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
  outInCirc = outInCirc
}

local copy = {};
for k, v in next, ret do
	copy[k] = v;
end
for k, v in next, copy do
	ret[k:lower()] = v;
end

return ret;
