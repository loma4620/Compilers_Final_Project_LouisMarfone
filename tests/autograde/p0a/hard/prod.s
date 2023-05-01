.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $128, %esp
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
 movl %ecx, -124(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 while0:
 movl -28(%ebp), %eax
 movl %eax, -84(%ebp)
 movl $10, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -76(%ebp)
 movl -84(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -100(%ebp)
 movl -100(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else1
 then1:
 movl -76(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 cmpl $0, %edi
 je else2
 then2:
 movl -84(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 movl -76(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -80(%ebp)
 movl -116(%ebp), %ecx
 movl -80(%ebp), %eax
 movl -52(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -116(%ebp)
 movl -116(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 jmp endif2
 else2:
 movl -76(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 movl -32(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else3
 then3:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 jmp endif3
 else3:
 movl -84(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -76(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 movl %esi, %ecx
 movl -4(%ebp), %eax
 movl %edi, %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %esi
 movl %esi, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 endif3:
 endif2:
 jmp endif1
 else1:
 movl -84(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -88(%ebp)
 movl -88(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je endif4
 then4:
 movl -76(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -60(%ebp)
 movl -60(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else5
 then5:
 movl -84(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 movl -76(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -128(%ebp)
 movl -36(%ebp), %ecx
 movl -128(%ebp), %eax
 movl -24(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -36(%ebp)
 movl -36(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 jmp endif5
 else5:
 movl -76(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -104(%ebp)
 movl -104(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else6
 then6:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 jmp endif6
 else6:
 movl -84(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -76(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -112(%ebp)
 movl -16(%ebp), %ecx
 movl -112(%ebp), %eax
 movl %edi, %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -16(%ebp)
 movl -16(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 endif6:
 endif5:
 jmp endif4
 endif4:
 endif1:
 movl -68(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end0
 while7:
 movl -124(%ebp), %eax
 movl %eax, -100(%ebp)
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 movl -100(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -80(%ebp)
 movl -80(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else8
 then8:
 movl %edi, %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -116(%ebp)
 movl -116(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else9
 then9:
 movl -100(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -4(%ebp), %ecx
 movl %edi, %eax
 movl -32(%ebp), %ecx
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
 jmp endif9
 else9:
 pushl %edi
 call is_big
 movl %eax, %esi
 addl $4, %esp
 cmpl $0, %esi
 je else10
 then10:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 jmp endif10
 else10:
 movl -100(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -88(%ebp)
 movl %edi, %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -60(%ebp)
 movl -24(%ebp), %ecx
 movl -60(%ebp), %eax
 movl -88(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -24(%ebp)
 movl -24(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 endif10:
 endif9:
 jmp endif8
 else8:
 movl -100(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -128(%ebp)
 movl -128(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je endif11
 then11:
 movl %edi, %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -36(%ebp)
 movl -36(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else12
 then12:
 movl -100(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -104(%ebp)
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -112(%ebp), %ecx
 movl %edi, %eax
 movl -104(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -112(%ebp)
 movl -112(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 jmp endif12
 else12:
 movl %edi, %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 movl -16(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else13
 then13:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 jmp endif13
 else13:
 movl -100(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 movl %edi, %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -56(%ebp)
 movl -20(%ebp), %ecx
 movl -56(%ebp), %eax
 movl -8(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -20(%ebp)
 movl -20(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -52(%ebp)
 endif13:
 endif12:
 jmp endif11
 endif11:
 endif8:
 movl -52(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end7
 movl -28(%ebp), %eax
 movl %eax, -64(%ebp)
 movl -124(%ebp), %eax
 movl %eax, -48(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -40(%ebp)
 while14:
 movl -64(%ebp), %eax
 movl %eax, -80(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -116(%ebp)
 movl -80(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 cmpl $0, %edi
 je else15
 then15:
 movl -116(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 movl -4(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else16
 then16:
 movl -80(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 movl -116(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -88(%ebp)
 movl -60(%ebp), %ecx
 movl -88(%ebp), %eax
 movl %esi, %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -60(%ebp)
 movl -60(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 jmp endif16
 else16:
 movl -116(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 movl -24(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else17
 then17:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 jmp endif17
 else17:
 movl -80(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -128(%ebp)
 movl -116(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -36(%ebp)
 movl -104(%ebp), %ecx
 movl -36(%ebp), %eax
 movl -128(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -104(%ebp)
 movl -104(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 endif17:
 endif16:
 jmp endif15
 else15:
 movl -80(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 cmpl $0, %edi
 je endif18
 then18:
 movl -116(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -112(%ebp)
 movl -112(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else19
 then19:
 movl -80(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 movl -116(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 movl -56(%ebp), %ecx
 movl -8(%ebp), %eax
 movl -16(%ebp), %ecx
 cmpl %ecx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, -56(%ebp)
 movl -56(%ebp), %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 jmp endif19
 else19:
 movl -116(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 movl -20(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je else20
 then20:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 jmp endif20
 else20:
 movl -80(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -116(%ebp), %eax
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
 movl %ecx, -32(%ebp)
 endif20:
 endif19:
 jmp endif18
 endif18:
 endif15:
 movl -32(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end14
 movl -40(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else21
 then21:
 movl -48(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else22
 then22:
 movl -40(%ebp), %eax
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
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -40(%ebp)
 jmp endif22
 else22:
 movl -48(%ebp), %eax
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
 movl %ecx, -40(%ebp)
 jmp endif23
 else23:
 movl -40(%ebp), %eax
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
 movl %ecx, -40(%ebp)
 endif23:
 endif22:
 jmp endif21
 else21:
 movl -40(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else24
 then24:
 movl -48(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else25
 then25:
 movl -40(%ebp), %eax
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
 movl %ecx, -40(%ebp)
 jmp endif25
 else25:
 movl -48(%ebp), %eax
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
 movl %ecx, -40(%ebp)
 jmp endif26
 else26:
 movl -40(%ebp), %eax
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
 movl %ecx, -40(%ebp)
 endif26:
 endif25:
 jmp endif24
 else24:
 movl -40(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif27
 then27:
 movl -48(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else28
 then28:
 movl -40(%ebp), %eax
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
 movl %ecx, -40(%ebp)
 jmp endif28
 else28:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -40(%ebp)
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -96(%ebp)
 jmp endif29
 else29:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else30
 then30:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -96(%ebp)
 jmp endif30
 else30:
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -96(%ebp)
 endif30:
 endif29:
 movl -64(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else31
 then31:
 movl -96(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else32
 then32:
 movl -64(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -96(%ebp), %eax
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
 movl %ecx, -64(%ebp)
 jmp endif32
 else32:
 movl -96(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else33
 then33:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -64(%ebp)
 jmp endif33
 else33:
 movl -64(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -96(%ebp), %eax
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
 movl %ecx, -64(%ebp)
 endif33:
 endif32:
 jmp endif31
 else31:
 movl -64(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else34
 then34:
 movl -96(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else35
 then35:
 movl -64(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -96(%ebp), %eax
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
 movl %ecx, -64(%ebp)
 jmp endif35
 else35:
 movl -96(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else36
 then36:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -64(%ebp)
 jmp endif36
 else36:
 movl -64(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -96(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -64(%ebp)
 endif36:
 endif35:
 jmp endif34
 else34:
 movl -64(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif37
 then37:
 movl -96(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else38
 then38:
 movl -64(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -96(%ebp), %eax
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
 movl %ecx, -64(%ebp)
 jmp endif38
 else38:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -64(%ebp)
 endif38:
 jmp endif37
 endif37:
 endif34:
 endif31:
 jmp while14
 end14:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else39
 then39:
 movl -40(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else40
 then40:
 pushl %ebx
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -40(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif40
 else40:
 movl -40(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else41
 then41:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif41
 else41:
 pushl %ebx
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -40(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif41:
 endif40:
 jmp endif39
 else39:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else42
 then42:
 movl -40(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else43
 then43:
 pushl %ebx
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -40(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif43
 else43:
 movl -40(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else44
 then44:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif44
 else44:
 pushl %ebx
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -40(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif44:
 endif43:
 jmp endif42
 else42:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif45
 then45:
 movl -40(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else46
 then46:
 pushl %ebx
 call project_big
 movl %eax, %edi
 addl $4, %esp
 movl -40(%ebp), %eax
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
 movl %eax, %ebx
 addl $4, %esp
 jmp endif46
 else46:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
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
 movl %eax, %edi
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
 movl %eax, %edi
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
 movl %eax, %edi
 addl $4, %esp
 endif48:
 endif47:
 movl -124(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else49
 then49:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else50
 then50:
 movl -124(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 pushl %edi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl -12(%ebp), %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -124(%ebp)
 jmp endif50
 else50:
 pushl %edi
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
 movl %ecx, -124(%ebp)
 jmp endif51
 else51:
 movl -124(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl -92(%ebp), %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -124(%ebp)
 endif51:
 endif50:
 jmp endif49
 else49:
 movl -124(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else52
 then52:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else53
 then53:
 movl -124(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -44(%ebp)
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl -44(%ebp), %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -124(%ebp)
 jmp endif53
 else53:
 pushl %edi
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
 movl %ecx, -124(%ebp)
 jmp endif54
 else54:
 movl -124(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -120(%ebp)
 pushl %edi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl -120(%ebp), %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -124(%ebp)
 endif54:
 endif53:
 jmp endif52
 else52:
 movl -124(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif55
 then55:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else56
 then56:
 movl -124(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -108(%ebp)
 pushl %edi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 movl -108(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -124(%ebp)
 jmp endif56
 else56:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -124(%ebp)
 endif56:
 jmp endif55
 endif55:
 endif52:
 endif49:
 jmp while7
 end7:
 movl $1, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -72(%ebp)
 movl -28(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else57
 then57:
 movl -72(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else58
 then58:
 movl -28(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -72(%ebp), %eax
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
 movl %ecx, -28(%ebp)
 jmp endif58
 else58:
 movl -72(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
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
 movl -72(%ebp), %eax
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
 movl -72(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else61
 then61:
 movl -28(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -72(%ebp), %eax
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
 movl %ecx, -28(%ebp)
 jmp endif61
 else61:
 movl -72(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
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
 movl -72(%ebp), %eax
 pushl %eax
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
 movl -72(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else64
 then64:
 movl -28(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -72(%ebp), %eax
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
 movl %ecx, -124(%ebp)
 jmp while0
 end0:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else65
 then65:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else66
 then66:
 pushl %ebx
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
 movl %eax, %ebx
 addl $4, %esp
 jmp endif66
 else66:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else67
 then67:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif67
 else67:
 pushl %ebx
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
 movl %eax, %ebx
 addl $4, %esp
 endif67:
 endif66:
 jmp endif65
 else65:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else68
 then68:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else69
 then69:
 pushl %ebx
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
 movl %eax, %ebx
 addl $4, %esp
 jmp endif69
 else69:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else70
 then70:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif70
 else70:
 pushl %ebx
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
 movl %eax, %ebx
 addl $4, %esp
 endif70:
 endif69:
 jmp endif68
 else68:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif71
 then71:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else72
 then72:
 pushl %ebx
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
 movl %eax, %ebx
 addl $4, %esp
 jmp endif72
 else72:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 endif72:
 jmp endif71
 endif71:
 endif68:
 endif65:
 pushl %ebx
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
