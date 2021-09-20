;2021/9/19
;作者：小黑炭
;程序现象：
;从右往左8个灯每隔1s左右亮一个直到全部亮起
;然后从左往右每隔1s左右灭一个知道全灭循环往复
ORG 0000H
AJMP MAIN
MAIN:
	  MOV	R0,#0FFH	;(R0)<-0FFH即-1
	  MOV	R2,#16	;总共有16个数据
	  MOV	DPTR,#TAB
LOOP:
	  INC	R0
	  MOV	A,R0
	  MOVC	A,@A+DPTR
SHOW:
	  MOV 	P2,A
	  LCALL DELAY
	  DJNZ	R2,LOOP
	  AJMP	MAIN
DELAY:	;延时子程序
	  MOV	R3,#10	;延时约为10*100ms
D0:	  MOV	R6,#200
D1:	  MOV	R7,#250
	  DJNZ	R7,$
	  DJNZ 	R6,D1
	  DJNZ	R3,D0
	  RET
TAB:	;查表方式
	DB	0FEH
	DB	0FCH
	DB	0F8H
	DB	0F0H
	DB	0E0H
	DB	0C0H
	DB	80H
	DB	00H
	DB	80H
	DB	0C0H
	DB	0E0H
	DB	0F0H
	DB	0F8H
	DB	0FCH
	DB	0FEH
	DB	0FFH
END



