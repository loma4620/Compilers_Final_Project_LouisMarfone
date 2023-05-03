.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $12, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl $12, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 while0:
 movl -12(%ebp), %edi
 pushl $0
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
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
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
 call inject_int
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
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
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
 je endif4
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
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
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
 call inject_int
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
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif6:
 endif5:
 jmp endif4
 endif4:
 endif1:
 cmpl $0, %esi
 je end0
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif7
 else7:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif8
 else8:
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif8:
 endif7:
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 movl -12(%ebp), %eax
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
 movl %eax, -12(%ebp)
 jmp endif10
 else10:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif11
 else11:
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
 movl %eax, -12(%ebp)
 endif11:
 endif10:
 jmp endif9
 else9:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
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
 movl %eax, -12(%ebp)
 jmp endif13
 else13:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else14
 then14:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif14
 else14:
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
 movl %eax, -12(%ebp)
 endif14:
 endif13:
 jmp endif12
 else12:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif15
 then15:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else16
 then16:
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
 movl %eax, -12(%ebp)
 jmp endif16
 else16:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 endif16:
 jmp endif15
 endif15:
 endif12:
 endif9:
 pushl $1
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl -8(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 movl -8(%ebp), %eax
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
 movl %eax, -8(%ebp)
 jmp endif18
 else18:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 jmp endif19
 else19:
 movl -8(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 movl %eax, -8(%ebp)
 endif19:
 endif18:
 jmp endif17
 else17:
 movl -8(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else20
 then20:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else21
 then21:
 movl -8(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %edi
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
 movl %eax, -8(%ebp)
 jmp endif21
 else21:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else22
 then22:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 jmp endif22
 else22:
 movl -8(%ebp), %eax
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
 endif22:
 endif21:
 jmp endif20
 else20:
 movl -8(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif23
 then23:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else24
 then24:
 movl -8(%ebp), %eax
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
 jmp endif24
 else24:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 endif24:
 jmp endif23
 endif23:
 endif20:
 endif17:
 jmp while0
 end0:
 movl -8(%ebp), %edi
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else25
 then25:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else26
 then26:
 pushl %edi
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif26
 else26:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else27
 then27:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif27
 else27:
 pushl %edi
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif27:
 endif26:
 jmp endif25
 else25:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif28
 then28:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else29
 then29:
 pushl %edi
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif29
 else29:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else30
 then30:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 jmp endif30
 else30:
 pushl %edi
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 endif30:
 endif29:
 jmp endif28
 endif28:
 endif25:
 movl -4(%ebp), %eax
 pushl %eax
 call is_true
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ecx
 cmpl $0, %ecx
 je else31
 then31:
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 jmp endif31
 else31:
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 endif31:
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
