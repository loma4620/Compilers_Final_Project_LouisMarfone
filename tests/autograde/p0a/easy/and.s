.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 pushl $2
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl $3
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 movl $0, %eax
 jmp endif0
 else0:
 movl $1, %eax
 endif0:
 cmpl $0, %eax
 je else1
 then1:
 movl %ebx, %eax
 jmp endif1
 else1:
 movl %edi, %eax
 endif1:
 pushl %eax
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
