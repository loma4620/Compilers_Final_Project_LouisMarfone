.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif0
 else0:
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif0:
 pushl $1
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
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
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
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
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif3
 else3:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif3:
 endif2:
 jmp endif1
 else1:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
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
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif6
 else6:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif6:
 endif5:
 jmp endif4
 else4:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif7
 then7:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
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
 call add
 movl %eax, %edx
 addl $8, %esp
 pushl %edx
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 jmp endif8
 else8:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 endif8:
 jmp endif7
 endif7:
 endif4:
 endif1:
 pushl %esi
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
