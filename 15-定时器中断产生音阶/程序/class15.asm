;班级：B19222
;姓名：赵雪坤
;功能介绍：
;利用单片机的进行音阶。
;本次使用晶振为12M

ORG 	0000H
AJMP 	START
ORG		0003H
AJMP	EXT0_INT
ORG		000BH
AJMP	TIME0_INT
ORG		001BH
AJMP	TIME1_INT

;********初始化程序*********
START:
	MOV		R0,#10		;10*50ms
	MOV		R1,#00H
	MOV		A,#00H
	MOV		TMOD,#11H	;使用定时器0和1为方式1	16位定时器
	
	;定时器1定时50ms
	MOV		TH1,#60
	MOV		TL1,#176
	
	;定时器0初值设置
	MOV 	TH0,#252						
	MOV		TL0,#68
						
	MOV		IE,#8BH		;打开总中断和定时器0和定时器1和外部中断0的中断
	SETB	IT0			;设置外部中断0触发方式为下降沿
	CLR 	TR0			;关闭定时器0
	CLR 	TR1			;关闭定时器1
	SJMP	$			;等待中断响应
;***************************

;*********外部中断0*******
EXT0_INT:
	SETB	TR1	;打开定时器1
	SETB	TR0	;打开定时器0
	RETI		;中断返回指令
;***************************

;*********定时器0中断*******
TIME0_INT:
	MOV		DPTR,#NEED_TH
	MOV		A,R1
	MOVC	A,@A+DPTR
	MOV 	TH0,A		;再次装载一次
	MOV		DPTR,#NEED_TL
	MOV		A,R1
	MOVC	A,@A+DPTR
	MOV		TL0,A
	CPL		P1.0	;对引脚P0.0进行取反
	RETI		;中断返回指令
;***************************

;*********定时器1中断*******
TIME1_INT:
	;定时器1定时50ms
	MOV		TH1,#60
	MOV		TL1,#176
	DJNZ	R0,D0
	MOV		R0,#10
	INC		R1
	CJNE	R1,#7,D0
	MOV		R1,#00H
	CLR 	TR0			;关闭定时器0
	CLR 	TR1			;关闭定时器1
D0:	RETI		;中断返回指令
;***************************

NEED_TH:	DB	252,252,253,253,253,253,254
NEED_TL:	DB	68,172,9,52,130,200,6


END
