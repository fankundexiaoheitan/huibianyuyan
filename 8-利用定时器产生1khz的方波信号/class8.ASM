;2021/9/21
;作者：小黑炭
;程序现象：
;利用定时器1的工作方式1在P1.0引脚处产生1khz占空比为50%的方波信号
ORG	0000H
AJMP	MAIN
ORG	001BH	;T1的中断地址
AJMP	TIM1_INT	;定时器1的中断子程序

MAIN:
		MOV	TMOD,#10H	;定时器1的工作方式1	16位定时器   12MHZ晶振
		MOV	TH1,#0FEH
		MOV TL1,#0CH
		MOV	IE,#88H	;打开定时器1的中断
		SETB	TR1	;开启定时器1
		AJMP	$	;等待定时器1的响应
;定时器1的中断响应程序
TIM1_INT:
		MOV	TH1,#0FEH
		MOV TL1,#0CH
		CPL	P1.0	;对P1.0引脚进行取反
		RETI

END
