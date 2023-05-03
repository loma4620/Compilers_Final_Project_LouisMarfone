.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $4, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $10
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 while0:
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl %esi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif2
 else2:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif3
 else3:
 pushl %esi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif3:
 endif2:
 jmp endif1
 else1:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif4
 then4:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl %esi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif5
 else5:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else6
 then6:
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif6
 else6:
 pushl %esi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif6:
 endif5:
 jmp endif4
 endif4:
 endif1:
 cmpl $0, %edi
 je end0
 pushl $1
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif7
 else7:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif8
 else8:
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif8:
 endif7:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 pushl %esi
 call project_int
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif10
 else10:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif11
 else11:
 pushl %esi
 call project_int
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ecx
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif11:
 endif10:
 jmp endif9
 else9:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 pushl %esi
 call project_bool
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif13
 else13:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else14
 then14:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif14
 else14:
 pushl %esi
 call project_bool
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ecx
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif14:
 endif13:
 jmp endif12
 else12:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif15
 then15:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else16
 then16:
 pushl %esi
 call project_big
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 jmp endif16
 else16:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 endif16:
 jmp endif15
 endif15:
 endif12:
 endif9:
 jmp while0
 end0:
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
