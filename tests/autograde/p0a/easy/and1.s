.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $24, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl $1, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -20(%ebp)
 movl $3, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 movl $4, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 movl -8(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 movl -20(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 movl -8(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ebx
 movl -20(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ecx
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif1
 else1:
 movl -20(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif2
 else2:
 movl -8(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ebx
 movl -20(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif2:
 endif1:
 jmp endif0
 else0:
 movl -8(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 movl -20(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 movl -8(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ebx
 movl -20(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif4
 else4:
 movl -20(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif5
 else5:
 movl -8(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ebx
 movl -20(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif5:
 endif4:
 jmp endif3
 else3:
 movl -8(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif6
 then6:
 movl -20(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 movl -8(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ebx
 movl -20(%ebp), %eax
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
 movl %eax, %ebx
 addl $4, %esp
 jmp endif7
 else7:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 endif7:
 jmp endif6
 endif6:
 endif3:
 endif0:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 pushl %ebx
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ecx
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif9
 else9:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif10
 else10:
 pushl %ebx
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ecx
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif10:
 endif9:
 jmp endif8
 else8:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 pushl %ebx
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ecx
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif12
 else12:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif13
 else13:
 pushl %ebx
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif13:
 endif12:
 jmp endif11
 else11:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif14
 then14:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else15
 then15:
 pushl %ebx
 call project_big
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
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
 jmp endif15
 else15:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif15:
 jmp endif14
 endif14:
 endif11:
 endif8:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else16
 then16:
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif17
 else17:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif18
 else18:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif18:
 endif17:
 jmp endif16
 else16:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else20
 then20:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %eax, %ecx
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif20
 else20:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else21
 then21:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif21
 else21:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif21:
 endif20:
 jmp endif19
 else19:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif22
 then22:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else23
 then23:
 pushl %edi
 call project_big
 movl %eax, %edi
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
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
 movl %eax, %esi
 addl $4, %esp
 jmp endif23
 else23:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 endif23:
 jmp endif22
 endif22:
 endif19:
 endif16:
 movl -8(%ebp), %eax
 pushl %eax
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else24
 then24:
 movl $0, %eax
 jmp endif24
 else24:
 movl $1, %eax
 endif24:
 cmpl $0, %eax
 je else25
 then25:
 movl -8(%ebp), %ebx
 jmp endif25
 else25:
 movl -20(%ebp), %ebx
 endif25:
 movl -12(%ebp), %eax
 pushl %eax
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else26
 then26:
 movl $0, %eax
 jmp endif26
 else26:
 movl $1, %eax
 endif26:
 cmpl $0, %eax
 je else27
 then27:
 movl -12(%ebp), %edi
 jmp endif27
 else27:
 movl -4(%ebp), %edi
 endif27:
 pushl %ebx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else28
 then28:
 movl $0, %eax
 jmp endif28
 else28:
 movl $1, %eax
 endif28:
 cmpl $0, %eax
 je else29
 then29:
 movl %ebx, %eax
 jmp endif29
 else29:
 movl %edi, %eax
 endif29:
 pushl %eax
 call print_any
 addl $4, %esp
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else30
 then30:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else31
 then31:
 pushl %esi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -16(%ebp)
 jmp endif31
 else31:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else32
 then32:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -16(%ebp)
 jmp endif32
 else32:
 pushl %esi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -16(%ebp)
 endif32:
 endif31:
 jmp endif30
 else30:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else33
 then33:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else34
 then34:
 pushl %esi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
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
 movl %eax, -16(%ebp)
 jmp endif34
 else34:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else35
 then35:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -16(%ebp)
 jmp endif35
 else35:
 pushl %esi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
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
 movl %eax, -16(%ebp)
 endif35:
 endif34:
 jmp endif33
 else33:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif36
 then36:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else37
 then37:
 pushl %esi
 call project_big
 movl %eax, %edi
 addl $4, %esp
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
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -16(%ebp)
 jmp endif37
 else37:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -16(%ebp)
 endif37:
 jmp endif36
 endif36:
 endif33:
 endif30:
 movl -16(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else38
 then38:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else39
 then39:
 movl -16(%ebp), %eax
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
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -24(%ebp)
 jmp endif39
 else39:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else40
 then40:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -24(%ebp)
 jmp endif40
 else40:
 movl -16(%ebp), %eax
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
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -24(%ebp)
 endif40:
 endif39:
 jmp endif38
 else38:
 movl -16(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else41
 then41:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else42
 then42:
 movl -16(%ebp), %eax
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -24(%ebp)
 jmp endif42
 else42:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else43
 then43:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -24(%ebp)
 jmp endif43
 else43:
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
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
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -24(%ebp)
 endif43:
 endif42:
 jmp endif41
 else41:
 movl -16(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif44
 then44:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else45
 then45:
 movl -16(%ebp), %eax
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
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -24(%ebp)
 jmp endif45
 else45:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -24(%ebp)
 endif45:
 jmp endif44
 endif44:
 endif41:
 endif38:
 movl -24(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else46
 then46:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else47
 then47:
 movl -24(%ebp), %eax
 pushl %eax
 call project_int
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
 movl %eax, %esi
 addl $4, %esp
 jmp endif47
 else47:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else48
 then48:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif48
 else48:
 movl -24(%ebp), %eax
 pushl %eax
 call project_int
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
 movl %eax, %esi
 addl $4, %esp
 endif48:
 endif47:
 jmp endif46
 else46:
 movl -24(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else49
 then49:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else50
 then50:
 movl -24(%ebp), %eax
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
 movl %eax, %esi
 addl $4, %esp
 jmp endif50
 else50:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else51
 then51:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif51
 else51:
 movl -24(%ebp), %eax
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
 movl %eax, %esi
 addl $4, %esp
 endif51:
 endif50:
 jmp endif49
 else49:
 movl -24(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif52
 then52:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else53
 then53:
 movl -24(%ebp), %eax
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
 movl %eax, %ecx
 addl $8, %esp
 pushl %ecx
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 jmp endif53
 else53:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 endif53:
 jmp endif52
 endif52:
 endif49:
 endif46:
 pushl %esi
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else54
 then54:
 movl $0, %eax
 jmp endif54
 else54:
 movl $1, %eax
 endif54:
 cmpl $0, %eax
 je else55
 then55:
 movl %esi, %eax
 jmp endif55
 else55:
 movl %esi, %eax
 endif55:
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
