/****** ASEN 5067 Lab 6 ******************************************************
 * Author: Thomas Dunnington
 * Date  : 11/12/2023
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
const float degConv = 0.080566;         // Celsius per bin
const float voltConv = 0.0008056640625; // Voltage per bin

/******************************************************************************
 * Function prototypes
 ******************************************************************************/
void Initial(void);             // Function to initialize hardware and interrupts
void TMR0handler(void);         // Interrupt handler for TMR0, typo in main
void update_LCD(float, char);   // Update the LCD with new values
void ADC_Set(char*, char);      // Update the ADC channel and begin conversion
void ADC_Handle(char*);         // Handle the ADC conversion once it is complete
void sendE(void);

/******************************************************************************
 * main()
 ******************************************************************************/
void main() 
{    
    Initial();                  // Initialize everything
    char state = 1;             // State = 1 --> Read temperature, State = 0 --> Read potentiometer
     
    while(1) 
    {
        if(ADCON0bits.GO == 0)  // Conversion is complete
        {
            ADC_Handle(&state); // Get ADC result and output to LCD
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
    
    // Blink LEDs
    LATD = 0b00100000;          // Turn on RD5
    __delay_ms(500);            // Delay for 0.5 seconds
    LATD = 0b01000000;          // Turn on RD6
    __delay_ms(500);            // Delay for 0.5 seconds
    LATD = 0b10000000;          // Turn on RD7
    __delay_ms(500);            // Delay for 0.5 seconds
    LATD = 0b00000000;          // Turn all LEDs off
    
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
    
    // Configure USART
    TRISCbits.TRISC6 = 0;   //OUTPUT
    TRISCbits.TRISC7 = 1;   //INPUT
    TXSTA1 = 0b00100110;    //Double check high versus low speed mode
    RCSTA1 = 0b10010000;    //Enable, 8 bit, enable receiver, async
    BAUDCON1 = 0b01000000;  //8 bit, non-inverted, idle high, bit 5 is the polarity bit check this, bit 4 is idle level
    SPBRG1 = 51;            // 19200 baud rate, high speed 8 bit, actual 19231
    
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
        
        //Test call send E
        if(PIR1bits.TX1IF == 1)
        {
            sendE();
        }
        
    }
    INTCONbits.TMR0IF = 0;      //Clear flag and return to polling routine
}

// Temporary function
void sendE(void)
{
    // Test USART
    TXREG1 = 0x45;
            
    while(PIR1bits.TX1IF == 0) // Wait until transmission is done
    {
        ;
    }

    TXREG1 = 0x46;      // New line character
    
}
    


/******************************************************************************
 * ADC_Handle reads the result of the ADC after throwing away the first value and reconfigures the ADC for the next channel
 * state indicates whether we are reading from the potentiometer or the temperature sensor
 ******************************************************************************/
void ADC_Handle(char *state)
{
    // Throw away the first measurement, start conversion again and wait
    ADCON0bits.GO = 1;
    while(ADCON0bits.GO == 1)
    {
        ;
    }
        
    if(*state == 0) // Potentiometer reading
    {
        // Convert to voltage
        float volt = voltConv * ADRES;

        // Update the LCD
        update_LCD(volt, (*state));

        // Update ADC channel and state
        ADC_Set(state, 0b00001101);   
    }
    else           // Temperature reading
    {
        // Convert to degrees
        float deg = degConv * ADRES;

        // Update the LCD
        update_LCD(deg, (*state));

        // Update ADC channel and state
        ADC_Set(state, 0b00000001);  
    }
    
}


/******************************************************************************
 * ADC_Set changes channels to the corresponding 
 * state is used to tell which ADC channel we are setting to
 * bits is the byte to be loaded into ADCON0
 ******************************************************************************/
void ADC_Set(char *state, char bits)
{
    // Change the configuration for the ADC
    ADCON0 = bits;        // Channel AN3
    __delay_us(2.5);      // Delay by 2.5 microseconds for acquisition
    *state = !(*state);   // Update state
    ADCON0bits.GO = 1;    // Start the next conversion
}


/******************************************************************************
 * update_LCD updates the LCD with the new values of the temperature/potentiometer
 * num = floating point number to display to one decimal place XX.X
 * state = 0 for potentiometer, state = 1 for temperature 
 ******************************************************************************/
void update_LCD(float num, char state)
{
    if(state == 1) // Temperature
    {
        // Create string buffer for the floating point to string
        char buffer[9];
        char word[7];
        sprintf(word, "T=%.1fC", num);
        buffer[0] = 0xC0;
        buffer[8] = 0x00;
        
        // Create the full word to send to the LCD
        for(int i = 1; i < 8; i++)
        {
            buffer[i] = word[i-1];
        }
        
        DisplayV(buffer);
    }
    else    // Potentiometer
    {
        // Create string buffer for the floating point to string
        char buffer[10];
        char word[8];
        sprintf(word, "PT=%.2fV", num);
        buffer[0] = 0x80;
        buffer[9] = 0x00;
        
        // Create the full word to send to the LCD
        for(int i = 1; i < 9; i++)
        {
            buffer[i] = word[i-1];
        }
        
        DisplayV(buffer);
    }
}