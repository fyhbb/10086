#!/bin/bash
# 混乱shell脚本

# 随机emoji
emoji() {
    local emojis=("😀" "🚀" "💀" "🎮" "🔥" "💀" "🎯" "🎲")
    echo ${emojis[$RANDOM % ${#emojis[@]}]}
}

# 混乱的进度条
bar() {
    local progress=$1
    local width=50
    local filled=$((progress * width / 100))
    local empty=$((width - filled))
    printf "["
    printf "%0.s█" $(seq 1 $filled 2>/dev/null) || true
    printf "%0.s░" $(seq 1 $empty 2>/dev/null) || true
    printf "] %d%%\n" $progress
}

# 随机操作
echo "$(emoji) 系统初始化..."
sleep 1

for i in {1..5}; do
    echo "$(emoji) 处理中..."
    bar $((i * 20))
    sleep 0.5
done

echo "$(emoji) 完成！"

# 随机生成文件
echo "生成随机文件..."
for i in {1..3}; do
    filename="file_$(date +%s)_$RANDOM.txt"
    echo "随机内容: $RANDOM" > "$filename"
    echo "创建: $filename"
done

# 系统信息
echo ""
echo "=== 系统信息 ==="
echo "主机名: $(hostname)"
echo "用户: $(whoami)"
echo "日期: $(date)"
echo "随机数: $RANDOM"

# 随机ASCII艺术
echo ""
echo "    /\_/\  "
echo "   ( o.o ) "
echo "    > ^ <  "
echo "   /|   |\ "
echo "  (_|   |_)"