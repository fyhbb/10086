// Objective-C 混乱代码: 简易井字棋游戏
// 风格: 变量名极短，魔数满天飞，逻辑混乱，但能跑
#import <Foundation/Foundation.h>

@interface TicTacToe : NSObject {
    char _board[9];
    int _turn;
    int _moves;
    BOOL _gameOver;
    NSString *_lastMsg;
}
- (void)resetBoard;
- (void)printBoard;
- (BOOL)makeMove:(int)pos player:(int)p;
- (int)checkWinner;
- (int)miniMax:(int)depth isMax:(BOOL)max;
- (int)bestMove;
@end

@implementation TicTacToe
- (id)init {
    self = [super init];
    if (self) {
        _turn = 0; _moves = 0; _gameOver = NO;
        _lastMsg = @"";
        [self resetBoard];
    }
    return self;
}
- (void)resetBoard {
    for (int i = 0; i < 9; i++) _board[i] = '0' + i + 1;
    _turn = 0; _moves = 0; _gameOver = NO; _lastMsg = @"";
}
- (void)printBoard {
    NSLog(@"\n %c | %c | %c ", _board[0], _board[1], _board[2]);
    NSLog(@"---+---+---");
    NSLog(@" %c | %c | %c ", _board[3], _board[4], _board[5]);
    NSLog(@"---+---+---");
    NSLog(@" %c | %c | %c \n", _board[6], _board[7], _board[8]);
}
- (BOOL)makeMove:(int)pos player:(int)p {
    if (pos < 0 || pos > 8) return NO;
    if (_board[pos] == 'X' || _board[pos] == 'O') return NO;
    _board[pos] = (p == 0) ? 'X' : 'O';
    _moves++; _turn = 1 - _turn;
    int w = [self checkWinner];
    if (w == 1) { _lastMsg = @"X 获胜!"; _gameOver = YES; }
    else if (w == 2) { _lastMsg = @"O 获胜!"; _gameOver = YES; }
    else if (_moves == 9) { _lastMsg = @"平局!"; _gameOver = YES; }
    return YES;
}
- (int)checkWinner {
    int wins[8][3] = {{0,1,2},{3,4,5},{6,7,8},{0,3,6},{1,4,7},{2,5,8},{0,4,8},{2,4,6}};
    for (int i = 0; i < 8; i++) {
        int a = wins[i][0], b = wins[i][1], c = wins[i][2];
        if (_board[a] == _board[b] && _board[b] == _board[c]) {
            if (_board[a] == 'X') return 1;
            if (_board[a] == 'O') return 2;
        }
    }
    return 0;
}
- (int)miniMax:(int)depth isMax:(BOOL)max {
    int score = [self checkWinner];
    if (score == 1) return 10 - depth;
    if (score == 2) return depth - 10;
    if (_moves == 9) return 0;
    if (max) {
        int best = -100;
        for (int i = 0; i < 9; i++) {
            if (_board[i] != 'X' && _board[i] != 'O') {
                char bk = _board[i]; _board[i] = 'O'; _moves++;
                int v = [self miniMax:depth+1 isMax:NO];
                _board[i] = bk; _moves--;
                if (v > best) best = v;
            }
        }
        return best;
    } else {
        int best = 100;
        for (int i = 0; i < 9; i++) {
            if (_board[i] != 'X' && _board[i] != 'O') {
                char bk = _board[i]; _board[i] = 'X'; _moves++;
                int v = [self miniMax:depth+1 isMax:YES];
                _board[i] = bk; _moves--;
                if (v < best) best = v;
            }
        }
        return best;
    }
}
- (int)bestMove {
    int bv = -100, bp = -1;
    for (int i = 0; i < 9; i++) {
        if (_board[i] != 'X' && _board[i] != 'O') {
            char bk = _board[i]; _board[i] = 'O'; _moves++;
            int v = [self miniMax:0 isMax:NO];
            _board[i] = bk; _moves--;
            if (v > bv) { bv = v; bp = i; }
        }
    }
    return bp;
}
- (void)playGame {
    [self resetBoard];
    NSLog(@"=== 混乱井字棋 ===");
    NSLog(@"你(X) vs AI(O), 输入1-9选位置");
    while (!_gameOver) {
        [self printBoard];
        if (_turn == 0) {
            NSLog(@"你的回合: ");
            int pos; scanf("%d", &pos);
            if (![self makeMove:--pos player:0]) { NSLog(@"无效!"); continue; }
        } else {
            int mv = [self bestMove];
            if (mv >= 0) [self makeMove:mv player:1];
            NSLog(@"AI选择: %d", mv + 1);
        }
    }
    [self printBoard];
    NSLog(@"%@", _lastMsg);
    NSLog(@"总步数: %d", _moves);
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        TicTacToe *game = [[TicTacToe alloc] init];
        [game playGame];
        NSLog(@"程序结束.");
    }
    return 0;
}
