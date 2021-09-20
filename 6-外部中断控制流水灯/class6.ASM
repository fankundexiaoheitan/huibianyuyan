;2021/9/20
;作者：小黑炭
;程序现象：
;通过外部中断0下降沿中断，切换流水灯的模式
ORG	0000H
JMP	START
ORG 03H
JMP	INT_0
START:
	MOV	IE,#81H
	MOV SP,#30H	;设定堆栈地址
	SETB	IT0	;采用下降沿中断的方式
	MOV	A,#0
LOOP:
	MOV	P2,A	;输出到LED
	CALL	DELAY	;调用延时子程序
	CPL	A	;对A的内容进行取反
	JMP	LOOP	;跳转到LOOP形成一个循环
INT_0:	;中断子程序定义
	PUSH	ACC	;累加器入出栈时不能用简称A
	PUSH	PSW	;将程序状态控制字入栈
	SETB	RS0	;切换到RB1
	
	MOV		R0,#3	;设定三次循环
INT_LOOP0:
	MOV		A,#0FEH	;单灯左移初始值
	MOV		R1,#8	;设定八次左移
INT_LOOP1:
	MOV		P2,A	;输出LED到P2口
	CALL	DELAY	;调用延时子程序
	RL		A	;将A的内容左移
	DJNZ	R1,INT_LOOP1
	DJNZ	R0,INT_LOOP0
	POP		PSW
	POP		ACC		;累加器入出栈时不能用简称A
	RETI			;返加主程序
DELAY:	MOV	R7,#200
D1:		MOV	R6,#250
		DJNZ	R6,$
		DJNZ	R7,D1
		RET
END


