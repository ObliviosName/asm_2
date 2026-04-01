.global _start
.extern scanf
.extern printf

.data
a: .quad 0
b: .quad 0
c: .quad 0
ost: .quad 0

input_str: .asciz "%lld%lld%lld"
output_str: .asciz "Output value: %lld, %lld\n"

.text
_start:
    movq %rsp, %rbp                
    subq $32, %rsp                 
    andq $-16, %rsp                # вырав стек по 16 байт

    leaq input_str(%rip), %rdi     
    leaq a(%rip), %rsi             
    leaq b(%rip), %rdx             
    leaq c(%rip), %rcx             
    xor %eax, %eax
    call scanf

    movq c(%rip), %rax            
    movq %rax, %rbx                
    imulq %rax, %rbx               # C^2 -> rbx
    imulq %rax, %rbx               # C^3 -> rbx
    imulq $5, %rbx, %rbx           # 5*C^3 -> rbx

    movq a(%rip), %rax             # a -> rax
    imulq %rax, %rax               # A^2 -> rax
    imulq $2, %rax, %rax           # 2*A^2 -> rax

    movq b(%rip), %rcx             # b -> rcx
    imulq %rcx, %rcx               # B^2 -> rcx

    addq %rcx, %rax                # 2*A^2 + B^2 -> rax

    movq %rax, %rdi                
    movq %rbx, %rax                
    cqto                           
    idivq %rdi                     # rax = част, rdx = ост

    movq %rdx, ost(%rip)           

    leaq output_str(%rip), %rdi    
    movq %rax, %rsi                
    movq ost(%rip), %rdx           
    xor %eax, %eax
    call printf

    movq %rbp, %rsp                
    movq $0, %rdi                  
    movq $60, %rax                
    syscall