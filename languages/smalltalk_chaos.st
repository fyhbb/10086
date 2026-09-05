"Smalltalk 混乱代码: 随机密码生成器与字符串分析器"
"风格: 极度混乱，方法名随意，魔数泛滥，注释和代码不匹配"

Object subclass: #ChaosGenerator
    instanceVariableNames: 'x y z counter buffer seed'
    classVariableNames: 'SharedInstance DefaultSize'
    poolDictionaries: ''
    category: 'Chaos-Misc'!

!ChaosGenerator class methodsFor: 'as yet unclassified'!

new
    | temp |
    temp := super new.
    temp init.
    ^temp!

!ChaosGenerator methodsFor: 'as yet unclassified'!

init
    x := 1234.
    y := 5678.
    z := 9012.
    counter := 0.
    buffer := OrderedCollection new.
    seed := Time millisecondClockValue.!

getNext
    | a b |
    a := (x * 1103515245 + 12345) bitAnd: 16r7FFFFFFF.
    b := (a bitShift: -16) bitAnd: 16r7FFF.
    x := a.
    ^b!

randomChar
    | idx chars result |
    chars := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*'.
    idx := (self getNext rem: chars size) abs + 1.
    result := chars at: idx.
    ^result!

generatePassword: length
    | pwd i ch |
    pwd := ''.
    i := 0.
    [i < length] whileTrue: [
        ch := self randomChar.
        pwd := pwd , ch asString.
        i := i + 1.
        counter := counter + 1.
    ].
    ^pwd!

analyzeString: str
    | upper lower digits others total |
    upper := 0.
    lower := 0.
    digits := 0.
    others := 0.
    total := str size.
    str do: [:c |
        (c isUppercase) ifTrue: [upper := upper + 1].
        (c isLowercase) ifTrue: [lower := lower + 1].
        (c isDigit) ifTrue: [digits := digits + 1].
        ((c isUppercase) not and: [(c isLowercase) not and: [(c isDigit) not]])
            ifTrue: [others := others + 1].
    ].
    ^Dictionary new
        at: #total put: total;
        at: #upper put: upper;
        at: #lower put: lower;
        at: #digits put: digits;
        at: #others put: others;
        yourself!

reverseString: str
    | result i |
    result := ''.
    i := str size.
    [i > 0] whileTrue: [
        result := result , (str at: i) asString.
        i := i - 1.
    ].
    ^result!

countWords: str
    | words inWord count |
    words := OrderedCollection new.
    inWord := false.
    count := 0.
    str do: [:c |
        (c = $  or: [c = Character tab]) ifTrue: [
            inWord ifTrue: [
                count := count + 1.
                inWord := false.
            ].
        ] ifFalse: [
            inWord ifTrue: [] ifFalse: [inWord := true].
        ].
    ].
    inWord ifTrue: [count := count + 1].
    ^count!

toUpper: str
    | result |
    result := ''.
    str do: [:c |
        result := result , c asUppercase asString.
    ].
    ^result!

palindromeCheck: str
    | rev |
    rev := self reverseString: str.
    ^str = rev!

!ChaosGenerator methodsFor: 'main'!

run
    | gen pw analysis str1 str2 str3 |
    gen := ChaosGenerator new.
    Transcript show: '=== Smalltalk 混乱密码生成器 ==='; cr.

    pw := gen generatePassword: 16.
    Transcript show: '生成密码: ', pw; cr.

    analysis := gen analyzeString: pw.
    Transcript show: '密码分析:'; cr.
    Transcript show: '  总长度: ', (analysis at: #total) printString; cr.
    Transcript show: '  大写: ', (analysis at: #upper) printString; cr.
    Transcript show: '  小写: ', (analysis at: #lower) printString; cr.
    Transcript show: '  数字: ', (analysis at: #digits) printString; cr.
    Transcript show: '  特殊: ', (analysis at: #others) printString; cr.

    str1 := 'Hello World'.
    str2 := gen reverseString: str1.
    str3 := gen toUpper: str1.
    Transcript show: '反转: ', str1, ' -> ', str2; cr.
    Transcript show: '大写: ', str1, ' -> ', str3; cr.
    Transcript show: '单词数: ', (gen countWords: str1) printString; cr.

    Transcript show: '"madam" 回文检测: ', (gen palindromeCheck: 'madam') printString; cr.
    Transcript show: '"hello" 回文检测: ', (gen palindromeCheck: 'hello') printString; cr.

    "生成5个随机密码"
    Transcript show: '--- 批量密码 ---'; cr.
    5 timesRepeat: [
        Transcript show: gen generatePassword: 12; cr.
    ].

    "无意义的魔数运算"
    Transcript show: '--- 无用计算 ---'; cr.
    Transcript show: '42 * 137 mod 99 = ', (42 * 137 rem: 99) printString; cr.
    Transcript show: '位运算: ', ((16rFF bitXor: 16r0F) printString); cr.

    ^self!

"执行"
ChaosGenerator new run.
!
