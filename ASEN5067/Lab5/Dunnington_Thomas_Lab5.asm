;;;;;;; ASEN 4-5067 Lab 5 Dunnington Thomas ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Author: Thomas Dunnington
;	Last Modified: October 30, 2023   
;    
;	Originally Created:	Scott Palo (scott.palo@colorado.edu)
;	Modified:	Trudy Schwartz (trudy.schwartz@colorado.edu)
;	Updated By:	Ruben Hinojosa Torres (ruhi9621@colorado.edu)
;	Modified:       05-AUGUST-21
;
; NOTES:
;   Use Timer 0 for loop time timing requirements
;
;   This code Generate a jitter-free 10 Hz square wave on CCP1 output using 
;    compare mode with 24bit extension bytes.
;
;   You may re-use parts of lab 4 code (especially the LCD functions!) but 
;    remember to give credit in your comments for any code you did not write.
;
;;;;;;; Program hierarchy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Mainline
;   Initial
;   Example RPG Code
;   High Priority ISR Example Shell
;   Low Priority ISR
;	CCP1 Handler
;	TMR1 Handler
;
;;;;;;; Compiler Notes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
; Compiler Notes: 
; Add this line to the Compiler flags i.e
;   Right click on project name -> Properties -> pic-as Global Options -> 
;   Additional options: 
;    -Wl,-presetVec=0h,-pHiPriISR_Vec=0008h,-pLoPriISR_Vec=0018h
;
;;;;;;;;;;;;;;;;;;;;;;;;; Hardware Notes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

Notes (1) The ECCP2 pin placement depends on the CCP2MX Configuration bit 
	setting and whether the device is in Microcontroller or Extended 
	Microcontroller mode.
     (2) Not available on the PIC18F65K22 and PIC18F85K22 devices.
     (3) The CC6, CCP7, CCP8 and CCP9 pin placement depends on the 
	setting of the ECCPMX Configuration bit (CONFIG3H<1>).
*/
// </editor-fold>

;;;;;;;;;;;;;;;;;;;;;;;;; Assembler Directives ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
// <editor-fold defaultstate="collapsed" desc="Assembler Directives">    
; Processor Definition
PROCESSOR   18F87K22
; Radix Definition 
RADIX	DEC	      

; The following code should control macro expansions but needs further editing
    ; Macro Expansions
;EXPAND ;To expand macros
NOEXPAND ;To collapse macros
    
; The following code is from a previous compiler and no longer works 			      
    ; List Definition
    ;   C: Set the page (i.e., Column) width
    ;   N: Set the page length
    ;   X: Turn MACRO expansion on or off
    ;LIST	C = 160, N = 15, X = OFF
    
    
; Include File:
#include <xc.inc>
// </editor-fold>    

;;;;;;;;;;;;;;;;;;;;;;;;; PIC18F87K22 Configuration Bit Settings ;;;;;;;;;;;;;;;    
// <editor-fold defaultstate="collapsed" desc="CONFIG Definitions">
			      
; CONFIG1L
CONFIG  RETEN = ON            ; VREG Sleep Enable bit (Enabled)
CONFIG  INTOSCSEL = HIGH      ; LF-INTOSC Low-power Enable bit (LF-INTOSC in 
                              ;	    High-power mode during Sleep)
CONFIG  SOSCSEL = HIGH        ; SOSC Power Selection and mode Configuration bits 
			      ;	    (High Power SOSC circuit selected)
CONFIG  XINST = OFF           ; Extended Instruction Set (Disabled)

; CONFIG1H
CONFIG  FOSC = HS1            ; Oscillator
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
;   dest: destination should be a full 3 byte address
;   access: Access bank or not. Possible values are 'a' for access bank or
;	'b' for banked memory.
  MOVLF	    MACRO   lit, dest, access
    MOVLW   lit	    ; Move literal into WREG
    BANKSEL	(dest)	; Determine bank and set BSR for next file instruction
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
  
;;;;;;;;;;;;;;;;;;;;;;;;; Program Vectors ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
// <editor-fold defaultstate="collapsed" desc="Program Vectors">
  ;;;;;;;;;;;;;;;;;;;;;; Power-On-Reset entry point ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PSECT	resetVec, class = CODE, reloc = 2
resetVec:
    NOP	    ; No Operation
    goto    main    ; Go to main after reset

;;;;;;;;;;;;;;;;;;; Interrupt Service Routine Vectors ;;;;;;;;;;;;;;;;;;;;;;;;;;
; High Priority ISR Vector Definition:
PSECT	HiPriISR_Vec, class = CODE, reloc = 2
HiPriISR_Vec:
    GOTO    HiPriISR	; Go to High Priority ISR
    
; Low Priority ISR Vector Definition:
PSECT	LoPriISR_Vec, class = CODE, reloc = 2
LoPriISR_Vec:
    GOTO    LoPriISR	; Go to Low Priority ISR
// </editor-fold>  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
// <editor-fold defaultstate="collapsed" desc="Variables">
; Objects to be defined in Access Bank
PSECT	udata_acs
WREG_TEMP:	DS	1   ; Temp variables used in Low Pri ISR
STATUS_TEMP:	DS	1
BSR_TEMP:	DS	1    
TMR1X:		DS	1   ; Eight-bit extension to TMR1
TMR3X:		DS	1   ; Extentsion to TMR3
CCPR1X:		DS	1   ; Eight-bit extension to CCPR1
CCPR2X:		DS	1   ; Extension to CCPR2
DTIMEX:		DS	1   ; Delta time variable of half period of square wave
DTIMEH:		DS	1   ; Will copy OnPeriod constant into these 3 registers
DTIMEL:		DS	1
DTIME2X:	DS	1   ; Delta time for 800 ms, extension
DTIME2H:	DS	1   ; High byte
DTIME2L:	DS	1   ; Low byte
    
DTIME3X:	DS	1   ; Delta time for 1 ms, extension
DTIME3H:	DS	1
DTIME3L:	DS	1
DTIME4X:	DS	1   ; Delta time for 19 ms, extension
DTIME4H:	DS	1  
DTIME4L:	DS	1   
    
DIR_RPG:	DS	1   ; Direction of RPG
RPG_TEMP:	DS	1   ; Temp variable used for RPG state
OLDPORTD:	DS	1   ; Used to hold previous state of RPG
count:		DS	1   ; Used for timing delay
count1:		DS	1   ; Used for timing delay
count2:		DS	1   ; Used for timing delay  
count3:		DS	1   ; Used for timing delay

; Objects to be defined in Bank 1
PSECT	udata_bank1
    NOP
    
;;;;;;; Constant Strings (Program Memory) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PSECT romData, space = 0, class = CONST  
LCDstr:  
    DB  0x33,0x32,0x28,0x01,0x0C,0x06,0x00  ;Initialization string for LCD
LCDs:
    DB 0x80,'A','S','E','N',0x35, 0x30, 0x36, 0x37, 0x00    ;Write "ASEN5067" to first line of LCD
    
LCDsPw1:
    DB 0xC0, 'P', 'W', 0x31, 0x2E, 0x30, 0x30, 0x6D, 0x73, 0x00   ;PW1.00ms
    
// </editor-fold>
    
;;;;;;; Code Start ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PSECT	code	

;;;;;;;;;;;;;;;;;;;;;; Definitions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OnPeriod    EQU	    800000	    ; Number of instructions in 200 ms
OffPeriod   EQU	    3200000	    ; Number of instructions in 800 ms
Bignum	    EQU	    65536 - 62500   ; Number to get the 1 second delay and 250 ms
pw1	    EQU	    4000	    ; Instructions for 1 ms
pw19	    EQU	    76000	    ; Instructions for 19 ms

;;;;;;; Mainline program ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main:
    RCALL   Initial			; Initialize everything
loop:
    RCALL   Check_RPG
    BRA	    loop

;;;;;;; Initial subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; This subroutine performs SOME of the initializations of variables and
; registers. YOU will need to add those that are omitted/needed for your 
; specific code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Initial:
    ; LCD initialization output
    CLRF    TRISD, a			; Set PORTD as output
    RCALL   InitLCD			; Initialize the LCD
    POINT   LCDs			; ASEN5067
    RCALL   DisplayC			; Display characters
    POINT   LCDsPw1			; PW1.00ms
    RCALL   DisplayC			; Display characters
    MOVLF   00000011B, TRISD, a		; 1 and 0 for input from rpg, the rest is output for the LCD
    ;END LCD Init
    
    ;Flash LEDs init
    CLRF    INTCON, a			; Clear the flags in INTCON
    MOVLF   00000100B, T0CON, a		; Set up Timer0 for a delay of 0.5 s, 32 prescaler
    MOVLF   high Bignum, TMR0H, a	; Writing binary 3036 to TMR0H / TMR0L
    MOVLF   low Bignum, TMR0L, a	; Write high byte first, then low
    BSF     T0CON, 7, a			; Turn on Timer0
    
    RCALL   Wait05sec			; Wait 0.5 second and start initialization routine
    BSF	    LATD, 5, a			; Turn ON RE5
    RCALL   Wait05sec			; Wait 0.5 second
    CLRF    LATD, a			; Turn OFF RE5
    BSF	    LATD, 6, a			; Turn ON RE6
    RCALL   Wait05sec			; Wait 0.5 second
    CLRF    LATD, a			; Turn OFF RE6
    BSF	    LATD, 7, a			; Turn ON RE7
    RCALL   Wait05sec			; Wait 0.5 second
    CLRF    LATD, a			; Turn OFF RD7
    BCF	    T0CON, 7, a			; Turn off the initialization timer
    ;END Blink LED sequence    
    
   
    ; Load values for the alive LED
    MOVLF   low OnPeriod, DTIMEL, a	; Load DTIME with 200 ms
    MOVLF   high OnPeriod, DTIMEH, a
    MOVLF   low highword OnPeriod, DTIMEX, a
    
    MOVLF   low OffPeriod, DTIME2L, a	; Load DTIME2 with 800 ms
    MOVLF   high OffPeriod, DTIME2H, a
    MOVLF   low highword OffPeriod, DTIME2X, a
    
    ; Set up the CCP and timer for the blink alive LED
    MOVLF   00000010B, T1CON, a	    ; 16 bit timer, buffer H/L registers
    MOVLF   00001010B, CCP1CON, a   ; Select compare mode, software interrupt only
    MOVLB   0x0F		    ; Set BSR to bank F for SFRs outside of access bank				
    MOVLF   00001000B, CCPTMRS0, b  ; Set TMR1 for use with ECCP1, and TMR3 for use with ECCP2
    BSF	    RCON, 7, a		    ; Set IPEN bit <7> enables priority levels
    BCF	    IPR1, 0, a		    ; TMR1IP bit <0> assigns low priority to TMR1 interrupts
    BCF	    IPR3, 1, a		    ; CCP1IP bit<1> assign low pri to ECCP1 interrupts
    CLRF    TMR1X, a		    ; Clear TMR1X extension
    MOVLF   low highword OnPeriod, CCPR1X, a	; Make first 24-bit compare 
						; occur quickly 16bit+8bit ext 
						; Note: 200000 (= 0x30D40)
    BSF	    PIE3, 1, a	    ; CCP1IE bit <1> enables ECCP1 interrupts
    BSF	    PIE1, 0, a	    ; TMR1IE bit <0> enables TMR1 interrupts
    BSF	    INTCON, 6, a    ; GIEL bit <6> enable low-priority interrupts to CPU
    BSF	    INTCON, 7, a    ; GIEH bit <7> enable all interrupts    
    
    ; Load values for the PWM
    MOVLF   low pw1, DTIME3L, a	; Load DTIM3 with 1 ms, DTIME3 is the shorter period with the pulse high
    MOVLF   high pw1, DTIME3H, a
    MOVLF   low highword pw1, DTIME3X, a
    
    MOVLF   low pw19, DTIME4L, a	; Load DTIME4 with 19 ms, DTIME4 is the longer period with the pulse low
    MOVLF   high pw19, DTIME4H, a
    MOVLF   low highword pw19, DTIME4X, a
    
    MOVLF   low highword pw19, CCPR2X, a	; Make first 24-bit compare 
    
    ; Set up Timer 3 and ECCP2 for the PWM
    CLRF    TRISC, a		    ; Set I/O for PORTC
    CLRF    LATC, a		    ; Clear lines on PORTC
    MOVLF   00000010B, T3CON, a	    ; 16 bit timer, buffer H/L registers
    MOVLF   00001010B, CCP2CON, b   ; Select compare mode, software interrupt only for ECCP2
    BSF	    IPR2, 1, a		    ; TMR3IP bit <1> assigns high priority to TMR3 interrupts
    BSF	    IPR3, 2, a		    ; CCP1IP bit<1> assign High pri to ECCP2 interrupts
    CLRF    TMR3X, a		    ; Clear TMR3X extension
    BSF	    PIE2, 1, a		    ; TMR3IE bit <1> enables TMR3 interrupts
    BSF	    PIE3, 2, a		    ; CCP1IE bit <1> enables ECCP2 interrupts
    
    ; Turn the timers on
    BSF	    T1CON, 0, a	    ; TMR1ON bit <0> turn on timer1
    BSF	    T3CON, 0, a	    ; TMR3ON bit <0> turn on timer3
    
    RETURN
    
;;;;;;; RPG subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Credit: This subroutine modified from Peatman book Chapter 8 - RPG
; This subroutine deciphers RPG changes into values for RPG direction DIR_RPG of 0, +1, or -1.
; DIR_RPG = +1 for CW change, 0 for no change, and -1 for CCW change.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
RPG:
        CLRF	DIR_RPG, a	; Clear for "no change" return value.
        MOVF	PORTD, w, a	; Copy PORTD into W.
        MOVWF	RPG_TEMP, a	;  and RPG_TEMP.
        XORWF	OLDPORTD, w, a	; Check for any change?
        ANDLW	00000011B	; Masks just the RPG pins          
        BZ  RP8			; If zero, RPG has not moved, ->return
				; But if the two bits have changed then...
	; Form what a CCW change would produce.          	
	RRCF	OLDPORTD, w, a	; Rotate right once into carry bit   
	BNC	RP9		; If no carry, then bit 0 was a 0 -> branch to RP9
        BCF	WREG, 1, a	; Otherwise, bit 0 was a 1. Then clear bit 1
				; to simulate what a CCW change would produce
        BRA	RP10		; Branch to compare if RPG actually matches new CCW pattern in WREG
RP9:
        BSF	WREG, 1, a	; Set bit 1 since there was no carry
				; again to simulate what CCW would produce
RP10:				; Test direction of RPG
        XORWF	RPG_TEMP, w, a	; Did the RPG actually change to this output?
        ANDLW	00000011B	; Masks the RPG pins
        BNZ	RP11		; If not zero, then branch to RP11 for CW case
        DECF	DIR_RPG, f, a	; If zero then change DIR_RPG to -1, must be CCW. 
        BRA	RP8		; Done so branch to return
RP11:	; CW case 
        INCF	DIR_RPG, f, a	; Change DIR_RPG to +1 for CW.
RP8:
        MOVFF	RPG_TEMP, OLDPORTD  ; Save current RPG state as OLDPORTD
        RETURN
	
;;;;;;; Check_RPG subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This function calls the RPG function to get a direction and changes 
; the values of the pulse width by 40 instructions which is a 0.01 ms change 
; which corresponds to the rotation of 1/64 of the RPG
	
Check_RPG:
    RCALL   RPG		    ; Determine if there is a change    
    MOVF    DIR_RPG, w, a   ; Move into WREG
    ANDLW   11111111B	    ; Check if it is non-zero
    BZ	    CRP_End	    ; Return if the RPG hasn't moved
    BTFSC   DIR_RPG, 7, a   ; Skip if the 7th bit is clear --> 0 or 1 case, other wise it is the negative 1 case
    BRA	    CCW		    ; Counter-clockwise case when the 7th bit is set
    BTFSS   DIR_RPG, 0, a   ; Skip if the first bit is set --> 1 case
    BRA	    CRP_End	    ; Return if 0, shouldn't get to this point
CW:
    ;Check if we are at 2 ms
    MOVLW   01000000B	    ; Low byte for 2 ms, 8000 instructions
    CPFSEQ  DTIME3L, a	    ; Check if the low byte is at the condition for 2 ms, skip if it is
    BRA	    CW2		    ; Not at 2 ms, increment the pulse width
    MOVLW   00011111B	    ; High byte for 2 ms, 8000 instructions
    CPFSEQ  DTIME3H, a	    ; Check if the high byte is at the condition for 2 ms
    BRA	    CW2		    ; Not at 2 ms, increment the pulse width
    BRA	    CRP_End	    ; Return if we are already at 2 ms, can't go any higher
CW2:
    MOVLW   00101000B	    ; Load the value into the WREG, 40 instructions for 0.01 ms change
    ADDWF   DTIME3L, f, a   ; Add to the low byte
    MOVLW   00000000B	    ; High and upper are zero to add
    ADDWFC  DTIME3H, f, a   ; Add with carry
    ADDWFC  DTIME3X, f, a   ; Add with carry
    
    MOVLW   00101000B	    ; Load value to subtract
    SUBWF   DTIME4L, f, a   ; Subtract from the low byte
    MOVLW   00000000B	    ; Zero
    SUBWFB  DTIME4H, f, a   ; Subtract with carry
    SUBWFB  DTIME4X, f, a   ; Subtract with carry
    BRA	    CRP_End	    ; Return

CCW:
    ;Check if we are at 1 ms
    MOVLW   10100000B	    ; Low byte for 1 ms, 4000 instructions
    CPFSEQ  DTIME3L, a	    ; Check if the low byte is at the condition for 1 ms
    BRA	    CCW2	    ; Not at 1 ms, decrement the pulse width
    MOVLW   00001111B	    ; High byte for 1 ms
    CPFSEQ  DTIME3H, a	    ; Check if the low byte is at the condition for 1 ms
    BRA	    CCW2	    ; Not at 1 ms, decrement the pulse width
    BRA	    CRP_End	    ; Return if we are already at 1 ms
    
CCW2:
    MOVLW   00101000B	    ; Load value to subtract
    SUBWF   DTIME3L, f, a   ; Subtract from the low byte
    MOVLW   00000000B	    ; Zero
    SUBWFB  DTIME3H, f, a   ; Subtract with carry
    SUBWFB  DTIME3X, f, a   ; Subtract with carry
    
    MOVLW   00101000B	    ; Load the value into the WREG
    ADDWF   DTIME4L, f, a   ; Add to the low byte
    MOVLW   00000000B	    ; High and upper are zero to add
    ADDWFC  DTIME4H, f, a   ; Add with carry
    ADDWFC  DTIME4X, f, a   ; Add with carry
  
CRP_End:
    RETURN
    

	
;;;;;;; HiPriISR interrupt service routine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HiPriISR:                        ; High-priority interrupt service routine
;       <execute the handler for interrupt source, write your code here if needed>
;       <clear that source's interrupt flag>
	MOVFF	STATUS, STATUS_TEMP	; Set aside STATUS and WREG
        MOVWF	WREG_TEMP, a
	MOVFF	BSR, BSR_TEMP
H2:
        BTFSS	PIR3, 2, a	; Test CCP2IF bit <2> for this interrupt
        BRA	H3
        RCALL	CCP2handler	; Call CCP1handler for generating RD4 LED output
        BRA	H2
H3:
        BTFSS	PIR2, 1, a	; Test TMR3IF bit <1> for this interrupt
        BRA	H4
        RCALL	TMR3handler	; Call TMR1handler for timing with CCP1
        BRA	H2
H4:
	MOVF	WREG_TEMP, w, a	    ; Restore WREG and STATUS
        MOVFF	STATUS_TEMP, STATUS
	MOVFF	BSR_TEMP, BSR        
        RETFIE			; Return from interrupt, reenabling GIEL and restore values from shadow registers

;;;;;;; CCP2 Handler ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CCP2handler:
    
	;; NEED TO MODIFY ALL OF THE FOLLOWING for ccp2/tmr3
        BTFSS	PIR2, 1, a	; If TMR3's overflow flag is set? skip to test CCP bit7
        BRA	H5		; If TMR1F was clear, branch to check extension bytes
        BTFSC	CCPR2H, 7, b	; Is bit 7 a 0? Then TMR3/CCP2 just rolled over, need to inc TMR3X
        BRA	H5		; Is bit 7 a 1? Then let TMR3handler inc TMR3X 
        INCF	TMR3X, f, a	; TMR1/CCP just rolled over, must increment TMR1 extension
        BCF	PIR2, 1, a	; and clear TMR3IF bit <1> flag 
				;(Since TMR3 handler was unable to and arrived here first!)
H5:
        MOVF	TMR3X, w, a	; Check whether extensions are equal
        SUBWF	CCPR2X, w, a	; by subtracting TMR1X and CCPR1X, check if 0
        BNZ	H7		; If not, branch to return
        BTG	LATC, 2, a	; Manually toggle RC2
	BTFSS	LATC, 2, a	; Skip if the RC2 output is high
	BRA	H6		; RC2 is low, load 19 ms case
	
	MOVF	DTIME3L, w, a	; RC2 is high, load the 1 ms case
        ADDWF	CCPR2L, f, b
        MOVF	DTIME3H, w, a	; Add to each of the 3 bytes to get 24 bit CCP
        ADDWFC	CCPR2H, f, b
        MOVF	DTIME3X, w, a
        ADDWFC	CCPR2X, f, a
	BRA	H7		; Return
H6:
	MOVF	DTIME4L, w, a	; RC2 is low, load the 19 ms case
        ADDWF	CCPR2L, f, b
        MOVF	DTIME4H, w, a	; Add to each of the 3 bytes to get 24 bit CCP
        ADDWFC	CCPR2H, f, b
        MOVF	DTIME4X, w, a
        ADDWFC	CCPR2X, f, a		
H7:
	BCF	PIR3, 2, a	; Clear the CCP2IF bit <2> interrupt flag
        RETURN

;;;;;;; TIMER3 Handler  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
TMR3handler:
	INCF	TMR3X, f, a	;Increment Timer3 extension
        BCF	PIR2, 1, a	;Clear TMR3IF flag and return to service routine
	RETURN

	
;;;;;;; LoPriISR interrupt service routine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoPriISR:				; Low-priority interrupt service routine
        MOVFF	STATUS, STATUS_TEMP	; Set aside STATUS and WREG
        MOVWF	WREG_TEMP, a
	MOVFF	BSR, BSR_TEMP        
L2:
        BTFSS	PIR3, 1, a	; Test CCP1IF bit <1> for this interrupt
        BRA	L3
        RCALL	CCP1handler	; Call CCP1handler for generating RD4 LED output
        BRA	L2
L3:
        BTFSS	PIR1, 0, a	; Test TMR1IF bit <0> for this interrupt
        BRA	L4
        RCALL	TMR1handler	; Call TMR1handler for timing with CCP1
        BRA	L2
L4:
        MOVF	WREG_TEMP, w, a	    ; Restore WREG and STATUS
        MOVFF	STATUS_TEMP, STATUS
	MOVFF	BSR_TEMP, BSR        
        RETFIE			; Return from interrupt, reenabling GIEL
	
;;;;;;;; CCP1 Handler ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CCP1handler:			; First must test if TMR1IF occurred at the same time
        BTFSS	PIR1, 0, a	; If TMR1's overflow flag is set? skip to test CCP bit7
        BRA	L5		; If TMR1F was clear, branch to check extension bytes
        BTFSC	CCPR1H, 7, a	; Is bit 7 a 0? Then TMR1/CCP just rolled over, need to inc TMR1X
        BRA	L5		; Is bit 7 a 1? Then let TMR1handler inc TMR1X 
        INCF	TMR1X, f, a	; TMR1/CCP just rolled over, must increment TMR1 extension
        BCF	PIR1, 0, a	; and clear TMR1IF bit <0> flag 
				;(Since TMR1 handler was unable to and arrived here first!)
L5:
        MOVF	TMR1X, w, a	; Check whether extensions are equal
        SUBWF	CCPR1X, w, a	; by subtracting TMR1X and CCPR1X, check if 0
        BNZ	L7		; If not, branch to return
        BTG	LATD, 4, a	; Manually toggle RD4
	BTFSS	LATD, 4, a	; Skip if the LED is on
	BRA	L6		; The LED is off, load 800 ms case
	
	MOVF	DTIMEL, w, a	; The LED is on, load the 200 ms case
        ADDWF	CCPR1L, f, a
        MOVF	DTIMEH, w, a	; Add to each of the 3 bytes to get 24 bit CCP
        ADDWFC	CCPR1H, f, a
        MOVF	DTIMEX, w, a
        ADDWFC	CCPR1X, f, a
	BRA	L7		; Return
L6:
	MOVF	DTIME2L, w, a	; The LED was just turned off, load the 800 ms case
        ADDWF	CCPR1L, f, a
        MOVF	DTIME2H, w, a	; Add to each of the 3 bytes to get 24 bit CCP
        ADDWFC	CCPR1H, f, a
        MOVF	DTIME2X, w, a
        ADDWFC	CCPR1X, f, a	
L7:
        BCF	PIR3, 1, a	; Clear the CCP1IF bit <1> interrupt flag
        RETURN

	
;;;;;;;; TMR1 Handler ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TMR1handler:
        INCF	TMR1X, f, a	;Increment Timer1 extension
        BCF	PIR1, 0, a	;Clear TMR1IF flag and return to service routine
        RETURN
	
	
	
	
;;;;;;; InitLCD subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; From Scott Palo and Trudy Schwartz:
; InitLCD - modified version of subroutine in Reference: Peatman CH7 LCD
; Initialize the LCD.
; First wait for 0.1 second, to get past display's power-on reset time.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
InitLCD:
        MOVLF  10,count,A	    ; Wait 0.1 second for LCD to power up
Loop3:
        RCALL  Wait10ms		    ; Call wait10ms 10 times to 0.1 second
        DECF  count,F,A
        BNZ	Loop3
        BCF     LATB,4,A	    ; RS=0 for command mode to LCD
        POINT   LCDstr		    ; Set up table pointer to initialization string
        TBLRD*			    ; Get first byte from string into TABLAT
Loop4:
	CLRF LATB,A		    ; First set LATB to all zero	
        BSF   LATB,5,A		    ; Drive E high - enable LCD
	MOVF TABLAT,W,A		    ; Move byte from program memory into working register
	ANDLW 0xF0		    ; Mask to get only upper nibble
	SWAPF WREG,W,A		    ; Swap so that upper nibble is in right position to move to LATB (RB0:RB3)
	IORWF PORTB,W,A		    ; Mask with the rest of PORTB to retain existing RB7:RB4 states
	MOVWF LATB,A		    ; Update LATB to send upper nibble
        BCF   LATB,5,A		    ; Drive E low so LCD will process input
        RCALL Wait10ms		    ; Wait ten milliseconds
	
	CLRF LATB,A		    ; Reset LATB to all zero	    
        BSF  LATB,5,A		    ; Drive E high
        MOVF TABLAT,W,A		    ; Move byte from program memory into working register
	ANDLW 0x0F		    ; Mask to get only lower nibble
	IORWF PORTB,W,A		    ; Mask lower nibble with the rest of PORTB
	MOVWF LATB,A		    ; Update LATB to send lower nibble
        BCF   LATB,5,A		    ; Drive E low so LCD will process input
        RCALL Wait10ms		    ; Wait ten milliseconds
        TBLRD+*			    ; Increment pointer and get next byte
        MOVF  TABLAT,F,A	    ; Check if we are done, is it zero?
        BNZ	Loop4
        RETURN
	
;;;;;;;;DisplayC subroutine;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; From Scott Palo and Trudy Schwartz:
; DisplayC taken from Reference: Peatman CH7 LCD
; This subroutine is called with TBLPTR containing the address of a constant
; display string.  It sends the bytes of the string to the LCD.  The first
; byte sets the cursor position.  The remaining bytes are displayed, beginning
; at that position hex to ASCII.
; This subroutine expects a normal one-byte cursor-positioning code, 0xhh, and
; a null byte at the end of the string 0x00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DisplayC:
        BCF   LATB,4,A		    ;Drive RS pin low for cursor positioning code
        TBLRD*			    ;Get byte from string into TABLAT
        MOVF  TABLAT,F,A	    ;Check for leading zero byte
        BNZ	Loop5
        TBLRD+*			    ;If zero, get next byte
Loop5:
	MOVLW 0xF0
	ANDWF LATB,F,A		    ;Clear RB0:RB3, which are used to send LCD data
        BSF   LATB,5,A		    ;Drive E pin high
        MOVF TABLAT,W,A		    ;Move byte from table latch to working register
	ANDLW 0xF0		    ;Mask to get only upper nibble
	SWAPF WREG,W,A		    ;swap so that upper nibble is in right position to move to LATB (RB0:RB3)
	IORWF PORTB,W,A		    ;Mask to include the rest of PORTB
	MOVWF LATB,A		    ;Send upper nibble out to LATB
        BCF   LATB,5,A		    ;Drive E pin low so LCD will accept nibble
	
	MOVLW 0xF0
	ANDWF LATB,F,A		    ;Clear RB0:RB3, which are used to send LCD data
        BSF   LATB,5,A		    ;Drive E pin high again
        MOVF TABLAT,W,A		    ;Move byte from table latch to working register
	ANDLW 0x0F		    ;Mask to get only lower nibble
	IORWF PORTB,W,A		    ;Mask to include the rest of PORTB
	MOVWF LATB,A		    ;Send lower nibble out to LATB
        BCF   LATB,5,A		    ;Drive E pin low so LCD will accept nibble
        RCALL T50		    ;Wait 50 usec so LCD can process
	
        BSF   LATB,4,A		    ;Drive RS pin high for displayable characters
        TBLRD+*			    ;Increment pointer, then get next byte
        MOVF  TABLAT,F,A	    ;Is it zero?
        BNZ	Loop5
        RETURN
	
	
;;;;;;; Wait05sec subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Uses Wait10ms by Scott Palo and Trudy Schwartz as a template
; Uses Timer0 to delay for 0.5 second
Wait05sec:
        BTFSS 	INTCON, 2, a		    ; Read Timer0 TMR0IF rollover flag
        BRA     Wait05sec		    ; Loop if timer has not rolled over
        MOVLF  	high Bignum, TMR0H, a	    ; Then write the timer values into
        MOVLF  	low Bignum, TMR0L, a	    ; the timer high and low registers
        BCF  	INTCON, 2, a		    ; Clear Timer0 TMR0IF rollover flag
        RETURN
	
;;;;;;; Wait10msec subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Manual timing loop to wait 10 ms
Wait10ms:
    MOVLF 10, count3, a	; Move 10 into count3 to iterate over
loopW100:
    RCALL Wait1ms		;Call 1 ms 100 times
    DECF count3, f, a		;Decrement count variable
    BNZ loopW100		;Branch if not zero
    RETURN	
    
;;;;;;; Wait1ms subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Subroutine to wait 1 ms
; Uses a manual delay loop
Wait1ms:
    MOVLF 54, count2, a		;Move literal value of 54 into count2    
loopOuter:
    MOVLF 23, count1, a		;Move literal value of 23 into the count1 variable
loopInner:
	DECF count1, f, a	;Decrement the variable, store in itself
	BNZ loopInner		;LoopInner if not zero yet
    DECF count2, f, a		;Decrement count2 for the outter loop
    BNZ loopOuter		;Branch to outerloop
    RETURN 
    
	
;;;;;;; T50 subroutine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; From Scott Palo and Trudy Schwartz:
; T50 modified version of T40 taken from Reference: Peatman CH 7 LCD
; Pause for 50 microseconds or 50/0.25 = 200 instruction cycles.
; Assumes 16/4 = 4 MHz internal instruction rate (250 ns)
; rcall(2) + movlw(1) + movwf(1) + COUNT*3 - lastBNZ(1) + return(2) = 200 
; Then COUNT = 195/3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
T50:
        MOVLW  195/3          ;Each loop L4 takes 3 ins cycles
        MOVWF  count,A		    
T50_1:
        DECF  count,F,A
        BNZ	T50_1
        RETURN
	
;;;;;;; End of Program ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
    END     resetVec  