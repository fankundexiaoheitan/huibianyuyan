;2021/9/20
;作者：小黑炭
;程序现象：
;通过触发外部中断0（P3.2）正向改变流水灯的模式（0->2）达到最高模式后又回到初始0的模式
;通过触发外部中断1（P3.3）反向向改变流水灯的模式（2->0）达到最低模式后又回到初始0的模式
;其中外部中断0的优先级比外部中断1的优先级高
ORG	0000H
LED	EQU P2			;设LED的引脚为P2脚
AJMP	START		;跳转到开始的程序
ORG	0003H				;外部中断0起始地址
AJMP	EX_INT_0		;跳转到外部中断0
ORG	0013H				;外部中断1起始地址
AJMP	EX_INT_1		;跳转到外部中断1
;*****************主初始化程序***********
START:	;开始主程序
		;初始化
		MOV	IE,#85H	;打开外部中断0和外部中断1
		MOV	Tcon,#05H	;设置外部中断0和外部中断1的触发方式为负缘触发方式（下降沿触发方式）
		MOV	R0,#00H	;设置流水灯为模式0
		ACALL CHANGE_LED_MODEL ;设置流水灯的模式
;************************************

;************主循环程序**************
NEED0:	MOV	R5,#0FFH	;给R5赋值为-1
;主循环
LOOP:	CLR A	;对累加器A进行清零
		INC	R5	;R5进行自加1
		MOV A,R5;将R5中的数值赋值给累加器A
		MOVC A,@A+DPTR
		MOV LED,A
		ACALL DELAY
		CJNE R5,#03H,LOOP	;表示一个流水灯模式下有（3+1）种闪烁方式
		AJMP NEED0
;************************************

;**************选择当前流水灯的模式*********
CHANGE_LED_MODEL:
;各个模式进行判断选择
MODEL0:	CJNE	R0,#00H,MODEL1
		MOV		DPTR,#TAB0
		RET
MODEL1:	CJNE	R0,#01H,MODEL2
		MOV		DPTR,#TAB1
		RET
MODEL2:	CJNE	R0,#02H,MODEL3
		MOV		DPTR,#TAB2
		RET
;超出模式直接返回模式0
MODEL3:	
		MOV	R0,#00H
		AJMP	CHANGE_LED_MODEL		
;*******************************************

;**********外部中断程序*************
;外部中断0子程序
EX_INT_0:
	INC	R0	;对R0进行自加1
	ACALL	CHANGE_LED_MODEL	;改变为选择后的模式
	MOV	R5,#0FFH	;给R5赋值为-1
	RETI
;外部中断1子程序
EX_INT_1:
	DEC	R0	;对R0进行自减1
	ACALL	CHANGE_LED_MODEL	;改变为选择后的模式
	MOV	R5,#0FFH	;给R5赋值为-1
	RETI
;************************************

;*************延时程序****************
;延时10ms子程序
DELAY10MS:
	MOV	R2,#20
NEXT0:
	MOV	R3,#250
	DJNZ R3,$
	DJNZ R2,NEXT0
	RET
;延时500ms子程序
DELAY:
	MOV	R4,#50	;延时50*10ms
NEXT1:
	ACALL DELAY10MS
	DJNZ R4,NEXT1
	RET
;************************************

;*********流水灯模式的设置***********
;流水灯模式1
TAB0:	DB	0FCH,0F3H,0CFH,3FH
;流水灯模式2
TAB1:	DB	0FCH,3FH,0F3H,0CFH
;流水灯模式3
TAB2:	DB	3CH,0C3H,55H,0AAH
;************************************
END
	
	


