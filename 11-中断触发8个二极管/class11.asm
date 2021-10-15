ORG		0000H
LJMP	START
ORG		0003H	;外部中断0的起始地址
LJMP	INT_0

;***********起始初始化程序*************
START:
		MOV		A,#01H		;第一个灯亮
		MOV		IE,#81H		;打开总中断和外部中断0
		MOV		Tcon,#00H	;将外部中断0的触发方式设为低电平触发，并消除外部中断0的标志位
;**************************************

;**************主循环程序**************
LOOP:
		MOV		P1,A	;将累加器中的值赋值给P1
		ACALL	DELAY	;延时0.5S
		RL		A		;累加器循环左移
		LJMP	LOOP	;继续循环
;**************************************

;**********延时函数子程序**************
DELAY:
		MOV		R0,#5	;延时大约为5*100ms
D0:		MOV		R1,#200	
D1:		MOV		R2,#250
		DJNZ	R2,$
		DJNZ	R1,D1
		DJNZ	R0,D0
		RET
;**************************************

;****************外部中断0子程序***********
INT_0:
		MOV		P1,#0FFH
		RETI				;中断返回指令
;******************************************


END


