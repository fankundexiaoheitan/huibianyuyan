ORG		0000H
AJMP	START
ORG		0003H	;�ⲿ�ж�0��ַ���
AJMP	EXT_INT0

FLAG	BIT	00H	;����һ��λ����

;**********��ʼ���ӳ���************
START:
		MOV		A,#01H
		CLR		FLAG	;����
		SETB	IT0	;�����ⲿ�ж�0λ�½��ش�����ʽ
		SETB	EX0	;���ⲿ�ж�0
		SETB	EA	;�����ж�
		MOV		P1,A	;���ۼ���A�е�ֵ��ֵ��P1��
		ACALL	DELAY_1S	;������ʱ����
;**********************************

;***********ѭ��*****************
LOOP:
		JB		FLAG,L0
		JNB		FLAG,L1
I0:		MOV		P1,A	;���ۼ���A�е�ֵ��ֵ��P1��
		ACALL	DELAY_1S	;������ʱ����
		AJMP	LOOP	;ѭ��
;***************************************

L0:
		RR	A
		AJMP	I0
L1:
		RL	A
		AJMP	I0

;***************�ⲿ�ж�0�����ӳ���************
EXT_INT0:
		ACALL	DELAY_100MS	;������ʱ
		CPL		FLAG		;��FLAG����ȡ��
		RETI				;�жϷ��غ���
;**********************************************

;*****************��ʱ�ӳ���***********
DELAY_100MS:	;��ʱ��ԼΪ100ms�ӳ���
			MOV		R1,#200
D1:			MOV		R2,#248
			NOP
			DJNZ	R2,$
			DJNZ	R1,D1
			RET

DELAY_1S:	;��ʱ��ԼΪ1s�ӳ���
			MOV		R3,#10	;10*100MS
D2:			LCALL	DELAY_100MS
			DJNZ	R3,D2
			RET
;**************************************

END


