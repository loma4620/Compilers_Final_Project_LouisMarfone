.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
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
 movl %eax, %esi
 addl $4, %esp
 call create_dict
 pushl %eax
 call inject_big
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
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
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
 call inject_bool
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
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
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
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
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
 call inject_bool
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
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
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
 call not_equal
 movl %eax, %ecx
 addl $8, %esp
 pushl %ecx
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 pushl %ebx
 call is_bool
 movl %eax, %edi
 addl $4, %esp
 cmpl $0, %edi
 je else8
 then8:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif8
 else8:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif8:
 endif7:
 jmp endif6
 endif6:
 endif3:
 endif0:
 pushl %edi
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret