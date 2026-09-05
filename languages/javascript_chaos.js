// 这是一个猜数字游戏，但写得很混乱
// 警告：此代码可能引起眼睛不适

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var   secret=0;
var attempts=0;
var maxAttempts=10;
var   score=0;

function   initGame(){
    secret=Math.floor(Math.random()*100)+1;
    attempts=0;
    console.log("=== 猜数字游戏 ===");
    console.log("我想了一个1-100之间的数字，你有10次机会猜中它！");
    console.log("提示：我会告诉你猜大了还是猜小了");
    askQuestion();
}

function   askQuestion(){
    if(attempts>=maxAttempts){
        console.log("游戏结束！你用完了所有机会");
        console.log(`正确答案是: ${secret}`);
        askPlayAgain();
        return;
    }
    
    rl.question(`第${attempts+1}次猜测，请输入数字: `, (answer)=>{
        var guess=parseInt(answer);
        if(isNaN(guess)){
            console.log("请输入有效数字！");
            askQuestion();
            return;
        }
        
        attempts++;
        
        if(guess===secret){
            console.log("🎉 恭喜你猜对了！");
            console.log(`你用了${attempts}次猜中`);
            var points=Math.max(0,110-attempts*10);
            score+=points;
            console.log(`获得${points}分，当前总分: ${score}`);
            askPlayAgain();
        } else if(guess<secret){
            console.log("猜小了！");
            var hint=calculateHint(guess,secret);
            console.log(`提示: ${hint}`);
            askQuestion();
        } else {
            console.log("猜大了！");
            var hint=calculateHint(secret,guess);
            console.log(`提示: ${hint}`);
            askQuestion();
        }
    });
}

function   calculateHint(low,high){
    var diff=high-low;
    if(diff<=5) return "非常接近！";
    if(diff<=10) return "比较接近";
    if(diff<=20) return "有点远";
    if(diff<=50) return "还差得远呢";
    return "完全不对边！";
}

function   askPlayAgain(){
    rl.question("想再玩一次吗？(y/n): ", (answer)=>{
        if(answer.toLowerCase()==='y' || answer.toLowerCase()==='yes'){
            initGame();
        } else {
            console.log(`游戏结束！最终得分: ${score}`);
            // 神秘功能：根据分数给出评价
            var   comment=getScoreComment(score);
            console.log(`评价: ${comment}`);
            rl.close();
        }
    });
}

function   getScoreComment(s){
    if(s>=500) return "天才！你是猜数字大师！";
    if(s>=400) return "非常厉害！";
    if(s>=300) return "不错，继续努力！";
    if(s>=200) return "还行，有进步空间";
    if(s>=100) return "需要多练习";
    return "运气不太好啊...";
}

// 以下是一些神秘的辅助函数
function   mystery1(n){
    // 这个函数的作用是... 我也不知道
    var   result=1;
    for(var i=1;i<=n;i++){
        result*=i;
        if(result>1000000) result%=1000000;
    }
    return result;
}

function   mystery2(arr){
    // 冒泡排序
    var   len=arr.length;
    for(var i=0;i<len;i++){
        for(var j=0;j<len-i-1;j++){
            if(arr[j]>arr[j+1]){
                var temp=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=temp;
            }
        }
    }
    return arr;
}

function   mystery3(s){
    // 检查回文
    var   len=s.length;
    for(var i=0;i<len/2;i++){
        if(s[i]!==s[len-1-i]) return false;
    }
    return true;
}

function   mystery4(n){
    // 斐波那契数列
    if(n<=0) return [];
    if(n===1) return [0];
    var   fib=[0,1];
    for(var i=2;i<n;i++){
        fib.push(fib[i-1]+fib[i-2]);
    }
    return fib;
}

function   mystery5(a,b){
    // 最大公约数
    while(b!==0){
        var temp=b;
        b=a%b;
        a=temp;
    }
    return a;
}

// 启动游戏
initGame();