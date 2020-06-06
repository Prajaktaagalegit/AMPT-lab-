; A program for Matrix Transpose...


%define D1    esp+20
%define S1     esp+24
%define no_rows esp+28
%define no_cols esp+32


[BITS 32]
global Matrix_Transpose

section .text

; There are 2 matrix S1 i.e Source matrix and D1 i.e Destination matrix
Matrix_Transpose: equ $
push ebp
   push ebx
   push esi
   push edi
   mov  ebp , dword[no_rows]
   mov  ebx , dword[S1]         
   mov  edx , dword[D1]        
   mov  eax , dword[no_rows]
   lea  ebp , [8*ebp]


next_row: equ $
   dec  eax
   jnge  return
   mov  edi , edx                                        
   mov  esi , ebx                                          
   xor  ecx , ecx              
   sub  edi , ebp


next_col: equ $             
   cmp  ecx , dword[no_cols]
   jge 	set_row
   fld qword[esi]         
   lea  edi , [edi+ebp]
   inc  ecx
   fstp qword[edi]         
   add  esi , 8
   jmp  next_col


set_row equ $
   add  edx , 8
   lea  ebx , [ebx+8*ecx]
   jmp  next_row


; Restoring the register 
return: equ $                
   pop edi                  
   pop esi
   pop ebx                                                         
   pop ebp                   
   ret     
                  
 section .data
 section .bss




