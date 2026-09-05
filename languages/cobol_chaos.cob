       IDENTIFICATION DIVISION.
       PROGRAM-ID. CHAOS-COBOL.
       AUTHOR. "definitely-not-mad".
       DATE-WRITTEN. whenever.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-NUM1           PIC S9(8) COMP VALUE 0.
       01  WS-NUM2           PIC S9(8) COMP VALUE 0.
       01  WS-RESULT         PIC S9(8) COMP VALUE 0.
       01  WS-CHOICE         PIC 9 VALUE 0.
       01  WS-LOOP           PIC 9 VALUE 1.
       01  WS-TEMP           PIC S9(8) COMP VALUE 0.
       01  WS-REM            PIC S9(8) COMP VALUE 0.
       01  WS-ANSWER         PIC A(20) VALUE SPACES.
       01  WS-FACTORIAL-N    PIC 9(4) COMP VALUE 0.
       01  WS-FACTORIAL-RES  PIC 9(10) COMP VALUE 1.
       01  WS-FIZZ-CTR       PIC 9(3) COMP VALUE 1.
       01  WS-NAME           PIC A(20) VALUE SPACES.
       01  WS-COUNTER        PIC 9(3) COMP VALUE 0.
       01  WS-RANDOM-SEED   PIC 9(4) COMP VALUE 42.
       01  WS-GUESS          PIC 9(3) COMP VALUE 0.
       01  WS-TARGET         PIC 9(3) COMP VALUE 0.
       01  WS-TRIES          PIC 9(2) COMP VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PARA.
           DISPLAY "==============================".
           DISPLAY "   CHAOS COBOL v0.1 (help)   ".
           DISPLAY "==============================".
           PERFORM UNTIL WS-LOOP = 0
               DISPLAY " "
               DISPLAY "1) Add      2) Subtract"
               DISPLAY "3) Multiply 4) Divide"
               DISPLAY "5) Modulo   6) Factorial"
               DISPLAY "7) FizzBuzz 8) Guess Game"
               DISPLAY "9) Name Echo  0) Quit"
               DISPLAY "Your choice (0-9): "
               ACCEPT WS-CHOICE

               EVALUATE WS-CHOICE
                   WHEN 1
                       PERFORM DO-ADD
                   WHEN 2
                       PERFORM DO-SUB
                   WHEN 3
                       PERFORM DO-MUL
                   WHEN 4
                       PERFORM DO-DIV
                   WHEN 5
                       PERFORM DO-MOD
                   WHEN 6
                       PERFORM DO-FACTORIAL
                   WHEN 7
                       PERFORM DO-FIZZBUZZ
                   WHEN 8
                       PERFORM DO-GUESS
                   WHEN 9
                       PERFORM DO-ECHO
                   WHEN 0
                       MOVE 0 TO WS-LOOP
                       DISPLAY "Goodbye! (you survived cobol)"
                   WHEN OTHER
                       DISPLAY "That's not even a real option."
               END-EVALUATE
           END-PERFORM.
           STOP RUN.

       DO-ADD.
           DISPLAY "First number: " WITH NO ADVANCING.
           ACCEPT WS-NUM1.
           DISPLAY "Second number: " WITH NO ADVANCING.
           ACCEPT WS-NUM2.
           ADD WS-NUM1 TO WS-NUM2 GIVING WS-RESULT.
           DISPLAY "Result: " WS-RESULT.

       DO-SUB.
           DISPLAY "First number: " WITH NO ADVANCING.
           ACCEPT WS-NUM1.
           DISPLAY "Second number: " WITH NO ADVANCING.
           ACCEPT WS-NUM2.
           SUBTRACT WS-NUM2 FROM WS-NUM1 GIVING WS-RESULT.
           DISPLAY "Result: " WS-RESULT.

       DO-MUL.
           DISPLAY "First number: " WITH NO ADVANCING.
           ACCEPT WS-NUM1.
           DISPLAY "Second number: " WITH NO ADVANCING.
           ACCEPT WS-NUM2.
           MULTIPLY WS-NUM1 BY WS-NUM2 GIVING WS-RESULT.
           DISPLAY "Result: " WS-RESULT.

       DO-DIV.
           DISPLAY "First number: " WITH NO ADVANCING.
           ACCEPT WS-NUM1.
           DISPLAY "Second number: " WITH NO ADVANCING.
           ACCEPT WS-NUM2.
           IF WS-NUM2 = 0 THEN
               DISPLAY "ERROR: Cannot divide by zero!!"
               DISPLAY "(I know you tried it, don't lie)"
           ELSE
               DIVIDE WS-NUM1 BY WS-NUM2
                   GIVING WS-RESULT
                   REMAINDER WS-REM
               DISPLAY "Result: " WS-RESULT " remainder " WS-REM
           END-IF.

       DO-MOD.
           DISPLAY "First number: " WITH NO ADVANCING.
           ACCEPT WS-NUM1.
           DISPLAY "Second number: " WITH NO ADVANCING.
           ACCEPT WS-NUM2.
           IF WS-NUM2 = 0 THEN
               DISPLAY "Mod by zero? Really?"
           ELSE
               DIVIDE WS-NUM1 BY WS-NUM2
                   GIVING WS-TEMP
                   REMAINDER WS-REM
               DISPLAY "Modulo: " WS-REM
           END-IF.

       DO-FACTORIAL.
           DISPLAY "Factorial of what? (1-20): " WITH NO ADVANCING.
           ACCEPT WS-FACTORIAL-N.
           MOVE 1 TO WS-FACTORIAL-RES.
           PERFORM VARYING WS-COUNTER FROM 1 BY 1
               UNTIL WS-COUNTER > WS-FACTORIAL-N
               MULTIPLY WS-FACTORIAL-RES BY WS-COUNTER
                   GIVING WS-FACTORIAL-RES
           END-PERFORM.
           DISPLAY WS-FACTORIAL-N "! = " WS-FACTORIAL-RES.

       DO-FIZZBUZZ.
           DISPLAY "FizzBuzz 1-100 (because why not in COBOL):"
           MOVE 1 TO WS-FIZZ-CTR.
           PERFORM VARYING WS-FIZZ-CTR FROM 1 BY 1
               UNTIL WS-FIZZ-CTR > 100
               IF FUNCTION MOD(WS-FIZZ-CTR, 15) = 0 THEN
                   DISPLAY "FizzBuzz" WITH NO ADVANCING " "
               ELSE IF FUNCTION MOD(WS-FIZZ-CTR, 3) = 0 THEN
                   DISPLAY "Fizz" WITH NO ADVANCING " "
               ELSE IF FUNCTION MOD(WS-FIZZ-CTR, 5) = 0 THEN
                   DISPLAY "Buzz" WITH NO ADVANCING " "
               ELSE
                   DISPLAY WS-FIZZ-CTR WITH NO ADVANCING " "
               END-IF
           END-PERFORM.
           DISPLAY " ".

       DO-GUESS.
           COMPUTE WS-TARGET = FUNCTION MOD(
               FUNCTION RANDOM() * 100, 100) + 1.
           MOVE 0 TO WS-TRIES.
           DISPLAY "Guess a number (1-100)! I picked one."
           PERFORM UNTIL WS-GUESS = WS-TARGET
               DISPLAY "Your guess: " WITH NO ADVANCING.
               ACCEPT WS-GUESS.
               ADD 1 TO WS-TRIES.
               IF WS-GUESS < WS-TARGET THEN
                   DISPLAY "Too low!"
               ELSE IF WS-GUESS > WS-TARGET THEN
                   DISPLAY "Too high!"
               ELSE
                   DISPLAY "YOU GOT IT in " WS-TRIES " tries!"
               END-IF
           END-PERFORM.

       DO-ECHO.
           DISPLAY "Enter your name: " WITH NO ADVANCING.
           ACCEPT WS-NAME.
           DISPLAY "Hello, " WS-NAME "!".
           DISPLAY "Did you know COBOL runs 95% of ATMs?"
           DISPLAY "You're welcome for your cash."
