/****** ASEN 5067 Lab 6 ******************************************************
 * Author: Thomas Dunnington
 * Date  : 11/2/2023
 *
 * Updated for XC8
 * 
 * Description
 * On power up execute the following sequence:
 *      RD5 ON for 0.5s +/- 10ms then off
 *      RD6 ON for 0.5s +/- 10ms then off
 *      RD7 ON for 0.5s +/- 10ms then off
 * The following then occurs forever:
 *      RD4 blinks for the times shown in the lab6 document
 *      LCD Displays the following lines:
 *          'T=xx.x C'
 *          'PT=x.xxV'
 *      Where the 'x' is replaced by a digit in the measurement.
 *          Temperature data must be calculated / displayed with one digit to
 *          the right of the decimal as shown.  The sensor itself can have
 *          errors up to +/- 5 degrees Celsius.
 *          Potentiometer data must be calculated / displayed with two digits
 *          to the right of the decimal as shown.
 *          These measurements must be refreshed at LEAST at a frequency of 5Hz.
 *      USART Commands are read / executed properly. '\n' is a Line Feed char (0x0A)
 *          ASEN 4067:
 *              'TEMP\n'     - Transmits temperature data in format: 'XX.XC'
 *              'POT\n'      - Transmits potentiometer data in format: X.XXV'
 *          ASEN 5067: Same as ASEN 4067, plus two additional commands
 *              'CONT_ON\n'  - Begins continuous transmission of data over USART
 *              'CONT_OFF\n' - Ends continuous transmission of data over USART
 *
 *              Continuous transmission should output in the following format:
 *                  'T=XX.XC; PT = X.XXV\n'
 *      DAC is used to output analog signal onto RA5 with jumper cables. 
 *          ASEN 4067:
 *              Potentiometer voltage is converted from a digital value to analog 
 *              and output on the DAC. 
 *          ASEN 5067: 
 *              A 0.5 Hz 0-3.3V triangle wave is output on the DAC. 
 *******************************************************************************
 *
 * Program hierarchy 
 *
 * Mainline
 *   Initial
 *
 * HiPriISR (included just to show structure)
 *
 * LoPriISR
 *   TMR0handler
 ******************************************************************************/

#include <xc.h>
#include "LCDroutinesEasyPic.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>


#define _XTAL_FREQ 16000000   //Required in XC8 for delays. 16 Mhz oscillator clock
#pragma config FOSC=HS1, PWRTEN=ON, BOREN=ON, BORV=2, PLLCFG=OFF
#pragma config WDTEN=OFF, CCP2MX=PORTC, XINST=OFF

/******************************************************************************
 * Global variables
 ******************************************************************************/
const char LCDRow1[] = {0x80,'T','E','S','T','I','N','G','!',0x00};  //const puts into prog memory
const float degConv = 0.080566;     // Celsius per bin
const float voltConv = 0.000805664; // Voltage bin

/******************************************************************************
 * Function prototypes
 ******************************************************************************/
void Initial(void);         // Function to initialize hardware and interrupts
void TMR0handler(void);     // Interrupt handler for TMR0, typo in main

/******************************************************************************
 * main()
 ******************************************************************************/
void main() {
    
    char state = 1;        // State = 1 if the ADC finished reading temperature, State = 0 if ADC finished potentiometer
    float volt = 0.0;      // voltage is the voltage output from the ADC
    float deg = 0.0;        // Degree measurement from the temperature sensor
    
    Initial();                 // Initialize everything
     
     while(1) {
        // Put mainline code here
          if(ADCON0bits.GO == 0)  // Conversion is complete
          {
              if(state == 0) // Potentiometer reading
              {
                  // Throw away the first measurement, start conversion again and wait
                  ADCON0bits.GO = 1;
                  while(ADCON0bits.GO == 1)
                  {
                      ;
                  }
                  // Conversion is complete
                  volt = voltConv * ADRES;
                  
                  // Change the configuration for the 
                  ADCON0 = 0b00001101;        // Channel AN3
                  __delay_us(2.5);            // Delay by 2.5 microseconds for acquisition
                  ADCON0bits.GO = 1;          // Start the next conversion
              }
              else           // Temperature reading
              {
                  // Throw away the first measurement, start conversion again and wait
                  ADCON0bits.GO = 1;
                  while(ADCON0bits.GO == 1)
                  {
                      ;
                  }
                  // Conversion is complete
                  deg = degConv * ADRES;
                  
                  // Change the configuration for the 
                  ADCON0 = 0b00000001;        // Channel AN0
                  __delay_us(2.5);            // Delay by 2.5 microseconds for acquisition
                  ADCON0bits.GO = 1;          // Start the next conversion
              }
          }
     }
}

/******************************************************************************
 * Initial()
 *
 * This subroutine performs all initializations of variables and registers.
 * 
 ******************************************************************************/
void Initial() {     
    // Configure the IO ports
    TRISD  = 0b00001111;
    LATD = 0;               // Turn off all LEDs
    TRISC  = 0b10010011;
    LATC = 0;
    TRISAbits.TRISA3 = 1;     // Input for the temperature sensor
    TRISAbits.TRISA0 = 1;     // Input for the potentiometer
    
    // Configure the LCD pins for output. Defined in LCDRoutinesEasyPic.h
    LCD_RS_TRIS   = 0;              // Register Select Control line
    LCD_E_TRIS    = 0;              // Enable control line 
    LCD_DATA_TRIS = 0b11000000;     // Note the LCD data is only on the upper nibble RB0:3
                                    // Redundant to line above RB 4:5 for control
                                    // RB 6:7 set as inputs for other use, not used by LCD
    LCD_DATA_LAT = 0;           // Initialize LCD data LAT to zero


    // Initialize the LCD and print to it
    InitLCD();
    DisplayC(LCDRow1);
    
    // Blink LEDs
    LATD = 0b00100000;          // Turn on RD5
    __delay_ms(500);            // Delay for 0.5 seconds
    LATD = 0b01000000;          // Turn on RD6
    __delay_ms(500);            // Delay for 0.5 seconds
    LATD = 0b10000000;          // Turn on RD7
    __delay_ms(500);            // Delay for 0.5 seconds
    
    // Initialize the ADCONx registers
    ADCON0 = 0b00001101;        // Channel AN3
    ADCON1 = 0b00000000;
    ADCON2 = 0b10010101;        // 1 micro s per bit conversion
    __delay_us(2.5);            // Delay by 2.5 microseconds for acquisition

    // Initializing TMR0
    T0CON = 0b00000101;             // 16-bit, 64 prescaler
    TMR0 = 65536 - 56250;           // Instructions for 900 ms

    // Configuring Interrupts
    RCONbits.IPEN = 1;              // Enable priority levels
    INTCON2bits.TMR0IP = 0;         // Assign low priority to TMR0 interrupt

    INTCONbits.TMR0IE = 1;          // Enable TMR0 interrupts
    INTCONbits.GIEL = 1;            // Enable low-priority interrupts to CPU
    INTCONbits.GIEH = 1;            // Enable all interrupts

    T0CONbits.TMR0ON = 1;           // Turning on TMR0
    
    // Start ADC with the temperature sensor, turn on
    ADCON0bits.GO = 1;
}

/******************************************************************************
 * HiPriISR interrupt service routine
 *
 * Included to show form, does nothing
 ******************************************************************************/

void __interrupt() HiPriISR(void) {
    
}	// Supports retfie FAST automatically

/******************************************************************************
 * LoPriISR interrupt service routine
 *
 * Calls the individual interrupt routines. It sits in a loop calling the required
 * handler functions until TMR0IF is clear.
 ******************************************************************************/

void __interrupt(low_priority) LoPriISR(void) 
{
    // Save temp copies of WREG, STATUS and BSR if needed.
    while(1) {
        if( INTCONbits.TMR0IF ) {
            TMR0handler();
            continue;
        }
        // Save temp copies of WREG, STATUS and BSR if needed.
        break;      // Supports RETFIE automatically
    }
}


/******************************************************************************
 * TMR0handler interrupt service routine.
 *
 * Handles Alive LED Blinking via counter 
 ******************************************************************************/
void TMR0handler() {
    if(LATDbits.LATD4 == 1) //Condition for high
    {
        LATDbits.LATD4 = 0;
        TMR0 = 65536 - 56250;           // Instructions for 900 ms
    }
    else //LED is low
    {
        LATDbits.LATD4 = 1;
        TMR0 = 65536 - 6250;           // Instructions for 100 ms
    }
    INTCONbits.TMR0IF = 0;      //Clear flag and return to polling routine
}


/******************************************************************************
 * read_ADC reads the 
 ******************************************************************************/
