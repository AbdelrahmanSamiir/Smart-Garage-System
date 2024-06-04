
_servoRotate0:

;MyProject.c,20 :: 		void servoRotate0()
;MyProject.c,23 :: 		for(i=0;i<50;i++)
	CLRF       R1+0
	CLRF       R1+1
L_servoRotate00:
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__servoRotate042
	MOVLW      50
	SUBWF      R1+0, 0
L__servoRotate042:
	BTFSC      STATUS+0, 0
	GOTO       L_servoRotate01
;MyProject.c,25 :: 		PORTC.B2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,26 :: 		Delay_us(1000);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_servoRotate03:
	DECFSZ     R13+0, 1
	GOTO       L_servoRotate03
	DECFSZ     R12+0, 1
	GOTO       L_servoRotate03
;MyProject.c,27 :: 		PORTC.B2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,23 :: 		for(i=0;i<50;i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProject.c,28 :: 		}
	GOTO       L_servoRotate00
L_servoRotate01:
;MyProject.c,29 :: 		}
L_end_servoRotate0:
	RETURN
; end of _servoRotate0

_servoRotate90:

;MyProject.c,31 :: 		void servoRotate90()
;MyProject.c,34 :: 		for(i=0;i<50;i++)
	CLRF       R1+0
	CLRF       R1+1
L_servoRotate904:
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__servoRotate9044
	MOVLW      50
	SUBWF      R1+0, 0
L__servoRotate9044:
	BTFSC      STATUS+0, 0
	GOTO       L_servoRotate905
;MyProject.c,36 :: 		PORTC.B2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,37 :: 		Delay_us(1500);
	MOVLW      10
	MOVWF      R12+0
	MOVLW      188
	MOVWF      R13+0
L_servoRotate907:
	DECFSZ     R13+0, 1
	GOTO       L_servoRotate907
	DECFSZ     R12+0, 1
	GOTO       L_servoRotate907
	NOP
;MyProject.c,38 :: 		PORTC.B2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,34 :: 		for(i=0;i<50;i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProject.c,39 :: 		}
	GOTO       L_servoRotate904
L_servoRotate905:
;MyProject.c,40 :: 		}
L_end_servoRotate90:
	RETURN
; end of _servoRotate90

_servoRotate180:

;MyProject.c,42 :: 		void servoRotate180()
;MyProject.c,45 :: 		for(i=0;i<50;i++)
	CLRF       R1+0
	CLRF       R1+1
L_servoRotate1808:
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__servoRotate18046
	MOVLW      50
	SUBWF      R1+0, 0
L__servoRotate18046:
	BTFSC      STATUS+0, 0
	GOTO       L_servoRotate1809
;MyProject.c,47 :: 		PORTC.B2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,48 :: 		Delay_us(2200);
	MOVLW      15
	MOVWF      R12+0
	MOVLW      71
	MOVWF      R13+0
L_servoRotate18011:
	DECFSZ     R13+0, 1
	GOTO       L_servoRotate18011
	DECFSZ     R12+0, 1
	GOTO       L_servoRotate18011
	NOP
	NOP
;MyProject.c,49 :: 		PORTC.B2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,45 :: 		for(i=0;i<50;i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;MyProject.c,50 :: 		}
	GOTO       L_servoRotate1808
L_servoRotate1809:
;MyProject.c,51 :: 		}
L_end_servoRotate180:
	RETURN
; end of _servoRotate180

_main:

;MyProject.c,56 :: 		void main() {
;MyProject.c,63 :: 		unsigned short ir_status = 0;
	CLRF       main_ir_status_L0+0
	CLRF       main_ir_prev_status_L0+0
	CLRF       main_ir_status2_L0+0
	CLRF       main_ir_prev_status2_L0+0
;MyProject.c,68 :: 		ADCON1 = 0x80;               // Configure analog inputs and Vref
	MOVLW      128
	MOVWF      ADCON1+0
;MyProject.c,69 :: 		Lcd_Init();                  // Initialize LCD
	CALL       _Lcd_Init+0
;MyProject.c,70 :: 		Lcd_Cmd(_LCD_CLEAR);         // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,71 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);    // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,73 :: 		TRISD.B0 = 1;                // Set RB0 & RB2 as input for IR sensor
	BSF        TRISD+0, 0
;MyProject.c,74 :: 		TRISD.B2 = 1;
	BSF        TRISD+0, 2
;MyProject.c,76 :: 		TRISA.B0 = 1;                //// Set RA0 as input from LDR
	BSF        TRISA+0, 0
;MyProject.c,77 :: 		TRISA.B1 = 0;                // Set RA1 as output for LDR control
	BCF        TRISA+0, 1
;MyProject.c,79 :: 		TRISA.B2 = 1;                // Set RA2 as input from LM35
	BSF        TRISA+0, 2
;MyProject.c,80 :: 		TRISD.B7 = 0;                // Set RD7 as output for LM35 control
	BCF        TRISD+0, 7
;MyProject.c,83 :: 		TRISC = 0;                  // Set PortC as output for the motor
	CLRF       TRISC+0
;MyProject.c,85 :: 		servoRotate0();             // Set Servo initially
	CALL       _servoRotate0+0
;MyProject.c,89 :: 		while (1) {
L_main12:
;MyProject.c,91 :: 		digitalVoltage = ADC_Read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;MyProject.c,92 :: 		analogVoltage = digitalVoltage / 1023.0 * 5;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
;MyProject.c,93 :: 		temprature = analogVoltage * 100.0;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      main_temprature_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temprature_L0+1
;MyProject.c,94 :: 		if (temprature > 60) {
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVF       R0+0, 0
	SUBLW      60
L__main48:
	BTFSC      STATUS+0, 0
	GOTO       L_main14
;MyProject.c,95 :: 		Lcd_Out(1, 1, "Warning!!!!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,96 :: 		Lcd_Out(2, 1, "Please evacuate");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,97 :: 		PORTD.B7 = 1;
	BSF        PORTD+0, 7
;MyProject.c,98 :: 		}
	GOTO       L_main15
L_main14:
;MyProject.c,101 :: 		PORTD.B7 = 0;
	BCF        PORTD+0, 7
;MyProject.c,103 :: 		adc_value = ADC_Read(0); // Read from channel 0 (AN0)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;MyProject.c,104 :: 		if (adc_value < 512) {   // Assuming 512 as the threshold for light detection
	MOVLW      2
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      0
	SUBWF      R0+0, 0
L__main49:
	BTFSC      STATUS+0, 0
	GOTO       L_main16
;MyProject.c,105 :: 		Lcd_Out(1, 1, "Morning         ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,106 :: 		PORTA.B1 = 0;
	BCF        PORTA+0, 1
;MyProject.c,107 :: 		}
	GOTO       L_main17
L_main16:
;MyProject.c,109 :: 		Lcd_Out(1, 1, "Night           ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,110 :: 		PORTA.B1 = 1;
	BSF        PORTA+0, 1
;MyProject.c,111 :: 		}
L_main17:
;MyProject.c,112 :: 		}
L_main15:
;MyProject.c,115 :: 		ir_status = PORTD.B0;
	MOVLW      0
	BTFSC      PORTD+0, 0
	MOVLW      1
	MOVWF      main_ir_status_L0+0
;MyProject.c,117 :: 		if (ir_status == 1 && ir_prev_status == 0) {
	MOVF       main_ir_status_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main20
	MOVF       main_ir_prev_status_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main20
L__main40:
;MyProject.c,118 :: 		if (Avilable_places > 0) {
	MOVF       _Avilable_places+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVF       _Avilable_places+0, 0
	SUBLW      0
L__main50:
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;MyProject.c,119 :: 		Avilable_places--;   // Decrement available places
	MOVLW      1
	SUBWF      _Avilable_places+0, 1
	BTFSS      STATUS+0, 0
	DECF       _Avilable_places+1, 1
;MyProject.c,120 :: 		servoRotate90();
	CALL       _servoRotate90+0
;MyProject.c,121 :: 		}
L_main21:
;MyProject.c,122 :: 		}
L_main20:
;MyProject.c,124 :: 		ir_prev_status = ir_status;
	MOVF       main_ir_status_L0+0, 0
	MOVWF      main_ir_prev_status_L0+0
;MyProject.c,126 :: 		ir_status2 = PORTD.B2;
	MOVLW      0
	BTFSC      PORTD+0, 2
	MOVLW      1
	MOVWF      main_ir_status2_L0+0
;MyProject.c,128 :: 		if (ir_status2 == 1 && ir_prev_status2 == 0) {
	MOVF       main_ir_status2_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main24
	MOVF       main_ir_prev_status2_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main24
L__main39:
;MyProject.c,129 :: 		if (Avilable_places < 3)
	MOVLW      0
	SUBWF      _Avilable_places+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      3
	SUBWF      _Avilable_places+0, 0
L__main51:
	BTFSC      STATUS+0, 0
	GOTO       L_main25
;MyProject.c,131 :: 		Avilable_places++;   // Decrement available places
	INCF       _Avilable_places+0, 1
	BTFSC      STATUS+0, 2
	INCF       _Avilable_places+1, 1
;MyProject.c,132 :: 		servoRotate90();
	CALL       _servoRotate90+0
;MyProject.c,133 :: 		}
L_main25:
;MyProject.c,134 :: 		}
L_main24:
;MyProject.c,136 :: 		ir_prev_status2 = ir_status2;
	MOVF       main_ir_status2_L0+0, 0
	MOVWF      main_ir_prev_status2_L0+0
;MyProject.c,139 :: 		if (ir_status == 0 && ir_status2 == 0)
	MOVF       main_ir_status_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main28
	MOVF       main_ir_status2_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main28
L__main38:
;MyProject.c,141 :: 		servoRotate0();
	CALL       _servoRotate0+0
;MyProject.c,142 :: 		}
L_main28:
;MyProject.c,144 :: 		if (temprature <= 60 && Avilable_places > 0)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_temprature_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       main_temprature_L0+0, 0
	SUBLW      60
L__main52:
	BTFSS      STATUS+0, 0
	GOTO       L_main31
	MOVF       _Avilable_places+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVF       _Avilable_places+0, 0
	SUBLW      0
L__main53:
	BTFSC      STATUS+0, 0
	GOTO       L_main31
L__main37:
;MyProject.c,146 :: 		sprinti(text, "Available: %u   ", Avilable_places);
	MOVLW      main_text_L0+0
	MOVWF      FARG_sprinti_wh+0
	MOVLW      ?lstr_5_MyProject+0
	MOVWF      FARG_sprinti_f+0
	MOVLW      hi_addr(?lstr_5_MyProject+0)
	MOVWF      FARG_sprinti_f+1
	MOVF       _Avilable_places+0, 0
	MOVWF      FARG_sprinti_wh+3
	MOVF       _Avilable_places+1, 0
	MOVWF      FARG_sprinti_wh+4
	CALL       _sprinti+0
;MyProject.c,147 :: 		Lcd_Out(2, 1, text);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_text_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,148 :: 		}
L_main31:
;MyProject.c,150 :: 		if (Avilable_places == 0 && temprature <= 60)
	MOVLW      0
	XORWF      _Avilable_places+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVLW      0
	XORWF      _Avilable_places+0, 0
L__main54:
	BTFSS      STATUS+0, 2
	GOTO       L_main34
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_temprature_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVF       main_temprature_L0+0, 0
	SUBLW      60
L__main55:
	BTFSS      STATUS+0, 0
	GOTO       L_main34
L__main36:
;MyProject.c,152 :: 		Lcd_Out(2, 1, "No places left");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,153 :: 		}
L_main34:
;MyProject.c,156 :: 		Delay_ms(200);           // Small delay to avoid flickering
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
;MyProject.c,157 :: 		}
	GOTO       L_main12
;MyProject.c,158 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
