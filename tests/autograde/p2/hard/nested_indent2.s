lambda_0:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 movl 8(%ebp), %eax
 pushl $5
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call print_any
 addl $4, %esp
 movl %edi, %eax 
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret

lambda_1:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl 8(%ebp), %ebx
 pushl $3
 call inject_int
 movl %eax, %esi
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
 pushl $lambda_0
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
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %ebx
 pushl %eax
 call set_free_vars
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call print_any
 addl $4, %esp
 pushl %edi
 call get_fun_ptr
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call get_free_vars
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call %ebx
 movl %eax, %ebx
 addl $4, %esp
 movl %ebx, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret

lambda_2:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl 8(%ebp), %eax
 pushl $1
 call inject_int
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
 pushl %ebx
 call print_any
 addl $4, %esp
 pushl %edi
 call get_fun_ptr
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call get_free_vars
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call %ebx
 movl %eax, %eax
 addl $4, %esp
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
 pushl $lambda_2
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
 pushl %ebx
 call get_fun_ptr
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call get_free_vars
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call %edi
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
