;�༶��B19222
;��������ѩ��
;���ܽ��ܣ�
;���õ�Ƭ���Ľ������ס�
;����ʹ�þ���Ϊ12M

ORG 	0000H
AJMP 	START
ORG		0003H
AJMP	EXT0_INT
ORG		000BH
AJMP	TIME0_INT
ORG		001BH
AJMP	TIME1_INT

;********��ʼ������*********
START:
	MOV		R0,#10		;10*50ms
	MOV		R1,#00H
	MOV		A,#00H
	MOV		TMOD,#11H	;ʹ�ö�ʱ��0��1Ϊ��ʽ1	16λ��ʱ��
	
	;��ʱ��1��ʱ50ms
	MOV		TH1,#60
	MOV		TL1,#176
	
	;��ʱ��0��ֵ����
	MOV 	TH0,#252						
	MOV		TL0,#68
						
	MOV		IE,#8BH		;�����жϺͶ�ʱ��0�Ͷ�ʱ��1���ⲿ�ж�0���ж�
	SETB	IT0			;�����ⲿ�ж�0������ʽΪ�½���
	CLR 	TR0			;�رն�ʱ��0
	CLR 	TR1			;�رն�ʱ��1
	SJMP	$			;�ȴ��ж���Ӧ
;***************************

;*********�ⲿ�ж�0*******
EXT0_INT:
	SETB	TR1	;�򿪶�ʱ��1
	SETB	TR0	;�򿪶�ʱ��0
	RETI		;�жϷ���ָ��
;***************************

;*********��ʱ��0�ж�*******
TIME0_INT:
	MOV		DPTR,#NEED_TH
	MOV		A,R1
	MOVC	A,@A+DPTR
	MOV 	TH0,A		;�ٴ�װ��һ��
	MOV		DPTR,#NEED_TL
	MOV		A,R1
	MOVC	A,@A+DPTR
	MOV		TL0,A
	CPL		P1.0	;������P0.0����ȡ��
	RETI		;�жϷ���ָ��
;***************************

;*********��ʱ��1�ж�*******
TIME1_INT:
	;��ʱ��1��ʱ50ms
	MOV		TH1,#60
	MOV		TL1,#176
	DJNZ	R0,D0
	MOV		R0,#10
	INC		R1
	CJNE	R1,#7,D0
	MOV		R1,#00H
	CLR 	TR0			;�رն�ʱ��0
	CLR 	TR1			;�رն�ʱ��1
D0:	RETI		;�жϷ���ָ��
;***************************

NEED_TH:	DB	252,252,253,253,253,253,254
NEED_TL:	DB	68,172,9,52,130,200,6


END
