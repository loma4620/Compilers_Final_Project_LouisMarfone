.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $4, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $1
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 pushl $0
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
 movl %ebx, -4(%ebp)
 jmp endif0
 else0:
 movl %esi, -4(%ebp)
 endif0:
 pushl %ebx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 pushl $0
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 jmp endif1
 else1:
 pushl $1
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 endif1:
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif3
 else3:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif4
 else4:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif4:
 endif3:
 jmp endif2
 else2:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else6
 then6:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif6
 else6:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif7:
 endif6:
 jmp endif5
 else5:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif8
 then8:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 movl -4(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 movl %eax, %edi
 addl $4, %esp
 jmp endif9
 else9:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif10
 else10:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif10:
 endif9:
 jmp endif8
 endif8:
 endif5:
 endif2:
 pushl %edi
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 pushl $0
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 jmp endif11
 else11:
 pushl $1
 call inject_bool
 movl %eax, %ebx
 addl $4, %esp
 endif11:
 pushl %esi
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif12
 else12:
 pushl $1
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif12:
 pushl %ebx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 movl $0, %eax
 jmp endif13
 else13:
 movl $1, %eax
 endif13:
 cmpl $0, %eax
 je else14
 then14:
 movl %ebx, %edi
 jmp endif14
 else14:
 endif14:
 pushl %edi
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
