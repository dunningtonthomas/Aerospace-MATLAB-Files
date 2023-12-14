/****** ASEN 5067 Final Project ******************************************************
 * Author: Thomas Dunnington
 * Date  : 12/7/2023
 *
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
const char ASEN5067[16] = {0x80, 'L', 'i', 'D', 'A', 'R', ' ', 'D', 'I', 'S', 'T', 'A', 'N', 'C', 'E', 0x00};    // Top of LCD
const char clearDist[11] = {0xC0, 'D', '=', 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00};         // Reset distance measurement
const float ampConv = 1;                // Amps per bin, not sure what this is yet
char UART_buffer[10];                   // Character buffer array for receiving
char Luna_buffer[9];                   // UART buffer for data received from the Luna sensor
char distBool = 0;                      // Boolean to record distance data
char twoByteBool = 0;                   // Boolean to record distance data
int currDist = 0;                       // Current detected distance in cm
int prevDist = 0;                       // Previously detected distance
char index = 0;                         // Index for the UART_buffer
char Luna_Ind = 0;                      // Index for the Luna sensor buffer
char endBool = 0;                       // endBool = 1 if line feed detected
char tempBuffer[7];                     // String for TEMP reading
char potBuffer[8];                      // String for POT reading
char cont_on = 0;                       // 1 if continuous transmission enabled
char fast_on = 0;                       // 1 for fast transmission at 10 Hz
char fast_bool = 0;                     // Fast bool so we transmit every other time
char count = 0;                         // count to use for timer0 and continuous transmission
char received = 0;                      // Full transmission hasn't been received yet
char prevRec = 0;
char currRec = 0;
char bool1 = 0;
char bool2 = 0;
int tempCount = 0;
char distBuffer[8] = {0, 0, 0, 0, 0, 0, 0, 0};  // Distance string to be sent over USART
int tmr7Val = 0;                        // Value for TMR7 to range from 1 to 2 ms

/******************************************************************************
 * Function prototypes
 ******************************************************************************/
void Initial(void);             // Function to initialize hardware and interrupts
void TMR0handler(void);         // Interrupt handler for TMR0, typo in main
void receive_handler(void);     // Interrupt handler for receiving transmission     
void update_LCD(int);           // Update the LCD with new values
void send_byte(char);           // This function will send the input byte over UART
void command_parse(void);       // Function to parse the commands
void lunaReceive(void);         // Received byte from the luna sensor
void sendDistance(void);        // Send the current distance over USART1
void tmr5Handler(void);         // Toggle high on RC2
void tmr7Handler(void);         // Toggle low on RC2



/******************************************************************************
 * main()
 ******************************************************************************/
void main() 
{    
    Initial();                  // Initialize everything
     
    while(1) 
    {        
        if(endBool == 1) // This is set once we get a line feed character
        {
            command_parse();        // Parse the command
            endBool = 0;            // Reset the boolean for line feed reception
        }   
        
        if(PIR2bits.TMR3IF == 1) // Update LCD and pwm
        {
            PIR2bits.TMR3IF = 0;        // Reset flag
            TMR3 = 65536 - 50000;       // Instructions for 10 Hz
            
            // Update PWM signal
            tmr7Val = tmr7Val + 40;
            if(tmr7Val >= 8000) // Reset
            {
                tmr7Val = 4000; 
            }
           
            // Update the LCD
            DisplayC(clearDist);    // Clear previous
            update_LCD(currDist);   // Set new      
            
            // Send data if fast on
            if(fast_on == 1)
            {
                if(fast_bool == 1) // Send data every other, ~5Hz
                {
                    sendDistance();                    
                    fast_bool = 0;  // Flip
                }
                else // Flip boolean
                {
                    fast_bool = 1;  // Flip
                }
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
    
    // Configure the LCD pins for output. Defined in LCDRoutinesEasyPic.h
    LCD_RS_TRIS   = 0;              // Register Select Control line
    LCD_E_TRIS    = 0;              // Enable control line 
    LCD_DATA_TRIS = 0b11000000;     // Note the LCD data is only on the upper nibble RB0:3
                                    // Redundant to line above RB 4:5 for control
                                    // RB 6:7 set as inputs for other use, not used by LCD
    LCD_DATA_LAT = 0;           // Initialize LCD data LAT to zero

    // Initialize the LCD and print to it
    InitLCD();
    
    // Write to LCD
    DisplayC(ASEN5067);
    
    // Blink LEDs
    LATD = 0b00100000;          // Turn on RD5
    __delay_ms(500);            // Delay for 0.5 seconds
    LATD = 0b01000000;          // Turn on RD6
    __delay_ms(500);            // Delay for 0.5 seconds
    LATD = 0b10000000;          // Turn on RD7
    __delay_ms(500);            // Delay for 0.5 seconds
    LATD = 0b00000000;          // Turn all LEDs off

    // Initializing TMR0
    T0CON = 0b00000101;             // 16-bit, 64 prescaler
    TMR0 = 65536 - 56250;           // Instructions for 900 ms
    
    // Configure TIMER3 for output to LCD
    T3CON = 0b00110101;             // 16-bit, 8 prescaler, 
    TMR3 = 65536 - 50000;           // Instructions for 10 Hz
    
    // Configure TIMER5 for PWM generation 20 ms for total period
    T5CON = 0b00010100;             // 16-bit, 2 prescaler
    TMR5 = 65536 - 40000;           // Instructions for 20 ms
    
    // Configure TIMER7 for PWM generation 1-2 ms for toggling the pwm off
    T7CON = 0b00000100;             // 16-bit, no prescaler
    tmr7Val = 4000;                 // 1 ms value
    TMR7 = 65536 - tmr7Val;
    
    // Drive RC2 low
    LATCbits.LATC2 = 0;
    

    // Configuring Interrupts
    RCONbits.IPEN = 1;              // Enable priority levels
    INTCON2bits.TMR0IP = 0;         // Assign low priority to TMR0 interrupt

    INTCONbits.TMR0IE = 1;          // Enable TMR0 interrupts
    INTCONbits.GIEL = 1;            // Enable low-priority interrupts to CPU
    INTCONbits.GIEH = 1;            // Enable all interrupts
    
    // Interrupts for TMR5 and TMR7
    PIE5bits.TMR5IE = 1;            // Enable interrupts TMR5
    PIE5bits.TMR7IE = 1;            // Enable interrupts TMR7
    IPR5bits.TMR5IP = 0;            // Low priority
    IPR5bits.TMR7IP = 0;            // Low priority

    // Turn the timers on
    T0CONbits.TMR0ON = 1;           // Turning on TMR0
    T3CONbits.TMR3ON = 1;           // Turn the timer on
    T5CONbits.TMR5ON = 1;           // 5 on, 7 is turned on when 5 toggles the pwm

    
    // Interrupts for receiving commands
    PIE1bits.RC1IE = 1;             // Turn on interrupts for receiving a transmission
    IPR1bits.RC1IP = 1;             // High priority for receiving data
    
    // Configure EUSART 1
    TRISCbits.TRISC6 = 0;   // OUTPUT
    TRISCbits.TRISC7 = 1;   // INPUT
    TXSTA1 = 0b00100110;    // Double check high versus low speed mode
    RCSTA1 = 0b10010000;    // Enable, 8 bit, enable receiver, async
    BAUDCON1 = 0b01000000;  // 8 bit, non-inverted, idle high, bit 5 is the polarity bit check this, bit 4 is idle level
    SPBRG1 = 51;            // 19200 baud rate, high speed 8 bit, actual 19231
    
    // Clear the UART buffer
    for(int i = 0; i < 10; i++)
    {
        UART_buffer[i] = 0;
    }
    
    // Set ANCON2 bits to be zero so we can use EUSART2 for UART
    ANCON2 = 0b00000000;
    
    // Configure Interrupts for EUSART 2 receive
    PIE3bits.RC2IE = 1;         // Turn on interrupts for receiving a transmission
    IPR3bits.RC2IP = 1;         // High priority for receiving data from the sensor at 100Hz
    
    // Configure USART 2
    TRISGbits.TRISG2 = 1;       // 1 For input to receive transmissions
    TRISGbits.TRISG1 = 0;       // Output to transmit to the sensor
    TXSTA2 = 0b00100110;        // Enabled
    RCSTA2 = 0b10010000;        // Enable, 8 bit, enable receiver, async
    BAUDCON2 = 0b01001000;      // 16 bit, non-inverted, idle is high, bit 5 is the polarity bit, bit 4 is idle level
    SPBRG2 = 34;                // 115200 baud rate, high speed 8 bit, actual 114286    
}

/******************************************************************************
 * HiPriISR interrupt service routine
 *
 * Included to show form, does nothing
 ******************************************************************************/

void __interrupt() HiPriISR(void) {
    
    while(1)
    {       
        // Data from Luna
        if(PIR3bits.RC2IF == 1)
        {
            lunaReceive(); // Received byte
            continue;
        }
        
        // Check if the receive flag is set
        if(PIR1bits.RC1IF == 1)
        {
            LATDbits.LATD5 = ~LATDbits.LATD5;   // DEBUGGING
            receive_handler();
            continue;
        }  

        break;
    }

}	// Supports retfie FAST automatically

/******************************************************************************
 * receive_handler subroutine, the receive flag is set
 * 
 ******************************************************************************/
void receive_handler()
{
    // Temporary character to read received byte, this clears the interrupt flag
    char temp = RCREG1;
    
    // See if a new line character was received
    if(temp == 10)    // 10 is the line feed character, end of command
    {
        endBool = 1;
        return;      // Return so the new line is not stored in the buffer
    }
    
    // Store in the buffer
    UART_buffer[index] = temp; 

    // Increment the index
    index = index + 1;

    // Check if index is greater than the size of the buffer
    if(index > 9)
    {
        // Rollover the index
        index = 0;
    }       
}


/******************************************************************************
 * lunaReceive subroutine, a byte was received from the sensor, process the byte
 * 
 ******************************************************************************/
void lunaReceive()
{   
    // Set previous
    prevRec = currRec;
    
    // Get current, this clears the flag
    currRec = RCREG2;
    
    // Record distance
    if(bool1 == 1)                              // First byte
    {
        prevDist = currDist;                    // Previous distance
        currDist = currRec;                     // Get low byte
        bool1 = 0;                              // Reset first byte bool
        bool2 = 1;                              // Second byte bool
        return;
    }
    if(bool2 == 1)                              // Second byte
    {
        currDist = (currRec << 8) | currDist;   // Get high byte
        bool2 = 0;                              // Reset second bool
        return;
    }
    
    // Check to see if we received 0x59 0x59
    if(prevRec == 0x59 && currRec == 0x59)
    {
        // Set boolean to get distance
        bool1 = 1;
    }
}


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
        
        if(PIR5bits.TMR5IF)
        {
            // Call handler
            tmr5Handler();
            continue;
        }
        
        if(PIR5bits.TMR7IF)
        {
            // Call handler
            tmr7Handler();
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
    
    // TOGGLE LED
    LATDbits.LATD4 = ~LATDbits.LATD4;
    
    // Send data through USART
    if(cont_on == 1)
    {
        sendDistance(); // Send the current distance
    }
            
    // Reset
    TMR0 = 65536 - 56250;           // Instructions for 900 ms
    INTCONbits.TMR0IF = 0;      //Clear flag and return to polling routine
}


/******************************************************************************
 * tmr5Handler
 * This subroutine will turn on RC2 and start the timer TMR7 to turn off the PWM
 ******************************************************************************/
void tmr5Handler(void)
{
    // Toggle RC2
    LATCbits.LATC2 = 1; // Drive high
    
    // Start timer 7
    TMR7 = 65536 - tmr7Val;         // Load value into the timer
    T7CONbits.TMR7ON = 1;           // Turn the timer on
    
    // Reset timer 5
    TMR5 = 65536 - 40000;           // Instructions for 20 ms
    PIR5bits.TMR5IF = 0;            // Reset the flag
}

/******************************************************************************
 * tmr7Handler
 * This subroutine will turn off RC2 and TMR7
 ******************************************************************************/
void tmr7Handler(void)
{
    // Toggle RC2
    LATCbits.LATC2 = 0; // Drive Low
    
    // Turn the timer off
    T7CONbits.TMR7ON = 0; 
    
    
    PIR5bits.TMR7IF = 0;    // Reset the flag
}



/******************************************************************************
 * sendDistance
 * This subroutine will send the current distance over USART1
 ******************************************************************************/
void sendDistance()
{
    // Send Distance
    for(int i = 0; i < 8; i++)
    {
        if(distBuffer[i] == 0) // If null go to next character
        {
            continue;
        }
        send_byte(distBuffer[i]);   // Send character
    }
    send_byte(0x0A);    // Line feed for end of transmission
}

/******************************************************************************
 * command_parse
 * This subroutine will parse through the UART_buffer and determine what command
 * was received
 * It will then call then send the relevant byte over UART
 ******************************************************************************/
void command_parse()
{    
    // Define the different cases as strings
    char str1[10] = "DIST";         // Output the measured distance
    char str2[10] = "DIST_ON";      // Continuous transmission of distance
    char str3[10] = "DIST_OFF";     // End continuous
    char str4[10] = "FAST_ON";      // Fast transmission of distance
    char str5[10] = "FAST_OFF";      // End transmission of distance
    
    // Use string compare to see what case it is
    if(!strcmp(str1, UART_buffer)) //DIST
    {
        sendDistance();
    }
    else if(!strcmp(str2, UART_buffer)) //DIST_ON
    {
        cont_on = 1;
        fast_on = 0;
    }
    else if(!strcmp(str3, UART_buffer)) //DIST_OFF
    {
        fast_on = 0;
        cont_on = 0;
    }
    else if(!strcmp(str4, UART_buffer)) //FAST_ON
    {
        fast_on = 1;
        cont_on = 0;
    }
    else if(!strcmp(str5, UART_buffer)) //FAST_OFF
    {
        fast_on = 0;
        cont_on = 0;
    }
    else // Not a command
    {
        char notComm[13] = "Not a Command";
        for(int i = 0; i < 13; i++)
        {
            send_byte(notComm[i]);
        }
    }
    
    // Reset the indices to 0 and clear the buffer
    index = 0;
    for(int i = 0; i < 10; i++)
    {
        UART_buffer[i] = 0;
    }    
}



/******************************************************************************
 * send_byte
 * This subroutine will take as an input a byte and send over UART
 ******************************************************************************/
void send_byte(char byte)
{
    // Make sure previous transmission has gone through
    while(PIR1bits.TX1IF == 0) // Wait until transmission is done before sending next
    {
        ;
    }    
    
    // Send byte over UART if clear
    TXREG1 = byte;
}


/******************************************************************************
 * update_LCD updates the LCD with the new values of the distance/Amps
 * num = floating point number to display to one decimal place XX.X
 * state = 0 for distance measurement, state = 1 for amps 
 ******************************************************************************/
void update_LCD(int num)
{    
    // Buffer for LCD
    char buffer[10];
    
    // Format full string into distBuffer
    sprintf(distBuffer, "D=%dcm", num);
    buffer[0] = 0xC0;
    buffer[9] = 0x00;
    

    // Create the full word to send to the LCD
    for(int i = 1; i < 9; i++)
    {
        buffer[i] = distBuffer[i-1];
    }

    // Display on the LCD
    DisplayV(buffer); 
}