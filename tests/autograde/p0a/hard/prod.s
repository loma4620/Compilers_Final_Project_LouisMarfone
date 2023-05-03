.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $76, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl $1, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 while0:
 movl -28(%ebp), %esi
 movl $10, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -36(%ebp)
 movl %esi, %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -40(%ebp)
 movl -40(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else1
 then1:
 movl -36(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 movl -32(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else2
 then2:
 movl %esi, %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 movl -36(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -56(%ebp), %ecx
 movl %edi, %eax
 movl -68(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -56(%ebp)
 movl -56(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif2
 else2:
 movl -36(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 movl -52(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else3
 then3:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif3
 else3:
 pushl %esi
 call project_int
 movl %eax, %esi
 addl $4, %esp
 movl -36(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -64(%ebp)
 movl -20(%ebp), %ecx
 movl -64(%ebp), %eax
 movl %esi, %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -20(%ebp)
 movl -20(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 endif3:
 endif2:
 jmp endif1
 else1:
 pushl %esi
 call is_bool
 movl %eax, %edi
 addl $4, %esp
 cmpl $0, %edi
 je endif4
 then4:
 movl -36(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 movl -4(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else5
 then5:
 movl %esi, %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -60(%ebp)
 movl -36(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -8(%ebp), %ecx
 movl %edi, %eax
 movl -60(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -8(%ebp)
 movl -8(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif5
 else5:
 movl -36(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -44(%ebp)
 movl -44(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else6
 then6:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif6
 else6:
 pushl %esi
 call project_bool
 movl %eax, %esi
 addl $4, %esp
 movl -36(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 cmpl %esi, %ebx
 setne %al 
 movzbl %al, %edi
 movl %edi, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 endif6:
 endif5:
 jmp endif4
 endif4:
 endif1:
 movl -12(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end0
 while7:
 movl -76(%ebp), %eax
 movl %eax, -40(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 movl -40(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 cmpl $0, %edi
 je else8
 then8:
 movl -32(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -56(%ebp)
 movl -56(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else9
 then9:
 movl -40(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 movl -32(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 movl -64(%ebp), %ecx
 movl %esi, %eax
 movl -52(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -64(%ebp)
 movl -64(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 jmp endif9
 else9:
 movl -32(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 movl -20(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else10
 then10:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 jmp endif10
 else10:
 movl -40(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -32(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 movl -60(%ebp), %ecx
 movl -4(%ebp), %eax
 movl %edi, %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -60(%ebp)
 movl -60(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 endif10:
 endif9:
 jmp endif8
 else8:
 movl -40(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 cmpl $0, %edi
 je endif11
 then11:
 movl -32(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 movl -8(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else12
 then12:
 movl -40(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -44(%ebp)
 movl -32(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 movl %ebx, %ecx
 movl %esi, %eax
 movl -44(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %ebx
 movl %ebx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 jmp endif12
 else12:
 movl -32(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 cmpl $0, %edi
 je else13
 then13:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 jmp endif13
 else13:
 movl -40(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 movl -32(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 cmpl %esi, %ecx
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 endif13:
 endif12:
 jmp endif11
 endif11:
 endif8:
 movl -68(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end7
 movl -28(%ebp), %eax
 movl %eax, -72(%ebp)
 movl -76(%ebp), %eax
 movl %eax, -24(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 while14:
 movl -72(%ebp), %edi
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -56(%ebp)
 pushl %edi
 call is_int
 movl %eax, %esi
 addl $4, %esp
 cmpl $0, %esi
 je else15
 then15:
 movl -56(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -64(%ebp)
 movl -64(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else16
 then16:
 movl %edi, %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 movl -56(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -4(%ebp), %ecx
 movl %edi, %eax
 movl -20(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -4(%ebp)
 movl -4(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 jmp endif16
 else16:
 movl -56(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -60(%ebp)
 movl -60(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else17
 then17:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 jmp endif17
 else17:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -56(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 movl -44(%ebp), %ecx
 movl -8(%ebp), %eax
 movl %edi, %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -44(%ebp)
 movl -44(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 endif17:
 endif16:
 jmp endif15
 else15:
 pushl %edi
 call is_bool
 movl %eax, %esi
 addl $4, %esp
 cmpl $0, %esi
 je endif18
 then18:
 movl -56(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 cmpl $0, %ebx
 je else19
 then19:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -56(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 cmpl %edi, %esi
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 jmp endif19
 else19:
 movl -56(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 cmpl $0, %ecx
 je else20
 then20:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 jmp endif20
 else20:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -56(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 endif20:
 endif19:
 jmp endif18
 endif18:
 endif15:
 movl -52(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end14
 movl -48(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else21
 then21:
 movl -24(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else22
 then22:
 movl -48(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -24(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 jmp endif22
 else22:
 movl -24(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else23
 then23:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 jmp endif23
 else23:
 movl -48(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -24(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 endif23:
 endif22:
 jmp endif21
 else21:
 movl -48(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else24
 then24:
 movl -24(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else25
 then25:
 movl -48(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -24(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 jmp endif25
 else25:
 movl -24(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else26
 then26:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 jmp endif26
 else26:
 movl -48(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -24(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 endif26:
 endif25:
 jmp endif24
 else24:
 movl -48(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif27
 then27:
 movl -24(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else28
 then28:
 movl -48(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -24(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 pushl %eax
 pushl %edi
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 jmp endif28
 else28:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -48(%ebp)
 endif28:
 jmp endif27
 endif27:
 endif24:
 endif21:
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else29
 then29:
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif29
 else29:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else30
 then30:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif30
 else30:
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif30:
 endif29:
 movl -72(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else31
 then31:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else32
 then32:
 movl -72(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 jmp endif32
 else32:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else33
 then33:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 jmp endif33
 else33:
 movl -72(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 endif33:
 endif32:
 jmp endif31
 else31:
 movl -72(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else34
 then34:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else35
 then35:
 movl -72(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 jmp endif35
 else35:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else36
 then36:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 jmp endif36
 else36:
 movl -72(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 endif36:
 endif35:
 jmp endif34
 else34:
 movl -72(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif37
 then37:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else38
 then38:
 movl -72(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 jmp endif38
 else38:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 endif38:
 jmp endif37
 endif37:
 endif34:
 endif31:
 jmp while14
 end14:
 movl -16(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else39
 then39:
 movl -48(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else40
 then40:
 movl -16(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -48(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif40
 else40:
 movl -48(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else41
 then41:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif41
 else41:
 movl -16(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -48(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif41:
 endif40:
 jmp endif39
 else39:
 movl -16(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else42
 then42:
 movl -48(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else43
 then43:
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -48(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif43
 else43:
 movl -48(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else44
 then44:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif44
 else44:
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -48(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif44:
 endif43:
 jmp endif42
 else42:
 movl -16(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif45
 then45:
 movl -48(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else46
 then46:
 movl -16(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -48(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 pushl %eax
 pushl %edi
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif46
 else46:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif46:
 jmp endif45
 endif45:
 endif42:
 endif39:
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else47
 then47:
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif47
 else47:
 pushl %edi
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
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif48:
 endif47:
 movl -76(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else49
 then49:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else50
 then50:
 movl -76(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 jmp endif50
 else50:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else51
 then51:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 jmp endif51
 else51:
 movl -76(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 endif51:
 endif50:
 jmp endif49
 else49:
 movl -76(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else52
 then52:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else53
 then53:
 movl -76(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 jmp endif53
 else53:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else54
 then54:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 jmp endif54
 else54:
 movl -76(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 endif54:
 endif53:
 jmp endif52
 else52:
 movl -76(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif55
 then55:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else56
 then56:
 movl -76(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 jmp endif56
 else56:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 endif56:
 jmp endif55
 endif55:
 endif52:
 endif49:
 jmp while7
 end7:
 pushl $1
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 movl -28(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else57
 then57:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else58
 then58:
 movl -28(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 jmp endif58
 else58:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else59
 then59:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 jmp endif59
 else59:
 movl -28(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 endif59:
 endif58:
 jmp endif57
 else57:
 movl -28(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else60
 then60:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else61
 then61:
 movl -28(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 jmp endif61
 else61:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else62
 then62:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 jmp endif62
 else62:
 movl -28(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 endif62:
 endif61:
 jmp endif60
 else60:
 movl -28(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif63
 then63:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else64
 then64:
 movl -28(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 jmp endif64
 else64:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 endif64:
 jmp endif63
 endif63:
 endif60:
 endif57:
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 jmp while0
 end0:
 movl -16(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else65
 then65:
 movl -16(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else66
 then66:
 movl -16(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -16(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif66
 else66:
 movl -16(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else67
 then67:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif67
 else67:
 movl -16(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif67:
 endif66:
 jmp endif65
 else65:
 movl -16(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else68
 then68:
 movl -16(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else69
 then69:
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif69
 else69:
 movl -16(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else70
 then70:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif70
 else70:
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -16(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif70:
 endif69:
 jmp endif68
 else68:
 movl -16(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif71
 then71:
 movl -16(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else72
 then72:
 movl -16(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -16(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 pushl %eax
 pushl %edi
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif72
 else72:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif72:
 jmp endif71
 endif71:
 endif68:
 endif65:
 movl -16(%ebp), %eax
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
