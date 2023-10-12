;;;;;;; ASEN 5067 Lab 4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Author:	    Thomas Dunnington
; Date:		    October 16, 2023
; Target:	    PIC18F87K22
; 	    
; REFERENCES:	    Ruben Hinojosa Torres, Lara Lufkin
;		Using as reference also: main.s by Dan1138
;		lab3_orig.asm by Scott Palo, Doug Weibel, Gabe LoDolce and Trudy Schwartz
; Date (Original):  2021-06-5
; 	    
; Compiler: pic-as(v2.32)
; IDE:      MPLABX v5.50
			      
			      
; !!!!!!!!!!!!!!!IMPORTANT!!!!!!!! 
; Compiler Notes: 
; Add this line to the Compiler flags i.e
;   Right click on project name -> Properties -> pic-as Global Options -> 
;   Additional options: 
;    -Wl,-presetVec=0h,-pHiPriISR_Vec=0008h,-pLoPriISR_Vec=0018h
			      
; Description: 
			      
;;;;;;;;;;;;;;;;;;;;;;;;;;;; Program hierarchy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Mainline
; Loop
; Initial 	- 	Initialize ports and perform LED sequence
			      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Hardware notes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

// <editor-fold defaultstate="collapsed" desc="Pin Mapping">
/*
    Pin | Pin Name/Register Name
     1  | RH2/AN21/A18
     2  | RH3/AN20/A19
     3  | RE1/P2C/WR/AD9
     4  | RE0/P2D/RD/AD8
     5  | RG0/ECCP3/P3A
     6  | RG1/TX2/CK2/AN19/C3OUT
     7  | RG2/RX2/DT2/AN18/C3INA
     8  | RG3/CCP4/AN17/P3D/C3INB
     9  | MCLR/RG5
     10 | RG4/RTCC/T7CKI(Note:2)/T5G/CCP5/AN16/P1D/C3INC
     11 | VSS
     12 | VDDCORE/VCAP
     13 | RF7/AN5/SS1
     14 | RF6/AN11/C1INA
     15 | RF5/AN10/C1INB
     16 | RF4/AN9/C2INA
     17 | RF3/AN8/C2INB/CTMUI
     18 | RF2/AN7/C1OUT
     19 | RH7/CCP6(Note:3)/P1B/AN15
     20 | RH6/CCP7(Note:3)/P1C/AN14/C1INC
     21 | RH5/CCP8(Note:3)/P3B/AN13/C2IND
     22 | RH4/CCP9(Note:2,3)/P3C/AN12/C2INC
     23 | RF1/AN6/C2OUT/CTDIN
     24 | ENVREG
     25 | AVDD
     26 | AVSS
     27 | RA3/AN3/VREF+
     28 | RA2/AN2/VREF-
     29 | RA1/AN1
     30 | RA0/AN0/ULPWU
     31 | VSS
     32 | VDD
     33 | RA5/AN4/T1CKI/T3G/HLVDIN
     34 | RA4/T0CKI
     35 | RC1/SOSC/ECCP2/P2A
     36 | RC0/SOSCO/SCKLI
     37 | RC6/TX1/CK1
     38 | RC7/RX1/DT1
     39 | RJ4/BA0
     40 | RJ5/CE
     41 | RJ6/LB
     42 | RJ7/UB
     43 | RC2/ECCP1/P1A
     44 | RC3/SCK1/SCL1
     45 | RC4/SDI1/SDA1
     46 | RC5/SDO1
     47 | RB7/KBI3/PGD
     48 | VDD
     49 | OSC1/CLKI/RA7
     50 | OSC2/CLKO/RA6
     51 | VSS
     52 | RB6/KBI2/PGC
     53 | RB5/KBI1/T3CKI/T1G
     54 | RB4/KBI0
     55 | RB3/INT3/CTED2/ECCP2(Note:1)/P2A
     56 | RB2/INT2/CTED1
     57 | RB1/INT1
     58 | RB0/INT0/FLT0
     59 | RJ3/WRH
     60 | RJ2/WRL
     61 | RJ1/OE
     62 | RJ0/ALE
     63 | RD7/SS2/PSP7/AD7
     64 | RD6/SCK2/SCL2/PSP6/AD6
     65 | RD5/SDI2/SDA2/PSP5/AD5
     66 | RD4/SDO2/PSP4/AD4
     67 | RD3/PSP3/AD3
     68 | RD2/PSP2/AD2
     69 | RD1/T5CKI/T7G/PSP1/AD1
     70 | VSS
     71 | VDD
     72 | RD0/PSP0/CTPLS/AD0
     73 | RE7/ECCP2/P2A/AD15
     74 | RE6/P1B/CCP6(Note:3)/AD14
     75 | RE5/P1C/CCP7(Note:3)/AD13
     76 | RE4/P3B/CCP8(Note:3)/AD12
     77 | RE3/P3C/CCP9(Note:2,3)/REF0/AD11
     78 | RE2/P2B/CCP10(Note:2)/CS/AD10
     79 | RH0/AN23/A16
     80 | RH1/AN22/A17

Note (1) The ECCP2 pin placement depends on the CCP2MX Configuration bit 
	setting and whether the device is in Microcontroller or Extended 
	Microcontroller mode.
     (2) Not available on the PIC18F65K22 and PIC18F85K22 devices.
     (3) The CC6, CCP7, CCP8 and CCP9 pin placement depends on the 
	setting of the ECCPMX Configuration bit (CONFIG3H<1>).
*/
// </editor-fold>

;;;;;;;;;;;;;;;;;;;;;;;;;; Assembler Directives ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
// <editor-fold defaultstate="collapsed" desc="Assembler Directives"> 			     
; Processor Definition
PROCESSOR   18F87K22
; Radix Definition 
RADIX	DEC
; List Definition
;   C: Set the page (i.e., Column) width
;   N: Set the page length
;   X: Turn MACRO expansion on or off
; LIST	C = 160, N = 0, X = OFF
; Include File:
#include <xc.inc>
// </editor-fold>			      

; PIC18F87K22 Configuration Bit Settings
// <editor-fold defaultstate="collapsed" desc="CONFIG Definitions">
; CONFIG1L
CONFIG  RETEN = ON            ; VREG Sleep Enable bit (Enabled)
CONFIG  INTOSCSEL = HIGH      ; LF-INTOSC Low-power Enable bit (LF-INTOSC in 
                              ;	    High-power mode during Sleep)
CONFIG  SOSCSEL = HIGH        ; SOSC Power Selection and mode Configuration bits 
			      ;	    (High Power SOSC circuit selected)
CONFIG  XINST = OFF           ; Extended Instruction Set (Disabled)

; CONFIG1H
CONFIG  FOSC = HS1            ; Oscillator (HS oscillator 
			      ;	    (Medium power, 4 MHz - 16 MHz))
CONFIG  PLLCFG = OFF          ; PLL x4 Enable bit (Disabled)
CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor (Disabled)
CONFIG  IESO = OFF            ; Internal External Oscillator Switch Over Mode 
			      ;	    (Disabled)

; CONFIG2L
CONFIG  PWRTEN = ON           ; Power Up Timer (Enabled)
CONFIG  BOREN = ON            ; Brown Out Detect (Controlled with SBOREN bit)
CONFIG  BORV = 1              ; Brown-out Reset Voltage bits (2.7V)
CONFIG  BORPWR = ZPBORMV      ; BORMV Power level (ZPBORMV instead of BORMV 
			      ;	    is selected)

; CONFIG2H
CONFIG  WDTEN = OFF           ; Watchdog Timer (WDT disabled in hardware; 
			      ;	    SWDTEN bit disabled)
CONFIG  WDTPS = 1048576       ; Watchdog Postscaler (1:1048576)

; CONFIG3L
CONFIG  RTCOSC = SOSCREF      ; RTCC Clock Select (RTCC uses SOSC)
CONFIG  EASHFT = ON           ; External Address Shift bit (Address Shifting 
			      ;	    enabled)
CONFIG  ABW = MM              ; Address Bus Width Select bits (8-bit 
			      ;	    address bus)
CONFIG  BW = 16               ; Data Bus Width (16-bit external bus mode)
CONFIG  WAIT = OFF            ; External Bus Wait (Disabled)

; CONFIG3H
CONFIG  CCP2MX = PORTC        ; CCP2 Mux (RC1)
CONFIG  ECCPMX = PORTE        ; ECCP Mux (Enhanced CCP1/3 [P1B/P1C/P3B/P3C] 
			      ;	    muxed with RE6/RE5/RE4/RE3)
; CONFIG  MSSPMSK = MSK7        ; MSSP address masking (7 Bit address masking 
			      ;	    mode)
CONFIG  MCLRE = ON            ; Master Clear Enable (MCLR Enabled, RG5 Disabled)

; CONFIG4L
CONFIG  STVREN = ON           ; Stack Overflow Reset (Enabled)
CONFIG  BBSIZ = BB2K          ; Boot Block Size (2K word Boot Block size)

; CONFIG5L
CONFIG  CP0 = OFF             ; Code Protect 00800-03FFF (Disabled)
CONFIG  CP1 = OFF             ; Code Protect 04000-07FFF (Disabled)
CONFIG  CP2 = OFF             ; Code Protect 08000-0BFFF (Disabled)
CONFIG  CP3 = OFF             ; Code Protect 0C000-0FFFF (Disabled)
CONFIG  CP4 = OFF             ; Code Protect 10000-13FFF (Disabled)
CONFIG  CP5 = OFF             ; Code Protect 14000-17FFF (Disabled)
CONFIG  CP6 = OFF             ; Code Protect 18000-1BFFF (Disabled)
CONFIG  CP7 = OFF             ; Code Protect 1C000-1FFFF (Disabled)

; CONFIG5H
CONFIG  CPB = OFF             ; Code Protect Boot (Disabled)
CONFIG  CPD = OFF             ; Data EE Read Protect (Disabled)

; CONFIG6L
CONFIG  WRT0 = OFF            ; Table Write Protect 00800-03FFF (Disabled)
CONFIG  WRT1 = OFF            ; Table Write Protect 04000-07FFF (Disabled)
CONFIG  WRT2 = OFF            ; Table Write Protect 08000-0BFFF (Disabled)
CONFIG  WRT3 = OFF            ; Table Write Protect 0C000-0FFFF (Disabled)
CONFIG  WRT4 = OFF            ; Table Write Protect 10000-13FFF (Disabled)
CONFIG  WRT5 = OFF            ; Table Write Protect 14000-17FFF (Disabled)
CONFIG  WRT6 = OFF            ; Table Write Protect 18000-1BFFF (Disabled)
CONFIG  WRT7 = OFF            ; Table Write Protect 1C000-1FFFF (Disabled)

; CONFIG6H
CONFIG  WRTC = OFF            ; Config. Write Protect (Disabled)
CONFIG  WRTB = OFF            ; Table Write Protect Boot (Disabled)
CONFIG  WRTD = OFF            ; Data EE Write Protect (Disabled)

; CONFIG7L
CONFIG  EBRT0 = OFF           ; Table Read Protect 00800-03FFF (Disabled)
CONFIG  EBRT1 = OFF           ; Table Read Protect 04000-07FFF (Disabled)
CONFIG  EBRT2 = OFF           ; Table Read Protect 08000-0BFFF (Disabled)
CONFIG  EBRT3 = OFF           ; Table Read Protect 0C000-0FFFF (Disabled)
CONFIG  EBRT4 = OFF           ; Table Read Protect 10000-13FFF (Disabled)
CONFIG  EBRT5 = OFF           ; Table Read Protect 14000-17FFF (Disabled)
CONFIG  EBRT6 = OFF           ; Table Read Protect 18000-1BFFF (Disabled)
CONFIG  EBRT7 = OFF           ; Table Read Protect 1C000-1FFFF (Disabled)

; CONFIG7H
CONFIG  EBRTB = OFF           ; Table Read Protect Boot (Disabled)
// </editor-fold>

;;;;;;;;;;;;;;;;;;;;;;;;; MACRO Definitions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
// <editor-fold defaultstate="collapsed" desc="MACRO Definitions">			 
; MACRO Definitions:

; MOVLF
; Description:
;   Move literal value to given register. 
; Input: 
;   lit: literal value
;   dest: destination 
;   access: Access bank or not. Possible values are 'a' for access bank or
;	'b' for banked memory.
  MOVLF	    MACRO   lit, dest, access
    MOVLW   lit	    ; Move literal into WREG
    BANKSEL	(dest)	; Select Bank for next file instruction
    MOVWF   BANKMASK(dest), access  ; Move WREG into destination file
  ENDM
  
;; POINT adapted from Reference: Peatman CH 7 LCD
;POINT
; Description:
;   Loads strings into table pointer. 
; Input: 
;   stringname: name of the variable containg the desired string.
  POINT	    MACRO stringname
    MOVLF high stringname, TBLPTRH, A 
    MOVLF low stringname, TBLPTRL, A
  ENDM
  
;DISPLAY
; Description:
;   Displays a given register in binary on the LCD. 
; Input: 
;   register: The register that is to be displayed on the LCD. 
  DISPLAY   MACRO register
    MOVFF register, BYTE 
    CALL ByteDisplay
  ENDM
  // </editor-fold>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Project Sections;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
// <editor-fold defaultstate="collapsed" desc="Project Sections">
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Objects to be defined in Access Bank for Variables.
; Examples:
PSECT	udata_acs
CNT:	DS  1	; Reserve 1 byte for CNT in access bank at 0x000 (literal or file location)
VAL1:   DS  1   ; Reserve 1 byte for VAL1 in access bank at 0x001 (literal or file location)
switch1: DS  1	; 1 byte for the previous state of the button press
switchCount: DS	1 ; Variable for tracking the button press
pwmHigh: DS 1   ; High byte for the pwm
pwmLow: DS  1	; Low byte for the pwm
    
    
; Objects to be defined in Bank 1
PSECT	udata_bank1
; not used

;;;;;;;;;;;;;;;;;;;;;; Power-On-Reset entry point ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PSECT	resetVec, class = CODE, reloc = 2
resetVec:
    NOP	    ; No Operation, give time for reset to occur
    goto    main    ; Go to main after reset

;;;;;;;;;;;;;;;;;;; Interrupt Service Routine Vectors ;;;;;;;;;;;;;;;;;;;;;;;;;;
; High Priority ISR Vector Definition:
PSECT	HiPriISR_Vec, class = CODE, reloc = 2
HiPriISR_Vec:
    GOTO    $	; Return to current Program Counter (For Now - no code here yet)
    
; Low Priority ISR Vector Definition:
PSECT	LoPriISR_Vec, class = CODE, reloc = 2
LoPriISR_Vec:
    GOTO    $	; Return to current Program Counter (For Now - no code here yet)


; Program Section: All Code Starts here
PSECT	code
// </editor-fold>
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;; Mainline Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; TIPS:
	; Use timer0 for the initialization routine
	; Reconfigure timer0 to use it for the alive LED
	; Some of the timers are not in the access bank, may need to set the BSR
; Definitions:
; switchCount:
	; 0000 0001 -> 1 ms pulse width
	; 0000 0010 -> 1.2 ms pulse width
	; 0000 0100 -> 1.4 ms pulse width
	; 0000 1000 -> 1.6 ms pulse width
	; 0001 0000 -> 1.8 ms pulse width
	; 0010 0000 -> 2 ms pulse width

Bignum	EQU 65536 - 62500	; Number to get the 1 second delay and 250 ms
pwm20ms	EQU 65536 - 40000	; Number of instructions for 20 ms delay with prescaler of 2
pwm1ms	EQU 65536 - 4000	; Instructions for 1 ms delay
pwm12ms EQU 65536 - 4800	; Instructions for 1.2 ms delay
pwm14ms EQU 65536 - 5600	; Instructions for 1.4 ms delay
pwm16ms EQU 65536 - 6400	; Instructions for 1.6 ms delay
pwm18ms EQU 65536 - 7200	; Instructions for 1.8 ms delay
pwm2ms	EQU 65536 - 8000	; Instructions for 2 ms delay


main:
    RCALL    Initial	; Call to Initial Routine
loop:
    RCALL   BlinkAlive	; Call blink alive subroutine
    RCALL   Check_SW1	; Check the switch state and change the width 
    RCALL   pwmSet	; Call the pwmSet subroutine to turn on the pulse
    BRA	    loop

    
;;;;;;;;;;;;;;;;;;;;;; Initialization Routine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Initial: 
    CLRF    INTCON, a			; Clear the flags in INTCON
    MOVLF   00000101B, T0CON, a		; Set up Timer0 for a delay of 1 s, 64 prescaler
    MOVLF   high Bignum, TMR0H, a	; Writing binary 3036 to TMR0H / TMR0L
    MOVLF   low Bignum, TMR0L, a	; Write high byte first, then low
    BSF     T0CON, 7, a			; Turn on Timer0
    
    MOVLF   high pwm1ms, pwmHigh, a	; Set the pwm to 1 ms at first
    MOVLF   low pwm1ms, pwmLow, a		; Low byte
    MOVLF   00000001B, switchCount, a	; Start the PWM at 1 ms with 0000 0001
    CLRF    switch1, a			; Clear the values of the switch varaible
    MOVLF   00001000B, TRISE, a		; Outputs on PORTE, RE3 is an input
    CLRF    TRISC, a			; Set all pins on PORTC as outputs
    CLRF    LATE, a			; Turn all of the LEDS off
    RCALL   Wait1sec			; Wait 1 second and start initialization routine
    BSF	    LATE, 5, a			; Turn ON RE5
    RCALL   Wait1sec			; Wait 1 second
    CLRF    LATE, a			; Turn OFF RE5
    BSF	    LATE, 6, a			; Turn ON RE6
    RCALL   Wait1sec			; Wait 1 second
    CLRF    LATE, a			; Turn OFF RE6
    BSF	    LATE, 7, a			; Turn ON RE7
    RCALL   Wait1sec			; Wait 1 second
    CLRF    LATE, a			; Turn OFF RD7
    BCF	    T0CON, 7, a			; Turn off the initialization timer
    
    MOVLF   00000011B, T0CON, a		; Set up Timer0 for a delay of 250 ms, 16 prescaler
    MOVLF   high Bignum, TMR0H, a	; Writing binary 3036 to TMR0H / TMR0L
    MOVLF   low Bignum, TMR0L, a	; Write high byte first, then low
    
    MOVLF   00010000B, T1CON, a		; Configure the timer 1 for a 20 ms delay
    MOVLF   high pwm20ms, TMR1H, a	; Move the high byte
    MOVLF   low pwm20ms, TMR1L, a	; Move the low byte
    
    MOVLF   00000000B, T3CON, a		; Confiugre timer3 for between a 1 and 2 ms delay
    
    BSF     T0CON, 7, a			; Turn on Timer0
    BSF	    T1CON, 0, a			; Turn on Timer1
    RETURN				; Return to Mainline code
    
    
;;;;;;; Wait1sec subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Uses Wait10ms by Scott Palo and Trudy Schwartz as a template
; Uses Timer0 to delay for 1 second
Wait1sec:
        BTFSS 	INTCON, 2, a		    ; Read Timer0 TMR0IF rollover flag
        BRA     Wait1sec		    ; Loop if timer has not rolled over
        MOVLF  	high Bignum, TMR0H, a	    ; Then write the timer values into
        MOVLF  	low Bignum, TMR0L, a	    ; the timer high and low registers
        BCF  	INTCON, 2, a		    ; Clear Timer0 TMR0IF rollover flag
        RETURN
	
;;;;;;; pwmSet subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This subroutine checks the 20 ms timer and sets the output on RC2 to high
; It also checks the timer3 and turns the LED off depending on the pulse width at the time
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
pwmSet:
    BTFSS   PIR1, 0, a		    ; Read the rollover flag and skip if set
    BRA	    pwmOff		    ; Check if the output needs to be turned off
    BSF	    LATC, 2, a		    ; Pulse high output on RC2
    
    MOVFF   pwmHigh, TMR3H	    ; Set timer3 for Xms delay
    MOVFF   pwmLow, TMR3L	    ; Low Byte
    BSF	    T3CON, 0, a		    ; Turn timer3 on 
    
    MOVLF   high pwm20ms, TMR1H, a   ; Reset the timer1 to count 20 ms again
    MOVLF   low pwm20ms, TMR1L, a    ; Move the low byte
    BCF	    PIR1, 0, a		    ; Clear the rollover bit
pwmOff:
    BTFSS   PIR2, 1, a		    ; Check if the rollover for timer3 is set
    BRA	    pwmEnd		    ; Return if the rollover is not set
    BCF	    LATC, 2, a		    ; Turn the output off
    BCF	    PIR2, 1, a		    ; Clear the rollover bit
    BCF	    T3CON, 0, a		    ; Turn the Xms timer off
pwmEnd:
    RETURN
    
    
;;;;;;; Check_SW1 subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Subroutine to check the status of RE3 button and change the pwm width
				
Check_SW1:
    MOVF    PORTE, w, a		; Read the current value of PORTE into WREG
    XORWF   switch1, w, a		; Check if the state of the button has changed
    ANDWF   switch1, f, a		; The previous state needs to be high for a release
    BTFSS   switch1, 3, a		; Skip next if the bit is set
    BRA	    EndSw			; Return if the bit is not set
    
    RLNCF   switchCount, f, a	; Rotate the bits to the left to update the width setting
    
    
    ;Control flow for moving the value of the timer depending on the switchCount variable
    BTFSC   switchCount, 0, a	; Condition for 1 ms
    BRA	    set1Ms
    BTFSC   switchCount, 1, a	; Condition for 1.2 ms
    BRA	    set12Ms
    BTFSC   switchCount, 2, a	; Condition for 1.4 ms
    BRA	    set14Ms
    BTFSC   switchCount, 3, a	; Condition for 1.6 ms
    BRA	    set16Ms
    BTFSC   switchCount, 4, a	; Condition for 1.8 ms
    BRA	    set18Ms
    BTFSC   switchCount, 5, a	; Condition for 2 ms
    BRA	    set2Ms
    BTFSC   switchCount, 6, a	; Condition for reset
    BRA	    set1Ms		; Set 1 ms for the timer, reset the value
    BRA	    EndSw		; Else return
    
set1Ms:
    MOVLF   00000001B, switchCount, a	; Reset the switchCount
    MOVLF   high pwm1ms, pwmHigh, a	; High byte
    MOVLF   low pwm1ms, pwmLow, a	; Low byte
    BRA	    EndSw
set12Ms:
    MOVLF   high pwm12ms, pwmHigh, a	; High byte
    MOVLF   low pwm12ms, pwmLow, a	; Low byte
    BRA	    EndSw
set14Ms:
    MOVLF   high pwm14ms, pwmHigh, a	; High byte
    MOVLF   low pwm14ms, pwmLow, a	; Low byte
    BRA	    EndSw
set16Ms:
    MOVLF   high pwm16ms, pwmHigh, a	; High byte
    MOVLF   low pwm16ms, pwmLow, a	; Low byte
    BRA	    EndSw
set18Ms:
    MOVLF   high pwm18ms, pwmHigh, a	; High byte
    MOVLF   low pwm18ms, pwmLow, a	; Low byte
    BRA	    EndSw
set2Ms:  
    MOVLF   high pwm2ms, pwmHigh, a	; High byte
    MOVLF   low pwm2ms, pwmLow, a	; Low byte
    BRA	    EndSw
    
EndSw:
    MOVF    PORTE, w, a		;Read the current value of PORTE into WREG 
    MOVWF   switch1, a		;Save the value of RE3 to the switch1 variable, this is the previous state  
    RETURN	
	
	
	
;;;;;;; BlinkAlive subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Uses BlinkAlive by Scott Palo and Trudy Schwartz as a template
; This subroutine briefly blinks the LED RE4 every 250 ms
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BlinkAlive:
	BTFSS	INTCON, 2, a	    ; Read Timer0 TMR0IF rollover flag
	BRA	END1		    ; Return if the timer flag has not rolled over
        BTG	LATE, 4, a			    ; Toggle LED RE4
	MOVLF	high Bignum, TMR0H, a	    ; Then write the timer values into
        MOVLF	low Bignum, TMR0L, a	    ; the timer high and low registers
        BCF	INTCON, 2, a		    ; Clear Timer0 TMR0IF rollover flag
END1:
        RETURN
	
;;;;;;; End of Program ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
    END     resetVec  