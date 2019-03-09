led_nl1 bit p2.7
led_nl2 bit p2.4
led_nl3 bit p2.1
led_rd1s1 bit p2.0
led_rd2s1 bit p2.2
led_rd1s2 bit p2.3
led_rd2s2 bit p2.5
led_rd1s3 bit p2.6
led_rd2s3 bit p3.0
ip_ldr bit p1.0
ip_ir1 bit p1.1
ip_ir2 bit p1.2
ip_ir3 bit p1.3
cont1 equ 25h
cont2 equ 26h
cont3 equ 27h
cont4 equ 28h
org 0000h
ljmp main
org 0003h
reti
org 000bh
reti
org 0013h
reti
org 001bh
ljmp TIMER_1
reti
org 0023h
reti
TIMER_1:
clr tr1
mov tl1,#0b2h
mov th1,#03ah
mov a,cont1
inc a
cjne a,#20d,TIMER_NXT3
mov a,cont2
jz TIMER_NXT1
mov cont2,a
cjne a,#0d,TIMER_NXT1
TIMER_NXT1:
mov a,cont3
jz TIMER_NXT2
mov cont3,a
cjne a,#0d,TIMER_NXT2
setb led_rd1s2
setb led_rd2s2
TIMER_NXT2:
mov a,cont4
jz TIMER_NXT3
mov cont4,a
cjne a,#0d,TIMER_NXT3
setb led_rd1s3
setb led_rd2s3
TIMER_NXT3:
setb tr1
reti
main:
mov psw,#00h
mov sp,#70h
mov p0,#0ffh
mov p1,#0ffh
mov p2,#0ffh
mov p3,#0ffh
mov tmod,#10h
mov tcon,#00h
mov scon,#00h
mov tl1,#0b2h
mov th1,#03ah
mov ie,#88h
mov ip,#00h
setb led_nl1
setb led_nl2
setb led_nl3
setb led_rd1s1
setb led_rd2s1
setb led_rd1s2
setb led_rd2s2
setb led_rd1s3
setb led_rd2s3
mov cont1,#00h
mov cont2,#00h
mov cont3,#00h
mov cont4,#00h
setb tr1
main_lp:
jnb ip_ldr,nxt4
clr led_nl1
clr led_nl2
clr led_nl3
nxt1:
jb ip_ir1,nxt2
clr led_rd1s1
clr led_rd2s1
mov cont2,#05h
nxt2:
jb ip_ir2,nxt3
clr led_rd1s2
clr led_rd2s2
mov cont3,#05h
nxt3:
jb ip_ir3,nxt4
clr led_rd1s3
clr led_rd2s3
mov cont4,#02h
nxt4:
jnb ip_ldr,nxt5
setb led_nl1
setb led_nl2
setb led_nl3
setb led_rd1s1
setb led_rd2s1
setb led_rd1s2
setb led_rd2s2
setb led_rd1s3
setb led_rd2s3
nxt5:
ljmp main_lp
end
