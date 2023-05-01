.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 while0:
 pushl %eax
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 jmp endif1
 else1:
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 endif1:
 cmpl $0, %eax
 je end0
 call eval_input_pyobj
 jmp while0
 end0:
 movl $0, %eax 
 movl %ebp, %esp
 popl %ebp
 ret
