;2021/9/19
;作者：小黑炭
;程序现象
;刚开始P2.0/P2.1/P2.2/P2.3四个灯全亮
;当按下P3.0/P3.1/P3.2/P3.3按键时对应的灭掉
;松开按键时对应的灯又亮起来
ORG 0000H
START:
	  SETB P3.0
	  SETB P3.1
	  SETB P3.2
	  SETB P3.3
	  JB   P3.0,LIG0
	  SETB P2.0
	  SJMP next1
LIG0: CLR P2.0
next1: JB P3.1,LIG1
	   SETB P2.1
	   SJMP next2
LIG1: CLR P2.1
next2: JB P3.2,LIG2
	   SETB P2.2
	   SJMP next3
LIG2: CLR P2.2
next3: JB P3.3,LIG3
	   SETB P2.3
	   SJMP START
LIG3: CLR P2.3
	  SJMP START
END


