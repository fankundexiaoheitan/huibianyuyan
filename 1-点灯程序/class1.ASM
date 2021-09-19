;2021/9/19
;作者:小黑炭
;本程序现象
;前四个灯亮1秒左右灭掉后4个灯亮然后灭掉循环往复
;程序如下:
ORG 0000H
START:	;主循环程序
	  MOV P2,#0F0H
	  ACALL DELAY	;延时大概1s
	  MOV P2,#0FH
	  ACALL DELAY	;延时大概1s
	  AJMP START
DELAY:   ;延时程序  晶振为12M
	  MOV R0,#10	;延时约为10*100ms
D0:   MOV R1,#200
D1:	  MOV R2,#250
D3:   DJNZ R2,D3
      DJNZ R1,D1
	  DJNZ R0,D0
	  RET
END

