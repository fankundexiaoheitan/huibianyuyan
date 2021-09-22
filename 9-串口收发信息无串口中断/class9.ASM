;2021/9/22
;作者：小黑炭
;程序现象：
;单片机使用的外部晶振为11.0592M，程序波特率为9600
;没有使用串口的中断，可以将接收到的1字节（8位）的数据返回到串口助手上显示出来
ORG	0000H
JMP	MAIN

MAIN:
	MOV	TMOD,#20H	;定时器1工作方式2
	MOV	TH1,#0FDH	;设置波特率为9600
	MOV	TL1,#0FDH
	MOV	SCON,#50H	;使用串口方式1使能接收
	MOV	PCON,#00H	;波特率不加倍
	MOV	Tcon,#40H	;启动定时器1
LOOP:
	JNB	RI,$	;等待接收到信息
	MOV	A,SBUF	;接收到信息
	MOV	SBUF,A	;发送接收到的信息
	JNB	TI,$	;等待发送成功
	CLR	TI		;软件清零发送标志位
	CLR	RI		;软件清零接收标志位
	JMP	LOOP
END


