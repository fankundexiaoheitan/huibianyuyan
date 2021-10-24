;班级：B19222
;作者：赵雪坤
;名称：红绿灯
;所用晶振主频为12MHZ
ORG 	0000H

;**************初始化子程序************
START:
		;所有灯初始全灭
		ORL	P0,#0FFH
		ORL	P2,#0FH
;**************************************

;************主循环子程序**************
LOOP:
		;起始状态
		;南北方向亮绿灯，东西方向亮红灯，60S，其他灯全灭
		MOV		P0,#9EH
		MOV		P2,#0F7H
		LCALL	DELAY_60S
		;东西方向红灯亮，南北方向绿灯灭时黄灯闪烁一次，一次1秒
		MOV		P0,#5DH
		LCALL	DELAY_1S
		ORL		P0,#82H
		LCALL	DELAY_1S
		;然后南北红灯亮，同时东西方向绿灯亮60秒
		MOV		P0,#0F3H
		MOV		P2,#0FCH
		LCALL	DELAY_60S
		;南北方向红灯亮，东西方向绿灯灭时黄灯闪烁一次，一次1秒
		MOV		P0,#0EBH
		MOV		P2,#0FAH
		LCALL	DELAY_1S
		ORL		P0,#10H
		ORL		P2,#04H
		LCALL	DELAY_1S
		JMP LOOP
;**************************************

;*****************延时子程序***********
DELAY_1S:	;延时大约为1s子程序
			MOV		R0,#10		;10*100ms
D0:			MOV		R1,#200
D1:			MOV		R2,#248
			NOP
			DJNZ	R2,$
			DJNZ	R1,D1
			DJNZ	R0,D0
			RET

DELAY_60S:	;延时大约为60s子程序
			MOV		R3,#2	;60*1S
D2:			LCALL	DELAY_1S
			DJNZ	R3,D2
			RET
;**************************************

END

