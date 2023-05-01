lambda_0:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl 8(%ebp), %ecx
 movl 12(%ebp), %eax
 movl %eax, %edi
 pushl $1
 call inject_bool
 movl %eax, %esi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif1
 else1:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif2
 else2:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif2:
 endif1:
 jmp endif0
 else0:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif3
 then3:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif4
 else4:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif5
 else5:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif5:
 endif4:
 jmp endif3
 endif3:
 endif0:
 pushl %ebx
 call is_true
 movl %eax, %edi
 addl $4, %esp
 cmpl $0, %edi
 je else6
 then6:
 pushl $1
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 jmp endif6
 else6:
 pushl $0
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 endif6:
 movl %eax, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret

.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl $lambda_0
 call create_closure
 movl %eax, %ebx
 addl $8, %esp
 pushl %ebx
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %ebx
 pushl %eax
 call set_free_vars
 movl %eax, %edi
 addl $8, %esp
 pushl %edi
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call get_fun_ptr
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call get_free_vars
 movl %eax, %edi
 addl $4, %esp
 call eval_input_pyobj
 pushl %eax
 pushl %edi
 call %ebx
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl $10
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 pushl $20
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif7:
 pushl %edi
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
