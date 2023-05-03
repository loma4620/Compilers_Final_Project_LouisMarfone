.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $12, %esp
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
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
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
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif1
 else1:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif2
 else2:
 pushl %esi
 call project_int
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
 movl %eax, %edi
 addl $4, %esp
 endif2:
 endif1:
 jmp endif0
 else0:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl %esi
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
 movl %eax, %edi
 addl $4, %esp
 jmp endif4
 else4:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif5
 else5:
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
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif5:
 endif4:
 jmp endif3
 else3:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif6
 then6:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
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
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif7:
 jmp endif6
 endif6:
 endif3:
 endif0:
 pushl $3
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
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
 jmp endif9
 else9:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif10
 else10:
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
 endif10:
 endif9:
 jmp endif8
 else8:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 pushl %edi
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
 movl %eax, -12(%ebp)
 jmp endif12
 else12:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif13
 else13:
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 endif13:
 endif12:
 jmp endif11
 else11:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif14
 then14:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else15
 then15:
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
 jmp endif15
 else15:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 endif15:
 jmp endif14
 endif14:
 endif11:
 endif8:
 pushl $4
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else16
 then16:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 jmp endif17
 else17:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif18
 else18:
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 movl %eax, -4(%ebp)
 endif18:
 endif17:
 jmp endif16
 else16:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else20
 then20:
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 movl %eax, -4(%ebp)
 jmp endif20
 else20:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else21
 then21:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif21
 else21:
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 endif21:
 endif20:
 jmp endif19
 else19:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif22
 then22:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else23
 then23:
 movl -12(%ebp), %eax
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
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif23
 else23:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif23:
 jmp endif22
 endif22:
 endif19:
 endif16:
 pushl $5
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else24
 then24:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else25
 then25:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 movl %eax, -8(%ebp)
 jmp endif25
 else25:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else26
 then26:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 jmp endif26
 else26:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 movl %eax, -8(%ebp)
 endif26:
 endif25:
 jmp endif24
 else24:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else27
 then27:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else28
 then28:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 movl %eax, -8(%ebp)
 jmp endif28
 else28:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else29
 then29:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 jmp endif29
 else29:
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
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 endif29:
 endif28:
 jmp endif27
 else27:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif30
 then30:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else31
 then31:
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
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 jmp endif31
 else31:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 endif31:
 jmp endif30
 endif30:
 endif27:
 endif24:
 movl -8(%ebp), %eax
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
