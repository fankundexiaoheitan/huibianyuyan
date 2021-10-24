ORG		0000H
AJMP	START
ORG		0003H	;外部中断0地址入口
AJMP	EXT_INT0

FLAG	BIT	00H	;定义一个位变量

;**********初始化子程序************
START:
		MOV		A,#01H
		CLR		FLAG	;清零
		SETB	IT0	;设置外部中断0位下降沿触发方式
		SETB	EX0	;打开外部中断0
		SETB	EA	;打开总中断
		MOV		P1,A	;将累加器A中的值赋值给P1口
		ACALL	DELAY_1S	;调用延时函数
;**********************************

;***********循环*****************
LOOP:
		JB		FLAG,L0
		JNB		FLAG,L1
I0:		MOV		P1,A	;将累加器A中的值赋值给P1口
		ACALL	DELAY_1S	;调用延时函数
		AJMP	LOOP	;循环
;***************************************

L0:
		RR	A
		AJMP	I0
L1:
		RL	A
		AJMP	I0

;***************外部中断0函数子程序************
EXT_INT0:
		ACALL	DELAY_100MS	;消抖延时
		CPL		FLAG		;对FLAG进行取反
		RETI				;中断返回函数
;**********************************************

;*****************延时子程序***********
DELAY_100MS:	;延时大约为100ms子程序
			MOV		R1,#200
D1:			MOV		R2,#248
			NOP
			DJNZ	R2,$
			DJNZ	R1,D1
			RET

DELAY_1S:	;延时大约为1s子程序
			MOV		R3,#10	;10*100MS
D2:			LCALL	DELAY_100MS
			DJNZ	R3,D2
			RET
;**************************************

END


