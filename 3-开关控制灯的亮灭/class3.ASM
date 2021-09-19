;2021/9/19
;作者；小黑炭
;程序现象：
;利用开关控制灯的亮灭
ORG 0000H
START:
	  MOV P2,#0FFH
	  MOV P3,#0FFH
KEY:	;按键控制程序
	  JNB P3.1,$
	  ACALL DELAY	;延时消抖
	  JB P3.1,$
	  CPL P2.0
	  AJMP KEY
DELAY:	;延时函数
	  MOV R0,#5	;延时大概5ms
D0:	  MOV R1,#2
D1:	  MOV R2,#250
D2:   DJNZ R2,D2
	  DJNZ R1,D1
	  DJNZ R0,D0
	  RET
END


