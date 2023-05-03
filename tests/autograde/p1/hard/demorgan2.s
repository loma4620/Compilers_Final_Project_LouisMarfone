.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $4, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $0
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 pushl $1
 call inject_bool
 movl %eax, %esi
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
 movl %ebx, %edi
 jmp endif1
 else1:
 movl %esi, %edi
 endif1:
 pushl %ebx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl $0
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 jmp endif2
 else2:
 pushl $1
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 endif2:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif4
 else4:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif5
 else5:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif5:
 endif4:
 jmp endif3
 else3:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else6
 then6:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_bool
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
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif8
 else8:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif8:
 endif7:
 jmp endif6
 else6:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif9
 then9:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 pushl %edi
 call project_big
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call equal
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif10
 else10:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif11
 else11:
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif11:
 endif10:
 jmp endif9
 endif9:
 endif6:
 endif3:
 movl -4(%ebp), %eax
 pushl %eax
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 pushl $0
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 jmp endif12
 else12:
 pushl $1
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 endif12:
 pushl %esi
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif13
 else13:
 pushl $1
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif13:
 pushl %ebx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else14
 then14:
 movl %ebx, %eax
 jmp endif14
 else14:
 movl %edi, %eax
 endif14:
 pushl %eax
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
