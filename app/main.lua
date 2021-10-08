local luvi = require('luvi');
_G.loadModule = function (idf,path)
  idf = idf:match("%.?([^%.]+)$");
  luvi.bundle.register(idf,path);
  return require(idf);
end;

local fs = require("fs");
io.write("\n[ 그래프로 그림 그리기 ]\n\27[33m그릴 수 있는 그래프들은 다음과 같습니다\27[0m\n──────────────────────────────────────\n");
local items = fs.readdirSync("./graphs");
for i,str in ipairs(items) do
  io.write(("\27[32m%d 번\27[0m : %s\n"):format(i,str));
end
io.write("──────────────────────────────────────\n\27[33m출력할 그래프의 번호를 입력하세요 : \27[0m");
local input = io.read();
local this = items[tonumber(input)];
if not this then
  io.write("해당 그래프는 존재하지 않습니다!");
  os.exit(1);
end

local draw = loadModule("draw","./draw.lua")--require("draw");
local file = io.open("./graphs/" .. this);
local str = file:read("*a");
file:close();
io.write(
  draw:draw(
    draw:funcFromStr(str),
    -- xSize,ySize,mut,title
    88,38,10,this
  ),
  draw:footer(str)
);
