include emu8086.INC

MYDATA SEGMENT
    
    
    A db 0dh,0ah, " 1. Sign Up $";
    B db 0dh,0ah, " 2. Log In $";
    C db 0dh,0ah, " 3. Exit$";
    D db 0dh,0ah, " Enter your choice: $"
    E db 0dh,0ah, " Enter your Phone Number:    $";   
    F db 0dh,0ah, " Enter Password (10 Digits): $";
    G db 0dh,0ah, " Sign Up Successful$";
    H db 0dh,0ah, " Sorry this phone number is already taken...try to Log In$"
    I db 0dh,0ah, " Logged In$"
    J db 0dh,0ah, " PhoneNumber or Password doesn't match with our data...try again!$"
    K db 0dh,0ah, "Invalid Input$"; 
    L db 0dh,0ah, " ***************************************$";
    M db 0dh,0ah, "      SIGN UP$";
    N db 0dh,0ah, "      LOG IN$";
    O db 0dh,0ah, "      EXITING$";
    P db 0dh,0ah, "   PLEASE ENTER A VALID PHONE NUMBER    $"  
    Q db 0dh,0ah, "    WELCOME TO WRONGN $" 
    R db 0dh,0ah, "1. VIEW YOUR PROFILE $"      
    S db 0dh,0ah, "2. VIEW COMPLAINTS $" 
    T db 0dh,0ah, "3. VIEW PENDING ORDERS $"
    U db 0dh,0ah, "4. LOGOUT $"
    V db 0dh,0ah, "SUCCESSFULLY LOGGED OUT $"   
    Z db 0dh,0ah,"$";
    
    
MYDATA ENDS             


 
 
MYCODE SEGMENT
START:
; set segment registers:
    MOV AX, MYDATA
    MOV DS, AX
    

    ; ADD your code here
    MOV CX, -1;
    MOV DI,0000h;
    
        
    Back_to_beginning:
    
        MOV BX,1000h;
        
        LEA DX,Z;
        MOV AH,9;
        INT 21h;
        
              
        LEA DX, A
        MOV AH, 9
        INT 21h          ; Sign Up is printed
                                    
        LEA DX, B        ; Log In is printed
        MOV AH, 9
        INT 21h  
        
        LEA DX, C        ; Exit is printed
        MOV AH, 9
        INT 21h  
        
        LEA DX, D;       ;Enter your choice 
        MOV AH,9;
        INT 21h;
        
        MOV AH, 1      ; Taking choice as input
        INT 21h
                     
        CMP AL,'1';
        JE SignUp;
        
        CMP AL,'2';
        JE Log_IN;
        
        CMP AL,'3';
        JE EXIT;
        
        LEA DX,K        ; Invalid Input
        MOV AH, 9       
        INT 21h
        
        LOOP Back_to_beginning;
    
    
       
       
    SignUP:  
    
        CALL CLEAR
        
        LEA DX, M;       ;Sign up
        MOV AH,9;
        INT 21h; 
        
        LEA DX, L;       ;****************
        MOV AH,9;
        INT 21h;
         
        LEA DX, E;       ;Enter your Phone Number
        MOV AH,9;
        INT 21h;  
         
        MOV BX,1000h;
        MOV CX,10;
               
              
               
    Taking_Ph_number:
    
        MOV AH, 1      ; Taking input
        INT 21h 
        
        CMP AL,30H
        JL  Error
        
        CMP AL,39H
        JG Error
        
        MOV [BX],AL;
        INC BX;    
        
        LOOP Taking_Ph_number;
        
        MOV CX,DI; 
         
        CMP DI,0000h;
        JE INSERT;   
        
        MOV DX,0000h;
        MOV BX,1000h;     
        MOV DI,0000h; 
    
             
             
    Validating_SignUp:
        MOV AX,[BX];   
        SCASW
        JE increment_BX
        
        MOV BX,1000h;
        MOV DX,0000h;
        
             
             
    continue_with_validation:
         CMP DX,5;
         JE Cannot_SignUp;
        
         CMP DI,CX;
         JE INSERT;
        
         Jmp Validating_SignUp    
           
           
        
    increment_BX:  
    
         ADD BX,0002h;
         INC DX;
         jmp continue_with_validation;
        
         
         
    Cannot_SignUp:     
         
        LEA DX, L;       ;****************
        MOV AH,9;
        INT 21h;
    
        LEA DX, H    ; This phone number is already taken...try Log In
        MOV AH, 9
        INT 21h; 
       
        LEA DX, L;       ;****************
        MOV AH,9;
        INT 21h;
    
        MOV DI,CX;
        JMP Back_to_beginning; 
         
         
         
    INSERT:
    
         MOV DI,CX;
         
         MOV CX,5;
         MOV BX,1000h;
         
    Inserting:
         
          MOV AX,[BX];
          MOV ES:[DI],AX;
          
          ADD BX,0002h;
          ADD DI,0002h;
         
          LOOP Inserting;
         
         
          LEA DX, F;       ;Enter your Password
          MOV AH,9;
          INT 21h;
        
          MOV CX,10;
    
    Taking_Password:
    
    
          MOV AH, 1      ; Taking Input
          INT 21h;
          MOV ES:[DI],AL;
          INC DI;
    
          LOOP Taking_password;
    
          LEA DX, L;       ;****************
          MOV AH,9;
          INT 21h;
    
          LEA DX, G;       ;Signed Up
          MOV AH,9;
          INT 21h;
    
          LEA DX, L;       ;****************
          MOV AH,9;
          INT 21h;
    
          MOV CX,-1;
    
          JMP Back_to_beginning;
    
    
    
    
    Log_IN:
    
          CALL CLEAR  
    
          LEA DX, N;       ;Sign up
          MOV AH,9;
          INT 21h; 
        
          LEA DX, L;       ;****************
          MOV AH,9;
          INT 21h;
           
          LEA DX, E;       ;Enter your Phone Number
          MOV AH,9;
          INT 21h;  
        
          MOV BX,1000h;
          MOV CX,10;
              
              
              
    Taking_Ph_no:
    
          MOV AH, 1      ; Taking input
          INT 21h 
             
          CMP AL,30H
          JL  Error1
        
          CMP AL,39H
          JG Error1
        
          MOV [BX],AL;
          INC BX;
        
          LOOP Taking_Ph_no;
        
          LEA DX,F;       ;Enter your Password
          MOV AH,9;
          INT 21h;
        
          MOV CX,10;
          
          
          
    Taking_Pass:
    
        MOV AH,1      ; Taking Input
        INT 21h
        MOV [BX],AL;
        INC BX;
        
        LOOP Taking_pass;
        
        MOV CX,DI; 
        MOV DX,0000h;
        MOV BX,1000h;     
        MOV DI,0000h;
        
        CMP DI,CX;
        JE WrongInfo  
        
        
        
    Validating_LogIn: 
    
        MOV AX,[BX];   
        SCASW
        JE increment_BX_
        
        MOV BX,1000h;
        MOV DX,0000h;
        
           
           
    continue_with_validation_dude:
         CMP DX,10;
         JE Loged_In
        
         CMP DI,CX;
         JE WrongInfo
        
         Jmp Validating_LogIn    
        
             
             
    increment_BX_:
            ADD BX,0002h;
            INC DX;
            jmp continue_with_validation_dude;
    
    
    
    
     WrongInfo: 
     
            LEA DX, L;       ;****************
            MOV AH,9;
            INT 21h; 
            
            LEA DX, J;       ;Phone Number or Password doesn't match with our data...try again!
            MOV AH,9;
            INT 21h;
            
            LEA DX, L;       ;****************
            MOV AH,9;
            INT 21h;
            
            MOV DI,CX;
            MOV CX,-1;
            JMP Back_to_beginning     
            
            
            
     Loged_In: 
     
            MOV DI,CX;
            MOV CX,-1; 
     
            LEA DX, L;       ;****************
            MOV AH,9;
            INT 21h;   
            
            LEA DX, I;       ;Logged In
            MOV AH,9;
            INT 21h;
            
            LEA DX, L;       ;****************
            MOV AH,9;
            INT 21h; 
            
            call clear;
            
            LEA DX, Q;       ;Welcome
            MOV AH,9;
            INT 21h; 
            
            LEA DX, L;       ;****************
            MOV AH,9;
            INT 21h;
            
            
            LEA DX, R;       ;Profile
            MOV AH,9;
            INT 21h;
            
            LEA DX, S;       ;Complaints
            MOV AH,9;
            INT 21h;
            
            LEA DX, T;       ;Orders
            MOV AH,9;
            INT 21h;
            
            LEA DX, U;       ;Logout
            MOV AH,9;
            INT 21h; 
            
            LEA DX, D;       ;Choice
            MOV AH,9;
            INT 21h;
            
            MOV AH, 1      ; Taking input
            INT 21h    
            CMP AL,'4'
            JE Log_out;
            
    
    
     EXIT:    
            CALL clear
        
            LEA DX,o;         ;EXIT
            MOV AH,9;
            INT 21h; 
                
            LEA DX, L;        ;****************
            MOV AH,9;
            INT 21h;
            hlt; 
                     
      
      
      Error:
           LEA DX, P
           MOV AH, 9
           INT 21h   
           
           MOV CX,100H 
           DELAY:
           LOOP DELAY
           JMP SIGNUP; 
        
     
     
     Error1:
           LEA DX, P
           MOV AH, 9
           INT 21h
        
           JMP LOG_IN;  
        
     
     
     Log_out:
          call clear 
         
          LEA DX, V;       ;Logout 
          MOV AH,9;
          INT 21h; 
        
          LEA DX, Z;       
          MOV AH,9;
          INT 21h; 
        
          JMP Back_to_beginning;
        
           
           
     clear:
          MOV AH, 06h       ;06 to Scroll
          MOV AL, 00h       ;00 for full screen
          MOV BH, 0Fh       ;
          MOV CX, 0         ;Clear Screen
          MOV DH, 100       ;
          MOV DL, 130       ;
          INT 10h           ;
        
          MOV DX, 0         ;
          MOV BH, 0         ; Set cursor to (0,0)
          MOV AH, 02h       ; 
          INT 10h     
           
          RET                       ; Return back to where it was CALLed    ;
          
          
ends

end start                 ; set entry point and stop the assembler.
