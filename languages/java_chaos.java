import java.util.*;

public class   chaos{
    private static Scanner   scanner=new Scanner(System.in);
    private static Random   random=new Random();
    private static int   score=0;
    
    public static void   main(String[] args){
        System.out.println("=== 混乱的Java游戏 ===");
        System.out.println("1. 石头剪刀布");
        System.out.println("2. 猜数字");
        System.out.println("3. 简易计算器");
        System.out.println("4. 数学函数");
        System.out.println("0. 退出");
        
        while(true){
            System.out.print("\n请选择操作(0-4): ");
            String   input=scanner.nextLine();
            int   choice;
            try{
                choice=Integer.parseInt(input);
            }catch(Exception e){
                System.out.println("输入无效！");
                continue;
            }
            
            switch(choice){
                case 0:
                    System.out.println("再见！");
                    return;
                case 1:
                    playRockPaperScissors();
                    break;
                case 2:
                    playGuessNumber();
                    break;
                case 3:
                    useCalculator();
                    break;
                case 4:
                    mathFunctions();
                    break;
                default:
                    System.out.println("无效选择！");
            }
        }
    }
    
    private static void   playRockPaperScissors(){
        System.out.println("\n=== 石头剪刀布 ===");
        System.out.println("1=石头, 2=剪刀, 3=布");
        
        while(true){
            System.out.print("你的选择(1-3, 0退出): ");
            String   input=scanner.nextLine();
            int   playerChoice;
            try{
                playerChoice=Integer.parseInt(input);
            }catch(Exception e){
                System.out.println("输入无效！");
                continue;
            }
            
            if(playerChoice==0) return;
            if(playerChoice<1 || playerChoice>3){
                System.out.println("请输入1-3！");
                continue;
            }
            
            int   computerChoice=random.nextInt(3)+1;
            String[]   choices={"石头","剪刀","布"};
            
            System.out.println("你出: "+choices[playerChoice-1]);
            System.out.println("电脑出: "+choices[computerChoice-1]);
            
            if(playerChoice==computerChoice){
                System.out.println("平局！");
            }else if((playerChoice==1 && computerChoice==2) ||
                     (playerChoice==2 && computerChoice==3) ||
                     (playerChoice==3 && computerChoice==1)){
                System.out.println("你赢了！");
                score+=10;
            }else{
                System.out.println("你输了！");
                score=Math.max(0,score-5);
            }
            System.out.println("当前分数: "+score);
        }
    }
    
    private static void   playGuessNumber(){
        System.out.println("\n=== 猜数字 ===");
        int   secret=random.nextInt(100)+1;
        int   attempts=0;
        
        System.out.println("我想了一个1-100的数字，你有10次机会！");
        
        while(attempts<10){
            System.out.print("第"+(attempts+1)+"次猜测: ");
            String   input=scanner.nextLine();
            int   guess;
            try{
                guess=Integer.parseInt(input);
            }catch(Exception e){
                System.out.println("请输入数字！");
                continue;
            }
            
            attempts++;
            
            if(guess==secret){
                System.out.println("🎉 恭喜你猜对了！");
                int   points=110-attempts*10;
                score+=points;
                System.out.println("获得"+points+"分，总分: "+score);
                return;
            }else if(guess<secret){
                System.out.println("猜小了！");
            }else{
                System.out.println("猜大了！");
            }
        }
        System.out.println("游戏结束！答案是: "+secret);
    }
    
    private static void   useCalculator(){
        System.out.println("\n=== 简易计算器 ===");
        System.out.print("输入表达式(如 2+3): ");
        String   input=scanner.nextLine();
        
        try{
            String[]   parts=input.split("(?<=[-+*/%])|(?=[-+*/%])");
            double   a=Double.parseDouble(parts[0].trim());
            String   op=parts[1].trim();
            double   b=Double.parseDouble(parts[2].trim());
            double   result=0;
            
            switch(op){
                case "+": result=a+b; break;
                case "-": result=a-b; break;
                case "*": result=a*b; break;
                case "/": result=a/b; break;
                case "%": result=a%b; break;
                default:
                    System.out.println("无效运算符！");
                    return;
            }
            System.out.println("结果: "+result);
        }catch(Exception e){
            System.out.println("表达式无效！");
        }
    }
    
    private static void   mathFunctions(){
        System.out.println("\n=== 数学函数 ===");
        System.out.println("1. 阶乘");
        System.out.println("2. 斐波那契");
        System.out.println("3. 判断质数");
        System.out.println("0. 返回");
        
        while(true){
            System.out.print("选择(0-3): ");
            String   input=scanner.nextLine();
            int   choice;
            try{
                choice=Integer.parseInt(input);
            }catch(Exception e){
                System.out.println("输入无效！");
                continue;
            }
            
            switch(choice){
                case 0: return;
                case 1:
                    System.out.print("输入n: ");
                    int   n1=Integer.parseInt(scanner.nextLine());
                    long   fact=1;
                    for(int i=2;i<=n1;i++) fact*=i;
                    System.out.println(n1+"! = "+fact);
                    break;
                case 2:
                    System.out.print("输入项数: ");
                    int   n2=Integer.parseInt(scanner.nextLine());
                    int   a=0,b=1;
                    for(int i=0;i<n2;i++){
                        System.out.print(a+" ");
                        int   temp=a+b;
                        a=b;
                        b=temp;
                    }
                    System.out.println();
                    break;
                case 3:
                    System.out.print("输入整数: ");
                    int   n3=Integer.parseInt(scanner.nextLine());
                    boolean   isPrime=n3>1;
                    for(int i=2;i*i<=n3;i++){
                        if(n3%i==0){isPrime=false;break;}
                    }
                    System.out.println(n3+(isPrime?"是":"不是")+"质数");
                    break;
            }
        }
    }
}