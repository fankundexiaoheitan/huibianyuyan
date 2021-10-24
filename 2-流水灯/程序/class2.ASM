;本程序现象：
;开发板上的8个灯依次从左向右亮形成流水灯
ORG 0000H
MOV A,#01H
START:	;起始主程序循环
	  MOV P1,A
	  ACALL DELAY
	  RL A
	  AJMP START

DELAY:	;延时函数
	  MOV R0,#10 ;延时时间10*100ms
D0:	  MOV R1,#200
D1:	  MOV R2,#250
D3:	  DJNZ R2,D3
	  DJNZ R1,D1
	  DJNZ R0,D0
	  RET
END


