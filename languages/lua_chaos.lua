-- 史山代码: 文本冒险小游戏
math.randomseed(os.time())
-- 全局变量到处飞
SCORE = 0
INVENTORY = {}
ROOM = "大厅"
LOG = {}
-- 房间数据(魔数遍地)
ROOMS = {
    大厅 = {
        desc = "你在一个阴暗的大厅里,墙壁上挂满了发霉的画像",
        exits = { north = "厨房", east = "书房", south = "大门" },
        items = { "钥匙", "蜡烛" }
    },
    厨房 = {
        desc = "厨房里弥漫着奇怪的味道,灶台上有一口冒泡的锅",
        exits = { south = "大厅", west = "地窖" },
        items = { "蘑菇", "面包" }
    },
    书房 = {
        desc = "满是灰尘的书房,书架上歪歪斜斜地摆着各种古籍",
        exits = { west = "大厅", up = "阁楼" },
        items = { "地图", "墨水" }
    },
    地窖 = {
        desc = "黑暗潮湿的地窖,角落里有什么东西在蠕动",
        exits = { east = "厨房" },
        items = { "宝石", "骨头" }
    },
    阁楼 = {
        desc = "阁楼的窗户碎了,月光洒进来照亮了一个宝箱",
        exits = { down = "书房" },
        items = { "宝箱" }
    },
    大门 = {
        desc = "沉重的铁门紧锁着,你需要钥匙才能出去",
        exits = { north = "大厅" },
        items = {}
    }
}
-- 函数名故意起得很烂
function _f1(x)
    local o = ROOMS[x]
    if o then return o.desc else return "这里什么都没有" end
end
function _f2(x)
    local o = ROOMS[x]
    if not o then return {} end
    local e = {}
    for k,v in pairs(o.exits) do
        table.insert(e, k .. " -> " .. v)
    end
    return e
end
function _f3(x)
    local o = ROOMS[ROOM]
    if not o then return end
    for i = #o.items, 1, -1 do
        if o.items[i] == x then
            table.insert(INVENTORY, table.remove(o.items, i))
            SCORE = SCORE + 10
            print("捡起了 " .. x .. " (+10分)")
            return
        end
    end
    print("这里没有 " .. x)
end
function _f4()
    print("\n背包: " .. (#INVENTORY > 0 and table.concat(INVENTORY, ", ") or "空的"))
    print("分数: " .. SCORE)
    print("房间: " .. ROOM)
end
function _f5()
    if ROOM == "大门" then
        for _,v in ipairs(INVENTORY) do
            if v == "钥匙" then
                print("\n你用钥匙打开了铁门!")
                print("恭喜通关! 最终得分: " .. SCORE)
                return true
            end
        end
        print("铁门锁着,你需要钥匙")
        return false
    end
    return false
end
-- 主循环(逻辑混乱版)
print("=== 史山文字冒险 ===")
print("命令: look/go/quit/take/inventory")
print("================================\n")
while true do
    print("\n--- " .. ROOM .. " ---")
    print(_f1(ROOM))
    local exits = _f2(ROOM)
    if #exits > 0 then
        print("出口: " .. table.concat(exits, " | "))
    end
    local o = ROOMS[ROOM]
    if o and #o.items > 0 then
        print("物品: " .. table.concat(o.items, ", "))
    end
    io.write("> ")
    local input = io.read()
    if not input then break end
    input = input:match("^%s*(.-)%s*$")
    if input == "quit" or input == "q" then
        print("再见!")
        break
    elseif input == "look" or input == "l" then
        -- 已经自动显示了
    elseif input == "inventory" or input == "i" then
        _f4()
    elseif input:sub(1,3) == "go " then
        local dir = input:sub(4)
        local next_room = ROOMS[ROOM] and ROOMS[ROOM].exits[dir]
        if next_room then
            ROOM = next_room
            SCORE = SCORE + 5
            table.insert(LOG, "去了" .. next_room)
        else
            print("不能往 " .. dir .. " 走")
        end
    elseif input:sub(1,5) == "take " then
        local item = input:sub(6)
        _f3(item)
    elseif input == "win" then
        if _f5() then break end
    else
        print("不懂你在说什么(试试 look/go/take/inventory/quit)")
    end
    -- 随机事件(30%概率触发)
    if math.random(100) < 30 then
        local events = {
            "一阵冷风吹过...",
            "远处传来奇怪的声音...",
            "地板下似乎有东西在爬...",
            "蜡烛的火焰摇曳了一下...",
            "你听到墙壁里有什么东西在动..."
        }
        print("\n[" .. events[math.random(#events)) .. "]")
    end
end
print("\n游戏结束! 你探索了 " .. #LOG .. " 个房间,得分 " .. SCORE)
