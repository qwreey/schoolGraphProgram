local module = {};

-- 그래프 해더와 바닥글을 생성
function module:drawHeader(title,size)
  local titlebarSize = (size-2)/2-(utf8.len(title)/2);
  return
    "\n┌" .. string.rep("─",math.floor(titlebarSize+0.5)) .. title .. string.rep("─",math.floor(titlebarSize)) .. "┐\n",
    "\n└" .. string.rep("─",size-2) .. "┘\n"
end

local continue = function()end;
local function each(table,func)
  for index,value in pairs(table) do
    local ret = func(index,value);
    if ret ~= continue and ret then
      break;
    end
  end
end
local colors = { -- 색깔 지정
  31;
  32;
  33;
  34;
  35;
  36;
  37;
  90;
  92;
  93;
  94;
  95;
  96;
  97;
};

local graphText = "\27[%dm#\27[0m";
function module:draw(func,SizeX,SizeY,Mut,title) -- 그래프를 그림
	if title then
		title = (" [ %s ] "):format(title);
	end
	SizeX = SizeX or 90;
	SizeY = SizeY or 38;
	Mut = Mut or 10

	local screen = {};
	local contX = math.floor(SizeX/2+0.5);
	local contY = math.floor(SizeY/2);

	-- make graph
	for x = -math.floor(SizeX/2),math.floor(SizeX/2+0.5) do -- loop for each x value 
		-- loop for each lines
    local values = {};
    each({func(x / SizeX * Mut)},function (i,v)
      values[i] = math.floor((1 - (v/Mut)) * SizeY - contY);
    end);
		for indexY = 1,SizeY do
			local isCorrect;
      each(values,function (i,v) -- get values from function and handle it the each values
        isCorrect = (v == indexY) and (graphText:format(colors[i])); -- just check floored y and indexY are have same value
        return isCorrect;
      end);
      local blank = x == 0 and "." or (indexY == contY and "." or " "); --  fill with space or Y/X line
      -- draw it
			screen[indexY] = (screen[indexY] or "") -- load last value from array
				.. (isCorrect or blank);
		end
	end

	-- print border and graph in screen
	local header,footer = self:drawHeader(title,SizeX+3);
	return (
		header .. "│" ..
		table.concat(screen,"│\n│") .. 
		"│" .. footer
	);
end

-- string 으로 받아낸걸 (읽은 파일) function 으로 변경 (수행 가능하도록 변경)
function module:funcFromStr(str)
  local this = loadstring("return function(x)\nreturn " .. str .. ";\nend;");
  if not this then
    error("something wrong on formula, check ur input!\n");
  end
  setfenv(this,setmetatable({
    sin = math.sin;
    cos = math.cos;
    abs = math.abs;
    tan = math.tan;
    atan = math.atan;
    acos = math.acos;
    asin = math.asin;
    inf = math.huge;
    log = math.log;
    exp = math.exp;
  },{
    __index = _G;
    __newindex = _G;
  }));
  return this();
end

-- 바닥글 작성
local namespace = "fghijklmnopqrstuwuvzabcdeFGHIJKLMNOPQRSTUWUVZABCDE";
function module:footer(str)
  local this,index = "",1;
  str:gsub("[^\n]+",function(item)
    if item:sub(-1,-1) == "," then
      item = item:sub(1,-2);
    end
    this = this .. ("\27[%dm"):format(colors[index]) .. namespace:sub(index,index) .. "(x)\27[0m = " .. item .. "\n";
    index = index + 1;
  end);
  return this;
end

return module;
--renderGraph(funcFromFile(args[2]),88,38,10);
