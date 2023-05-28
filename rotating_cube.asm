@WCName
.string "ROTATINGCUBE"
@WinName
.string "Rotating Cube"

@buf_display
push %rax
push %rcx
push %rdx
push %rsi
push %rdi
push %r8
push %r9
push %r10
push %r11
push %rbp
mov %rsp,%rbp
and $0xf0,%spl
sub $8,%rsp
mov $@_$DATA+4096,%r8
mov $360000,%edx
mov @_$DATA+16,%rcx
push %r8
push %rdx
push %rcx
.dllcall "gdi32.dll" "SetBitmapBits"
add $24,%rsp
mov @_$DATA+0,%rcx
xor %edx,%edx
mov %rdx,%r8
mov $300,%r9
pushq $0xcc0020
push %rdx
push %rdx
pushq @_$DATA+8
pushq $300
push %r9
push %r8
push %rdx
push %rcx
.dllcall "gdi32.dll" "BitBlt"

mov %rbp,%rsp
pop %rbp
pop %r11
pop %r10
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rdx
pop %rcx
pop %rax
ret

@buf_clear
push %rax
push %rcx
push %rdx

mov $5625,%ecx
mov $@_$DATA+4096,%rdx
xor %eax,%eax
@_buf_clear_loop
mov %rax,(%rdx)
mov %rax,8(%rdx)
mov %rax,16(%rdx)
mov %rax,24(%rdx)
mov %rax,32(%rdx)
mov %rax,40(%rdx)
mov %rax,48(%rdx)
mov %rax,56(%rdx)
add $64,%rdx
dec %ecx
jne @_buf_clear_loop

pop %rdx
pop %rcx
pop %rax
ret

@zbuf_clear
push %rax
push %rcx
push %rdx

mov $11250,%ecx
mov $@_$DATA+364096,%rdx
mov $0xbff0000000000000,%rax
@_zbuf_clear_loop
mov %rax,(%rdx)
mov %rax,8(%rdx)
mov %rax,16(%rdx)
mov %rax,24(%rdx)
mov %rax,32(%rdx)
mov %rax,40(%rdx)
mov %rax,48(%rdx)
mov %rax,56(%rdx)
add $64,%rdx
dec %ecx
jne @_zbuf_clear_loop

pop %rdx
pop %rcx
pop %rax
ret

@clock
push %rcx
push %rdx
push %rsi
push %rdi
push %r8
push %r9
push %r10
push %r11
push %rbp
mov %rsp,%rbp
and $0xf0,%spl
sub $32,%rsp
.dllcall "msvcrt.dll" "clock"
mov @_$DATA+32,%rcx
mov %rax,@_$DATA+32
sub %rcx,%rax
mov %rbp,%rsp
pop %rbp
pop %r11
pop %r10
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rdx
pop %rcx
ret


@calculate_screen_coord
push %rax
movsd 8(%rcx),%xmm1
movsd 16(%rcx),%xmm2
mov $0x4014000000000000,%rax
movq %rax,%xmm3
addsd (%rcx),%xmm3
xor %eax,%eax
movq %rax,%xmm0
subsd %xmm1,%xmm0
movq %rax,%xmm1
subsd %xmm2,%xmm1
movsd %xmm3,%xmm2
divsd %xmm2,%xmm0
divsd %xmm2,%xmm1
mov $0x3ff0000000000000,%rax
movq %rax,%xmm3
divsd %xmm2,%xmm3
mov $0x3ee0000000000000,%rax
movq %rax,%xmm2
addsd %xmm2,%xmm0
addsd %xmm2,%xmm1
movsd %xmm0,(%rdx)
movsd %xmm1,8(%rdx)
movsd %xmm3,16(%rdx)
pop %rax
ret

@solve3
sub $8,%rsp
movsd (%rcx),%xmm0
movsd 8(%rcx),%xmm1
movsd 16(%rcx),%xmm2
movsd %xmm0,%xmm3
movsd %xmm1,%xmm4
movsd %xmm2,%xmm5
mulsd 40(%rcx),%xmm0
mulsd 48(%rcx),%xmm1
mulsd 32(%rcx),%xmm2
mulsd 48(%rcx),%xmm3
mulsd 32(%rcx),%xmm4
mulsd 40(%rcx),%xmm5
mulsd 80(%rcx),%xmm0
mulsd 64(%rcx),%xmm1
mulsd 72(%rcx),%xmm2
mulsd 72(%rcx),%xmm3
mulsd 80(%rcx),%xmm4
mulsd 64(%rcx),%xmm5
addsd %xmm1,%xmm0
addsd %xmm2,%xmm0
subsd %xmm3,%xmm0
subsd %xmm4,%xmm0
subsd %xmm5,%xmm0
mov $0x3e00000000000000,%rax
movq %rax,%xmm1
mov $0xbe00000000000000,%rax
movq %rax,%xmm2
comisd %xmm1,%xmm0
ja @solve3_valid
comisd %xmm2,%xmm0
ja @solve3_err
@solve3_valid
movsd %xmm0,(%rsp)
movsd 8(%rcx),%xmm0
movsd 16(%rcx),%xmm1
movsd 24(%rcx),%xmm2
movsd %xmm0,%xmm3
movsd %xmm1,%xmm4
movsd %xmm2,%xmm5
mulsd 48(%rcx),%xmm0
mulsd 56(%rcx),%xmm1
mulsd 40(%rcx),%xmm2
mulsd 56(%rcx),%xmm3
mulsd 40(%rcx),%xmm4
mulsd 48(%rcx),%xmm5
mulsd 88(%rcx),%xmm0
mulsd 72(%rcx),%xmm1
mulsd 80(%rcx),%xmm2
mulsd 80(%rcx),%xmm3
mulsd 88(%rcx),%xmm4
mulsd 72(%rcx),%xmm5
addsd %xmm1,%xmm0
addsd %xmm2,%xmm0
subsd %xmm3,%xmm0
subsd %xmm4,%xmm0
subsd %xmm5,%xmm0
divsd (%rsp),%xmm0
movsd %xmm0,(%rdx)
xor %eax,%eax

jmp @solve3_end
@solve3_err
mov $1,%eax
@solve3_end
add $8,%rsp
ret

@set_pixel_end
ret
@set_pixel
# 16 -- x
# 24 -- y
# 32 -- a
# 40 -- b
# 48 -- c
# 56 -- color
cmpl $-150,16(%rbp)
jl @set_pixel_end
cmpl $150,16(%rbp)
jge @set_pixel_end
cmpl $-150,24(%rbp)
jl @set_pixel_end
cmpl $150,24(%rbp)
jge @set_pixel_end
push %rbp
mov %rsp,%rbp
push %rax
push %rcx
push %rdx
sub $32,%rsp
movsd %xmm0,(%rsp)
movsd %xmm1,8(%rsp)
movsd %xmm2,16(%rsp)
movsd %xmm3,24(%rsp)
sub $16,%rsp

movslq 16(%rbp),%rax
mov %rax,16(%rbp)
movslq 24(%rbp),%rax
mov %rax,24(%rbp)

fildq 16(%rbp)
fildq 24(%rbp)
fstpl 8(%rsp)
fstpl (%rsp)
movsd (%rsp),%xmm0
movsd 8(%rsp),%xmm1
mulsd 32(%rbp),%xmm0
mulsd 40(%rbp),%xmm1
addsd %xmm0,%xmm1
mov $0x3ff0000000000000,%rax
movq %rax,%xmm0
subsd %xmm1,%xmm0
divsd 48(%rbp),%xmm0
mov $150,%eax
add 24(%rbp),%eax
mov $300,%edx
imul %edx
add $150,%eax
add 16(%rbp),%eax

mov $@_$DATA+364096,%rdx
movsd (%rdx,%rax,8),%xmm1
comisd %xmm1,%xmm0
jb @set_pixel_L1
movsd %xmm0,(%rdx,%rax,8)
mov 56(%rbp),%ecx
mov $@_$DATA+4096,%rdx
mov %ecx,(%rdx,%rax,4)

@set_pixel_L1

add $16,%rsp
movsd (%rsp),%xmm0
movsd 8(%rsp),%xmm1
movsd 16(%rsp),%xmm2
movsd 24(%rsp),%xmm3
add $32,%rsp
mov %rbp,%rsp
pop %rbp
ret

@fill_triangle_2d
# 16 -- x1
# 24 -- y1
# 32 -- x2
# 40 -- y2
# 48 -- x3
# 56 -- y3
# 64 -- a
# 72 -- b
# 80 -- c
# 88 -- color
push %rbp
mov %rsp,%rbp
push %rax
push %rcx
push %rdx
push %rsi
push %rdi
push %r8
push %r9
push %r10
push %r11
push %r12
push %r13
push %r14
push %r15
sub $64,%rsp

mov 24(%rbp),%r8d
mov 40(%rbp),%r9d
cmp %r9d,%r8d
jle @ftl1
mov %r8d,40(%rbp)
mov %r9d,24(%rbp)
mov 16(%rbp),%r8d
mov 32(%rbp),%r9d
mov %r8d,32(%rbp)
mov %r9d,16(%rbp)
@ftl1

mov 24(%rbp),%r8d
mov 56(%rbp),%r9d
cmp %r9d,%r8d
jle @ftl2
mov %r8d,56(%rbp)
mov %r9d,24(%rbp)
mov 16(%rbp),%r8d
mov 48(%rbp),%r9d
mov %r8d,48(%rbp)
mov %r9d,16(%rbp)
@ftl2

mov 40(%rbp),%r8d
mov 56(%rbp),%r9d
cmp %r9d,%r8d
jle @ftl3
mov %r8d,56(%rbp)
mov %r9d,40(%rbp)
mov 32(%rbp),%r8d
mov 48(%rbp),%r9d
mov %r8d,48(%rbp)
mov %r9d,32(%rbp)
@ftl3

mov 32(%rbp),%r8d
mov 48(%rbp),%r9d
mov %r9d,%r10d
sub 16(%rbp),%r8d
sub 16(%rbp),%r9d
sub 32(%rbp),%r10d
mov 40(%rbp),%r11d
mov 56(%rbp),%r12d
mov %r12d,%r13d
sub 24(%rbp),%r11d
sub 24(%rbp),%r12d
sub 40(%rbp),%r13d

mov %r8d,(%rsp)
mov %r9d,4(%rsp)
mov %r10d,8(%rsp)
mov %r11d,12(%rsp)
mov %r12d,16(%rsp)
mov %r13d,20(%rsp)

# 0 -- x2-x1
# 4 -- x3-x1
# 8 -- x3-x2
# 12 -- y2-y1
# 16 -- y3-y1
# 20 -- y3-y2

xor %esi,%esi
mov 24(%rbp),%edi
@ftl4
cmp 40(%rbp),%edi
jge @ftl5
mov (%rsp),%eax
imul %esi
mov 12(%rsp),%r8d
idiv %r8d
mov %eax,%r8d
mov 4(%rsp),%eax
imul %esi
mov 16(%rsp),%r9d
idiv %r9d
mov %eax,%r9d
add 16(%rbp),%r8d
add 16(%rbp),%r9d
cmp %r9d,%r8d
jl @ftl6
xchg %r9d,%r8d
@ftl6
cmp %r9d,%r8d
jge @ftl7
pushq 88(%rbp)
pushq 80(%rbp)
pushq 72(%rbp)
pushq 64(%rbp)
push %rdi
push %r8
call @set_pixel
add $48,%rsp
inc %r8d
jmp @ftl6
@ftl7

inc %esi
inc %edi
jmp @ftl4
@ftl5

@ftl8
cmp 56(%rbp),%edi
jge @ftl9
mov 8(%rsp),%eax
mov %esi,%r10d
sub 12(%rsp),%r10d
imul %r10d
mov 20(%rsp),%r8d
idiv %r8d
mov %eax,%r8d
mov 4(%rsp),%eax
imul %esi
mov 16(%rsp),%r9d
idiv %r9d
mov %eax,%r9d
add 32(%rbp),%r8d
add 16(%rbp),%r9d
cmp %r9d,%r8d
jl @ftl10
xchg %r9d,%r8d
@ftl10
cmp %r9d,%r8d
jge @ftl11
pushq 88(%rbp)
pushq 80(%rbp)
pushq 72(%rbp)
pushq 64(%rbp)
push %rdi
push %r8
call @set_pixel
add $48,%rsp
inc %r8d
jmp @ftl10
@ftl11

inc %esi
inc %edi
jmp @ftl8
@ftl9

add $64,%rsp
pop %r15
pop %r14
pop %r13
pop %r12
pop %r11
pop %r10
pop %r9
pop %r8
pop %rdi
pop %rsi
pop %rdx
pop %rcx
pop %rax
mov %rbp,%rsp
pop %rbp
ret


@fill_triangle
# 16 -- P1
# 40 -- P2
# 64 -- P3
# 88 -- color
push %rbp
mov %rsp,%rbp
push %rax
push %rcx
push %rdx
sub $96,%rsp
lea 16(%rbp),%rcx
mov %rsp,%rdx
call @calculate_screen_coord
add $24,%rcx
add $32,%rdx
call @calculate_screen_coord
add $24,%rcx
add $32,%rdx
call @calculate_screen_coord
mov $0x4069000000000000,%rax
movq %rax,%xmm0
xor %ecx,%ecx
@ftl3_1
movsd (%rsp,%rcx),%xmm1
mulsd %xmm0,%xmm1
movsd %xmm1,(%rsp,%rcx)
movsd 8(%rsp,%rcx),%xmm1
mulsd %xmm0,%xmm1
movsd %xmm1,8(%rsp,%rcx)
add $32,%ecx
cmp $96,%ecx
jb @ftl3_1
mov $0x3ff0000000000000,%rax
mov %rax,24(%rsp)
mov %rax,56(%rsp)
mov %rax,88(%rsp)
lea -32(%rsp),%rdx
mov %rsp,%rcx
call @solve3
test %eax,%eax
jne @ftl3_Err
mov (%rsp),%rax
mov 8(%rsp),%rcx
mov %rcx,(%rsp)
mov %rax,8(%rsp)
mov 32(%rsp),%rax
mov 40(%rsp),%rcx
mov %rcx,32(%rsp)
mov %rax,40(%rsp)
mov 64(%rsp),%rax
mov 72(%rsp),%rcx
mov %rcx,64(%rsp)
mov %rax,72(%rsp)
lea -24(%rsp),%rdx
mov %rsp,%rcx
call @solve3
test %eax,%eax
jne @ftl3_Err
mov (%rsp),%rax
mov 16(%rsp),%rcx
mov %rcx,(%rsp)
mov %rax,16(%rsp)
mov 32(%rsp),%rax
mov 48(%rsp),%rcx
mov %rcx,32(%rsp)
mov %rax,48(%rsp)
mov 64(%rsp),%rax
mov 80(%rsp),%rcx
mov %rcx,64(%rsp)
mov %rax,80(%rsp)
lea -16(%rsp),%rdx
mov %rsp,%rcx
call @solve3
test %eax,%eax
jne @ftl3_Err
mov %rsp,%rcx
sub $32,%rsp
mov 88(%rbp),%eax
mov %rax,24(%rsp)
sub $8,%rsp
fldl 80(%rcx)
fistpq (%rsp)
sub $8,%rsp
fldl 72(%rcx)
fistpq (%rsp)
sub $8,%rsp
fldl 48(%rcx)
fistpq (%rsp)
sub $8,%rsp
fldl 40(%rcx)
fistpq (%rsp)
sub $8,%rsp
fldl 16(%rcx)
fistpq (%rsp)
sub $8,%rsp
fldl 8(%rcx)
fistpq (%rsp)
call @fill_triangle_2d


mov %rcx,%rsp
@ftl3_Err
add $96,%rsp
pop %rdx
pop %rcx
pop %rax
mov %rbp,%rsp
pop %rbp
ret

@get_point_coord
push %rax

mov $0x3ff0000000000000,%rax
movq %rax,%xmm0
movq %rax,%xmm1
movq %rax,%xmm2
mov $0xbff0000000000000,%rax
test $0x1,%cl
je @gcl1
movq %rax,%xmm0
@gcl1
test $0x2,%cl
je @gcl2
movq %rax,%xmm1
@gcl2
test $0x4,%cl
je @gcl3
movq %rax,%xmm2
@gcl3
movsd %xmm0,%xmm3
movsd %xmm0,%xmm4
movsd %xmm0,%xmm5
mulsd @_$DATA+40+0,%xmm3
mulsd @_$DATA+40+8,%xmm4
mulsd @_$DATA+40+16,%xmm5
movsd %xmm1,%xmm6
movsd %xmm1,%xmm7
movsd %xmm1,%xmm8
mulsd @_$DATA+40+24,%xmm6
mulsd @_$DATA+40+32,%xmm7
mulsd @_$DATA+40+40,%xmm8
addsd %xmm6,%xmm3
addsd %xmm7,%xmm4
addsd %xmm8,%xmm5
movsd %xmm2,%xmm6
movsd %xmm2,%xmm7
movsd %xmm2,%xmm8
mulsd @_$DATA+40+48,%xmm6
mulsd @_$DATA+40+56,%xmm7
mulsd @_$DATA+40+64,%xmm8
addsd %xmm6,%xmm3
addsd %xmm7,%xmm4
addsd %xmm8,%xmm5

movsd %xmm3,(%rdx)
movsd %xmm4,8(%rdx)
movsd %xmm5,16(%rdx)

pop %rax
ret

@paint_square
# %rax -- points
# %rdx -- color
push %rax
push %rcx
push %rdx
sub $72,%rsp
mov %rsp,%rdx
mov %al,%cl
call @get_point_coord
add $24,%rdx
mov %ah,%cl
call @get_point_coord
add $24,%rdx
shr $8,%eax
mov %ah,%cl
call @get_point_coord
call @fill_triangle
mov %rsp,%rdx
mov %al,%cl
call @get_point_coord
add $24,%rdx
mov %ah,%cl
call @get_point_coord
add $24,%rdx
shr $8,%eax
mov %ah,%cl
call @get_point_coord
call @fill_triangle
add $72,%rsp
pop %rdx
pop %rcx
pop %rax
ret
@paint_all
call @zbuf_clear
cmpb $0,@_$DATA+26
jne @paint_all_init
mov $0x3ff0000000000000,%rax
xor %edx,%edx
mov %rax,@_$DATA+40+0
mov %rdx,@_$DATA+40+8
mov %rdx,@_$DATA+40+16
mov %rdx,@_$DATA+40+24
mov %rax,@_$DATA+40+32
mov %rdx,@_$DATA+40+40
mov %rdx,@_$DATA+40+48
mov %rdx,@_$DATA+40+56
mov %rax,@_$DATA+40+64
movb $1,@_$DATA+26
@paint_all_init

mov $0x00020406,%eax
mov $0xff0000,%edx
call @paint_square
mov $0x02030607,%eax
mov $0xff00,%edx
call @paint_square
mov $0x01030507,%eax
mov $0xff,%edx
call @paint_square
mov $0x00010405,%eax
mov $0xffff,%edx
call @paint_square
mov $0x00010203,%eax
mov $0xff00ff,%edx
call @paint_square
mov $0x04050607,%eax
mov $0xffff00,%edx
call @paint_square

ret

.align 3
@sinA
.quad 0x3f6c986d3571a3ca
@cosA
.quad 0x3feffff33932dcce

@sincosnA
push %rax
push %rcx
xor %ecx,%ecx
movq %rcx,%xmm0
mov $0x3ff0000000000000,%rcx
movq %rcx,%xmm1
cmp $0,%rax
je @sincosnA_end
jl @sincosnA_loop2
@sincosnA_loop1

movsd %xmm0,%xmm2
mulsd @cosA,%xmm2
movsd %xmm1,%xmm3
mulsd @sinA,%xmm3
addsd %xmm3,%xmm2

movsd %xmm1,%xmm3
mulsd @cosA,%xmm3
movsd %xmm0,%xmm4
mulsd @sinA,%xmm4
subsd %xmm4,%xmm3

movsd %xmm2,%xmm0
movsd %xmm3,%xmm1

dec %rax
jne @sincosnA_loop1
jmp @sincosnA_end
@sincosnA_loop2

movsd %xmm0,%xmm2
mulsd @cosA,%xmm2
movsd %xmm1,%xmm3
mulsd @sinA,%xmm3
subsd %xmm3,%xmm2

movsd %xmm1,%xmm3
mulsd @cosA,%xmm3
movsd %xmm0,%xmm4
mulsd @sinA,%xmm4
addsd %xmm4,%xmm3

movsd %xmm2,%xmm0
movsd %xmm3,%xmm1

inc %rax
jne @sincosnA_loop2
@sincosnA_end
pop %rcx
pop %rax
ret

@vector_rotate_y
movsd (%rcx),%xmm2
movsd 16(%rcx),%xmm3
mulsd %xmm1,%xmm2
mulsd %xmm0,%xmm3
subsd %xmm3,%xmm2
movsd (%rcx),%xmm3
movsd 16(%rcx),%xmm4
mulsd %xmm0,%xmm3
mulsd %xmm1,%xmm4
addsd %xmm4,%xmm3
movsd %xmm2,(%rcx)
movsd %xmm3,16(%rcx)
ret

@vector_rotate_x
movsd (%rcx),%xmm2
movsd 8(%rcx),%xmm3
mulsd %xmm1,%xmm2
mulsd %xmm0,%xmm3
subsd %xmm3,%xmm2
movsd (%rcx),%xmm3
movsd 8(%rcx),%xmm4
mulsd %xmm0,%xmm3
mulsd %xmm1,%xmm4
addsd %xmm4,%xmm3
movsd %xmm2,(%rcx)
movsd %xmm3,8(%rcx)
ret

@rotate_up_down
call @sincosnA
mov $@_$DATA+40+0,%rcx
call @vector_rotate_y
add $24,%rcx
call @vector_rotate_y
add $24,%rcx
call @vector_rotate_y
ret

@rotate_left_right
call @sincosnA
mov $@_$DATA+40+0,%rcx
call @vector_rotate_x
add $24,%rcx
call @vector_rotate_x
add $24,%rcx
call @vector_rotate_x
ret

@T_paint
mov $0,%al
xchg %al,@_$DATA+24
test %al,%al
je @T_paint_wait
@T_paint_do_paint
call @buf_clear
call @paint_all
call @buf_display
@T_paint_wait
call @clock
cmpb $0,@_$DATA+26
je @T_paint_key
cmpb $0,@_$DATA+25
je @T_paint_key
movb $1,@_$DATA+24
cmpb $1,@_$DATA+25
jne @T_paint_key_up
neg %rax
call @rotate_up_down
jmp @T_paint_key
@T_paint_key_up

cmpb $2,@_$DATA+25
jne @T_paint_key_down
call @rotate_up_down
jmp @T_paint_key
@T_paint_key_down

cmpb $3,@_$DATA+25
jne @T_paint_key_left
neg %rax
call @rotate_left_right
jmp @T_paint_key
@T_paint_key_left

cmpb $4,@_$DATA+25
jne @T_paint_key_right
call @rotate_left_right
@T_paint_key_right

@T_paint_key

sub $32,%rsp
mov $3,%ecx
push %rcx
.dllcall "kernel32.dll" "Sleep"
add $40,%rsp
jmp @T_paint

@WndProc
push %rbp
mov %rsp,%rbp
push %r9
push %r8
push %rdx
push %rcx
cmp $2,%edx
jne @WndProc_Destroy
xor %ecx,%ecx
sub $24,%rsp
push %rcx
.dllcall "kernel32.dll" "ExitProcess"

@WndProc_Destroy
cmp $15,%edx
jne @WndProc_Paint
sub $96,%rsp
mov -32(%rbp),%rcx
lea 16(%rsp),%rdx
push %rdx
push %rcx
.dllcall "user32.dll" "BeginPaint"
add $16,%rsp
mov -32(%rbp),%rcx
lea 16(%rsp),%rdx
push %rdx
push %rcx
.dllcall "user32.dll" "EndPaint"
add $112,%rsp
movb $1,@_$DATA+24
jmp @WndProc_End
@WndProc_Paint
cmp $256,%edx
jne @WndProc_Keydown
cmp $38,%r8d
jne @Keydown_Up

movb $1,@_$DATA+25
jmp @WndProc_End
@Keydown_Up
cmp $40,%r8d
jne @Keydown_Down

movb $2,@_$DATA+25
jmp @WndProc_End
@Keydown_Down
cmp $37,%r8d
jne @Keydown_Left

movb $3,@_$DATA+25
jmp @WndProc_End
@Keydown_Left
cmp $39,%r8d
jne @Keydown_Right

movb $4,@_$DATA+25
@Keydown_Right
@WndProc_Keydown
cmp $257,%edx
jne @WndProc_Keyup

cmp $37,%r8d
jb @WndProc_End
cmp $40,%r8d
ja @WndProc_End
movb $0,@_$DATA+25

@WndProc_Keyup
@WndProc_End
lea -32(%rbp),%rsp
mov (%rsp),%rcx
mov 8(%rsp),%rdx
mov 16(%rsp),%r8
mov 24(%rsp),%r9
.dllcall "user32.dll" "DefWindowProcA"
add $32,%rsp
pop %rbp
ret

.entry
push %rbp
mov %rsp,%rbp
sub $80,%rsp

xor %ebx,%ebx

movq $80,(%rsp)
movq $@WndProc,8(%rsp)
mov %rbx,16(%rsp)
movq $0x400000,24(%rsp)

sub $16,%rsp

mov $0x7f00,%edx
mov %ebx,%ecx
push %rdx
push %rcx
.dllcall "user32.dll" "LoadIconA"
add $16,%rsp
mov %rax,48(%rsp)

mov $0x7f00,%edx
mov %ebx,%ecx
push %rdx
push %rcx
.dllcall "user32.dll" "LoadCursorA"
add $32,%rsp
mov %rax,40(%rsp)
movq $8,48(%rsp)
mov %rbx,56(%rsp)
movq $@WCName,64(%rsp)
mov %rbx,72(%rsp)

mov %rsp,%rcx
sub $24,%rsp
push %rcx
.dllcall "user32.dll" "RegisterClassExA"
add $32,%rsp
test %rax,%rax
je @Err_Exit

push %rbx
pushq $0x400000
push %rbx
push %rbx
pushq $300+29
pushq $300+6
push %rbx
push %rbx
mov $0x10c80000,%r9d
mov $@WinName,%r8d
mov $@WCName,%edx
mov $0x100,%ecx
push %r9
push %r8
push %rdx
push %rcx
.dllcall "user32.dll" "CreateWindowExA"
add $72,%rsp
test %rax,%rax
je @Err_Exit

mov %rax,%r14
mov %rax,%rcx

push %rcx
.dllcall "user32.dll" "GetDC"
add $8,%rsp
mov %rax,%rcx
mov %rax,@_$DATA+0
push %rcx
.dllcall "gdi32.dll" "CreateCompatibleDC"
mov %rax,@_$DATA+8
mov @_$DATA+0,%rcx
mov $300,%edx
mov $300,%r8d
push %r8
push %rdx
push %rcx
.dllcall "gdi32.dll" "CreateCompatibleBitmap"
add $16,%rsp
mov %rax,@_$DATA+16
mov %rax,%rdx
mov @_$DATA+8,%rcx
push %rdx
push %rcx
.dllcall "gdi32.dll" "SelectObject"
add $56,%rsp

push %rbx
push %rbx
mov %rbx,%r9
mov $@T_paint,%r8
mov %ebx,%edx
mov %ebx,%ecx
push %r9
push %r8
push %rdx
push %rcx
.dllcall "kernel32.dll" "CreateThread"
add $48,%rsp

@MsgLoop
mov %rbx,%r9
mov %rbx,%r8
mov %ebx,%edx
mov %rsp,%rcx
push %r9
push %r8
push %rdx
push %rcx
.dllcall "user32.dll" "GetMessageA"
add $8,%rsp
cmp $0,%rax
jl @Err_Exit
lea 24(%rsp),%rcx
push %rcx
.dllcall "user32.dll" "TranslateMessage"
add $8,%rsp
lea 24(%rsp),%rcx
push %rcx
.dllcall "user32.dll" "DispatchMessageA"
add $32,%rsp

jmp @MsgLoop

@Err_Exit
mov %rbp,%rsp
pop %rbp
ret

.datasize 1084096
# 0 -- dc
# 8 -- memdc
# 16 -- bmp
# 24 -- paint
# 25 -- key
# 26 -- paint_init
# 32 -- current_clock
# 40 -- vectors
# 4096 -- pbuf
# 364096 -- zbuf