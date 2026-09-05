// Dart混乱代码
// 功能：简单的游戏引擎
// 作者：某个不想透露姓名的程序员

import 'dart:math';
import 'dart:io';

class ChaosGame {
  // 全局变量，别问为什么
  int _score = 0;
  int _level = 1;
  bool _isRunning = true;
  Random _random = Random();
  List<int> _numbers = [];
  String _playerName = "Player";
  
  // 构造函数
  ChaosGame(this._playerName) {
    _initGame();
  }
  
  // 初始化游戏
  void _initGame() {
    _score = 0;
    _level = 1;
    _numbers = List.generate(10, (index) => _random.nextInt(100));
    print("游戏初始化完成！");
    print("玩家: $_playerName");
    print("初始分数: $_score");
  }
  
  // 主游戏循环
  void startGame() {
    print("\n=== 混沌游戏开始 ===\n");
    
    while (_isRunning) {
      _playRound();
      _checkLevelUp();
      _displayStatus();
      
      // 魔数判断
      if (_score > 100) {
        print("恭喜！你获得了高分！");
        _isRunning = false;
      }
      
      if (_level > 5) {
        print("游戏结束！你达到了最高级别！");
        _isRunning = false;
      }
    }
    
    print("\n=== 游戏结束 ===");
    print("最终分数: $_score");
    print("最终级别: $_level");
  }
  
  // 游戏回合
  void _playRound() {
    int num1 = _random.nextInt(10);
    int num2 = _random.nextInt(10);
    int operation = _random.nextInt(4); // 0: +, 1: -, 2: *, 3: /
    
    String opSymbol;
    int result;
    
    switch (operation) {
      case 0:
        opSymbol = '+';
        result = num1 + num2;
        break;
      case 1:
        opSymbol = '-';
        result = num1 - num2;
        break;
      case 2:
        opSymbol = '*';
        result = num1 * num2;
        break;
      case 3:
        opSymbol = '/';
        result = (num2 != 0) ? (num1 ~/ num2) : 0;
        break;
      default:
        opSymbol = '+';
        result = num1 + num2;
    }
    
    print("计算: $num1 $opSymbol $num2 = ?");
    
    // 模拟玩家输入（实际应用中应该获取真实输入）
    int playerAnswer = result + _random.nextInt(3) - 1; // 有误差
    
    if (playerAnswer == result) {
      _score += 10 * _level;
      print("正确！加 ${10 * _level} 分");
    } else {
      _score -= 5;
      print("错误！正确答案是 $result");
    }
    
    _numbers.add(result);
  }
  
  // 检查升级
  void _checkLevelUp() {
    if (_score >= _level * 50) {
      _level++;
      print("\n*** 升级到级别 $_level ***\n");
    }
  }
  
  // 显示状态
  void _displayStatus() {
    print("分数: $_score | 级别: $_level | 数字数量: ${_numbers.length}");
  }
  
  // 工具函数
  List<int> sortNumbers() {
    List<int> sorted = List.from(_numbers);
    sorted.sort();
    return sorted;
  }
  
  double calculateAverage() {
    if (_numbers.isEmpty) return 0;
    int sum = _numbers.reduce((a, b) => a + b);
    return sum / _numbers.length;
  }
}

// 主函数
void main() {
  // 创建游戏实例
  ChaosGame game = ChaosGame("混沌玩家");
  
  // 开始游戏
  game.startGame();
  
  // 显示统计信息
  print("\n=== 统计信息 ===");
  print("平均值: ${game.calculateAverage()}");
  print("排序后的数字: ${game.sortNumbers()}");
}