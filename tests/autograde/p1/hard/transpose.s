.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $92, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 movl $4, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -44(%ebp)
 pushl $7
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl $3
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
 movl %ecx, -20(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 movl -20(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -44(%ebp), %eax
 movl -20(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 movl -20(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -68(%ebp)
 movl $5, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -84(%ebp)
 pushl $8
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl $3
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
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -68(%ebp), %eax
 movl %edi, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -84(%ebp), %eax
 movl %edi, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 pushl %ebx
 pushl %ecx
 pushl %edi
 call set_subscript
 movl %eax, %ecx
 addl $12, %esp
 pushl $3
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl $6, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 movl $9, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -40(%ebp)
 pushl $3
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
 movl %ecx, -64(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 movl -64(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -32(%ebp), %eax
 movl -64(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -40(%ebp), %eax
 movl -64(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $3
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
 movl %ecx, -56(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -20(%ebp), %eax
 movl -56(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 movl -56(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -64(%ebp), %eax
 movl -56(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %ebx
 addl $8, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -88(%ebp)
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %edi
 addl $8, %esp
 pushl $3
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
 movl %ecx, -72(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 movl -72(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -88(%ebp), %eax
 movl -72(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 movl -72(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %edi
 addl $8, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -12(%ebp)
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -36(%ebp)
 pushl $3
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
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 pushl %edi
 pushl %ecx
 pushl %ebx
 call set_subscript
 movl %eax, %ecx
 addl $12, %esp
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -12(%ebp), %eax
 movl %ebx, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -36(%ebp), %eax
 movl %ebx, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -8(%ebp)
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -16(%ebp)
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %edi
 addl $8, %esp
 pushl $3
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
 movl %ecx, -48(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -8(%ebp), %eax
 movl -48(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -16(%ebp), %eax
 movl -48(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 movl -48(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $3
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
 movl %ecx, -76(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -72(%ebp), %eax
 movl -76(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 movl -76(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -48(%ebp), %eax
 movl -76(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -80(%ebp)
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -28(%ebp), %eax
 movl %ebx, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -28(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -28(%ebp), %eax
 movl %ebx, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %edi
 addl $8, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -24(%ebp)
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -60(%ebp), %eax
 movl -24(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -60(%ebp)
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -60(%ebp), %eax
 movl -24(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -52(%ebp)
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -80(%ebp), %eax
 movl %ebx, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call get_subscript
 movl %eax, %eax
 addl $8, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, -4(%ebp)
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %esi, %eax
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call get_subscript
 movl %eax, %esi
 addl $8, %esp
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %esi, %eax
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call get_subscript
 movl %eax, %esi
 addl $8, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %edi
 pushl %eax
 pushl %ebx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %eax
 addl $8, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %ebx
 addl $8, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %ebx
 pushl %eax
 pushl %edi
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %esi
 pushl %eax
 pushl %edi
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -56(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %edi
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -52(%ebp), %eax
 movl %edi, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl -56(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else0
 then0:
 movl -76(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else1
 then1:
 movl -56(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -76(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 jmp endif1
 else1:
 movl -76(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else2
 then2:
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 jmp endif2
 else2:
 movl -56(%ebp), %eax
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
 movl %ecx, %eax
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 endif2:
 endif1:
 jmp endif0
 else0:
 movl -56(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else3
 then3:
 movl -76(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else4
 then4:
 movl -56(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -76(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 jmp endif4
 else4:
 movl -76(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else5
 then5:
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 jmp endif5
 else5:
 movl -56(%ebp), %eax
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
 movl %ecx, %eax
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 endif5:
 endif4:
 jmp endif3
 else3:
 movl -56(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif6
 then6:
 movl -76(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else7
 then7:
 movl -56(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -76(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 pushl %eax
 pushl %edi
 call equal
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 jmp endif7
 else7:
 movl -76(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else8
 then8:
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 jmp endif8
 else8:
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -92(%ebp)
 endif8:
 endif7:
 jmp endif6
 endif6:
 endif3:
 endif0:
 movl -92(%ebp), %eax
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
