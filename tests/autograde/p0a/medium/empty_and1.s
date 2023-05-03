.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $4, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $1
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %esi
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
 movl %esi, -4(%ebp)
 jmp endif1
 else1:
 movl %ebx, -4(%ebp)
 endif1:
 pushl $3
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 pushl $5
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %esi
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 movl $0, %eax
 jmp endif2
 else2:
 movl $1, %eax
 endif2:
 cmpl $0, %eax
 je else3
 then3:
 movl %esi, %ebx
 jmp endif3
 else3:
 endif3:
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
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
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif6:
 endif5:
 jmp endif4
 else4:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif7
 then7:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
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
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif8
 else8:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif9
 else9:
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
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif9:
 endif8:
 jmp endif7
 endif7:
 endif4:
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
