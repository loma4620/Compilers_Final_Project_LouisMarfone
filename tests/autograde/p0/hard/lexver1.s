.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $12, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl $23, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 pushl $6
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif0
 else0:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif1
 else1:
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif1:
 endif0:
 pushl $12
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl -8(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 movl -8(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif3
 else3:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif4
 else4:
 movl -8(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %esi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif4:
 endif3:
 jmp endif2
 else2:
 movl -8(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else6
 then6:
 movl -8(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif6
 else6:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 movl -8(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %esi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif7:
 endif6:
 jmp endif5
 else5:
 movl -8(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif8
 then8:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 movl -8(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
 pushl %esi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 jmp endif9
 else9:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif9:
 jmp endif8
 endif8:
 endif5:
 endif2:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif11
 else11:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif12
 else12:
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 endif12:
 endif11:
 jmp endif10
 else10:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else14
 then14:
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
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif14
 else14:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else15
 then15:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif15
 else15:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 endif15:
 endif14:
 jmp endif13
 else13:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif16
 then16:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
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
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif17
 else17:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 endif17:
 jmp endif16
 endif16:
 endif13:
 endif10:
 movl -12(%ebp), %eax
 pushl %eax
 call print_any
 addl $4, %esp
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 pushl %esi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif19
 else19:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else20
 then20:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif20
 else20:
 pushl %esi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif20:
 endif19:
 jmp endif18
 else18:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else21
 then21:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else22
 then22:
 pushl %esi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif22
 else22:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else23
 then23:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif23
 else23:
 pushl %esi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif23:
 endif22:
 jmp endif21
 else21:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif24
 then24:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else25
 then25:
 pushl %esi
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
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif25
 else25:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif25:
 jmp endif24
 endif24:
 endif21:
 endif18:
 movl -4(%ebp), %eax
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
