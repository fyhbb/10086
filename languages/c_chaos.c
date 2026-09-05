#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

#define PI 3.14159265358979

// 全局变量，随意命名
int   g_x=0,g_y=0;
char   g_str[100]="";

// 函数声明
void   func1(),func2(),func3(),func4();
int   func5(int n),func6(int arr[],int n);

int   main(){
    srand(time(NULL));
    
    printf("=== 混乱的C语言程序 ===\n");
    printf("1. 简易计算器\n");
    printf("2. 猜数字游戏\n");
    printf("3. 数学函数\n");
    printf("4. 字符串处理\n");
    printf("0. 退出\n");
    
    while(1){
        int   choice;
        printf("\n请选择操作(0-4): ");
        if(scanf("%d",&choice)!=1){
            while(getchar()!='\n');
            printf("输入无效！\n");
            continue;
        }
        
        switch(choice){
            case 0: printf("再见！\n");return 0;
            case 1: func1();break;
            case 2: func2();break;
            case 3: func3();break;
            case 4: func4();break;
            default: printf("无效选择！\n");
        }
    }
}

// 简易计算器
void   func1(){
    printf("\n=== 简易计算器 ===\n");
    double   a,b;
    char   op;
    
    printf("输入表达式(如 2+3): ");
    scanf("%lf%c%lf",&a,&op,&b);
    
    double   result=0;
    int   valid=1;
    
    switch(op){
        case '+': result=a+b;break;
        case '-': result=a-b;break;
        case '*': result=a*b;break;
        case '/':
            if(b==0){printf("除数不能为0！\n");valid=0;}
            else result=a/b;
            break;
        case '%':
            if(b==0){printf("除数不能为0！\n");valid=0;}
            else result=fmod(a,b);
            break;
        default: printf("无效运算符！\n");valid=0;
    }
    
    if(valid) printf("结果: %g\n",result);
}

// 猜数字游戏
void   func2(){
    printf("\n=== 猜数字游戏 ===\n");
    int   secret=rand()%100+1;
    int   guess,attempts=0;
    
    printf("我想了一个1-100的数字，你有10次机会！\n");
    
    while(attempts<10){
        printf("第%d次猜测: ",attempts+1);
        if(scanf("%d",&guess)!=1){
            while(getchar()!='\n');
            printf("请输入数字！\n");
            continue;
        }
        
        attempts++;
        
        if(guess==secret){
            printf("🎉 恭喜你猜对了！用了%d次\n",attempts);
            return;
        }else if(guess<secret){
            printf("猜小了！\n");
        }else{
            printf("猜大了！\n");
        }
        
        int   diff=abs(guess-secret);
        if(diff<=5) printf("提示: 非常接近！\n");
        else if(diff<=10) printf("提示: 比较接近\n");
        else if(diff<=20) printf("提示: 有点远\n");
        else printf("提示: 还差得远呢\n");
    }
    printf("游戏结束！答案是: %d\n",secret);
}

// 数学函数
void   func3(){
    printf("\n=== 数学函数 ===\n");
    printf("1. 阶乘\n");
    printf("2. 斐波那契\n");
    printf("3. 判断质数\n");
    printf("0. 返回\n");
    
    while(1){
        int   choice;
        printf("选择(0-3): ");
        scanf("%d",&choice);
        
        switch(choice){
            case 0: return;
            case 1:{
                int   n;
                printf("输入n: ");
                scanf("%d",&n);
                long   result=1;
                for(int i=2;i<=n;i++) result*=i;
                printf("%d! = %ld\n",n,result);
                break;
            }
            case 2:{
                int   n;
                printf("输入项数: ");
                scanf("%d",&n);
                int   a=0,b=1;
                for(int i=0;i<n;i++){
                    printf("%d ",a);
                    int   temp=a+b;
                    a=b;
                    b=temp;
                }
                printf("\n");
                break;
            }
            case 3:{
                int   n;
                printf("输入整数: ");
                scanf("%d",&n);
                int   is_prime=1;
                if(n<=1) is_prime=0;
                else for(int i=2;i*i<=n;i++){
                    if(n%i==0){is_prime=0;break;}
                }
                printf("%d %s质数\n",n,is_prime?"是":"不是");
                break;
            }
        }
    }
}

// 字符串处理
void   func4(){
    printf("\n=== 字符串处理 ===\n");
    char   str[100];
    
    printf("输入字符串: ");
    scanf("%s",str);
    
    int   len=0;
    while(str[len]) len++;
    printf("长度: %d\n",len);
    
    printf("大写: ");
    for(int i=0;str[i];i++){
        if(str[i]>='a' && str[i]<='z') putchar(str[i]-32);
        else putchar(str[i]);
    }
    printf("\n");
    
    printf("反转: ");
    for(int i=len-1;i>=0;i--) putchar(str[i]);
    printf("\n");
    
    int   is_palindrome=1;
    for(int i=0;i<len/2;i++){
        if(str[i]!=str[len-1-i]){is_palindrome=0;break;}
    }
    printf("是否回文: %s\n",is_palindrome?"是":"否");
}