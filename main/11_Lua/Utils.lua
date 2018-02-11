
Utils = {}

local curTime = 1429283677
local curNum = 10.5
local curTab = {1, 2, 3, 4}
local curStr = "Hello"
local curStrTab = {'a', 'b', 'c', 'd'}

--将秒转成"年/月/日"
function Utils.remainTimeToDates(times)
    local tab = os.date("*t", times);
  local dates = tab.year.."/"..tab.month.."/"..tab.day
  return dates
end

--print(Utils.remainTimeToDates(curTime))

--将秒转成"年.月.日 小时:分钟:秒"
function Utils.remainTimeToDateTime(times)
    local tab = os.date("*t", times)
  local dates = string.format("%d.%d.%d %02d:%02d:%02d",tab.year,tab.month,tab.day,tab.hour,tab.min,tab.sec)
  return dates
end

--print(Utils.remainTimeToDateTime(curTime))

--将时间格式化为hh:mm:ss,主要用于倒计时
function Utils.remainTimeToStringHHMMSS(remainTime)
    if not remainTime or remainTime <= 0 then
        return "00:00:00"
    end
    local h = math.floor(remainTime/1000/60/60)
    local m = math.floor(remainTime/1000/60)%60
    local s = math.floor(remainTime/1000)%60
    return string.format("%02d:%02d:%02d",h,m,s)
end

--print(Utils.remainTimeToStringHHMMSS(curTime))

--将时间格式化为mm:ss,主要用于倒计时
function Utils.remainTimeToStringMMSS(remainTime)
    if not remainTime or remainTime <= 0 then
        return "00:00"
    end
    local h = math.floor(remainTime/1000/60/60)
    local m = math.floor(remainTime/1000/60)%60
    local s = math.floor(remainTime/1000)%60
    return string.format("%02d:%02d",m,s)
end

--print(Utils.remainTimeToStringMMSS(curTime))

--将浮点数转化为整数
function Utils.floatToInt(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

--print(Utils.floatToInt(curNum))

--字符串转成table
function Utils.stringToArray(str)
  local i = 1
  local tab = {}
  while i <= #str  do
    local c = str:sub(i, i)
    local ord = c:byte()
    if ord > 128 then
      table.insert(tab, str:sub(i, i + 2))
      i = i + 3
    else
      table.insert(tab, c)
      i = i + 1
    end
  end
  return tab
end

for k, v in ipairs(Utils.stringToArray(curStr)) do
  --print("k:"..k.."   v:"..v)
end

--table转成字符串
function Utils.tableToString(tab,text)
  local str = ""
  if type(text) == 'string' then
    str = "['"..text.."']".."={"
  else
    str = "{"
  end
  
    if tab then
        for k,v in pairs(tab) do
        if type(v) == 'table' then
          str = str..self.tableToString(v, k)..","
        else
          if type(k) == 'string' then
              str = str.."['"..k.."']".."="
          end
          if type(v) == 'string' then
                str = str.."'"..v.."',"
          elseif type(v) == 'boolean' then
            str = str..(v and 'true' or 'false')..","
          else
            str = str..v..","
          end
        end
        end
     else
        str= str.."null,"
     end
  str = str.."}"
    return str
end

--print(Utils.tableToString(curTab,"rrr"))

--字符数组转换成整形数组
function Utils.strArrToIntArr(strArr)
  local intArr = {}
  for k,v in ipairs(strArr) do
    intArr[k] = string.byte(v)
  end
  
  return intArr
end

for k, v in pairs(Utils.strArrToIntArr(curStrTab)) do
  --print("k:"..k.."   v:"..v)
end

--四舍五入
function Utils.round(num)
    if math.ceil(num) - num <= 0.5 then
        return math.ceil(num)
    else
        return math.floor(num)
    end    
end

--print(Utils.round(curNum))

--计算两点的距离
function Utils.calcPointsDistance(p1, p2)
    return math.sqrt(math.pow((p1.x - p2.x), 2) + math.pow((p1.y - p2.y), 2))
end

--print(Utils.calcPointsDistance({x=1, y=2}, {x=3, y=4}))

--table深度拷贝
function Utils.DeepCopy(object)
    local backup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif backup_table[object] then
            return backup_table[object]
        end
    
        local new_table = {}
        backup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

for k, v in pairs(Utils.DeepCopy(curTab)) do
  --print("k:"..k.."   v:"..v)
end