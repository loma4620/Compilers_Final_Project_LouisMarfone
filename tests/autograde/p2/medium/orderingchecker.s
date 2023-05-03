lambda_0:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 movl 8(%ebp), %ecx
 movl 12(%ebp), %eax
 movl %eax, %eax 
 movl %ebp, %esp
 popl %ebp
 ret

lambda_1:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 movl 8(%ebp), %eax
 movl 12(%ebp), %ecx
 movl %ecx, %eax 
 movl %ebp, %esp
 popl %ebp
 ret

.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $4, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
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
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ebx
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
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %edi
 pushl %eax
 call set_free_vars
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ebx
 addl $4, %esp
 pushl $12
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call get_fun_ptr
 movl %eax, %esi
 addl $4, %esp
 pushl %ebx
 call get_free_vars
 movl %eax, %eax
 addl $4, %esp
 pushl %edi
 pushl %eax
 call %esi
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call print_any
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
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl $lambda_1
 call create_closure
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ebx
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
 movl %eax, %esi
 addl $4, %esp
 pushl %ebx
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %esi
 pushl %eax
 call set_free_vars
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ebx
 addl $4, %esp
 pushl %ebx
 call get_fun_ptr
 movl %eax, %esi
 addl $4, %esp
 pushl %ebx
 call get_free_vars
 movl %eax, %eax
 addl $4, %esp
 pushl %edi
 pushl %eax
 call %esi
 movl %eax, %eax
 addl $8, %esp
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
