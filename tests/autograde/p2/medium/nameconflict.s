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
 movl 8(%ebp), %ecx
 movl 12(%ebp), %eax
 movl %eax, %eax 
 movl %ebp, %esp
 popl %ebp
 ret

lambda_2:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 movl 8(%ebp), %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %edi
 addl $8, %esp
 movl %edi, %eax 
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret

.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $8, %esp
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
 movl %eax, %esi
 addl $4, %esp
 pushl %edi
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
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl $lambda_2
 call create_closure
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl %esi
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 pushl %ecx
 call set_free_vars
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %eax
 pushl %eax
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 pushl %edi
 call get_fun_ptr
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call get_free_vars
 movl %eax, %edi
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call %ebx
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 pushl %esi
 call get_fun_ptr
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call get_free_vars
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call %edi
 movl %eax, %ebx
 addl $4, %esp
 pushl %ebx
 call get_fun_ptr
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call get_free_vars
 movl %eax, %ebx
 addl $4, %esp
 pushl $4
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call %edi
 movl %eax, %ebx
 addl $8, %esp
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
