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
char UART_buffer[10];                   // Character buffer array for receiving
char index = 0;                         // index for the UART_buffer
char oldIndex = 0;                      // old index value
char endBool = 0;                       // endBool = 1 if line feed detected
char tempBuffer[7];                     // String for TEMP reading
char potBuffer[8];                      // String for POT reading
char cont_on = 0;                       // 1 if continuous transmission enabled
char count = 0;                         // count to use for timer0 and continuous transmission
unsigned int dacVal = 0;                // Output value to the DAC
char direction = 1;                     // Boolean to increase or decrease the dac value, 1 is increase

/******************************************************************************
 * Function prototypes
 ******************************************************************************/
void Initial(void);             // Function to initialize hardware and interrupts
void TMR0handler(void);         // Interrupt handler for TMR0, typo in main
void receive_handler(void);     // Interrupt handler for receiving transmission     
void update_LCD(float, char);   // Update the LCD with new values
void ADC_Set(char*, char);      // Update the ADC channel and begin conversion
void ADC_Handle(char*);         // Handle the ADC conversion once it is complete
void send_byte(char);           // This function will send the input byte over UART
void command_parse(void);       // Function to parse the commands
void contSend(void);            // Send T and P
void writeSPI(void);            // Sends voltage to the DAC
void updateSPI(void);           // Updates the value of the value to be written to SPI

/******************************************************************************
 * main()
 ******************************************************************************/
void main() 
{    
    Initial();                  // Initialize everything
    char state = 1;             // State = 1 --> Read temperature, State = 0 --> Read potentiometer
     
    while(1) 
    {
        // ADC Conversion
        if(ADCON0bits.GO == 0)  // Conversion is complete
        {
            ADC_Handle(&state); // Get ADC result and output to LCD
        }
        
        if(endBool == 1) // This is set once we get a line feed character
        {
            command_parse();        // Parse the command
            endBool = 0;            // Reset the boolean for line feed reception
        }
        
        // Send SPI command
        writeSPI();
        
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
    
    // Configure Interrupts for EUSART receive
    PIE1bits.RC1IE = 1;             // Turn on interrupts for receiving a transmission
    IPR1bits.RC1IP = 1;             // High priority for receiving data
    
    // Configure USART
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
    
    // Configure the SPI parameters
    TRISCbits.TRISC3 = 0;       // Clock output
    TRISCbits.TRISC4 = 1;       // MISO input
    TRISCbits.TRISC5 = 0;       // MOSI output
    TRISEbits.TRISE0 = 0;       // CS output, CS = 0 to select the device
    TRISAbits.TRISA5 = 1;       // RA5 input for the output of the DAC to the board
    
    SSP1STAT = 0b00000000;      // Master mode with rising edge, buffer is not full
    SSP1CON1 = 0b00100000;      // Enable serial port, idle state low, Fosc/4 for the clock
    
    // Configure TIMER3 for the timing of the update spi function
    T3CON = 0b00000101;             // 16-bit, no prescaler
    TMR3 = 65536 - 1953;            // Instructions for 0.488281 ms
    PIE2bits.TMR3IE = 1;            // Enable interrupts for timer3
    IPR2bits.TMR3IP = 0;            // Low priority interrupts
    T3CONbits.TMR3ON = 1;           // Turn the timer on
    
    // Start ADC with the temperature sensor, turn on
    ADCON0bits.GO = 1;
}

/******************************************************************************
 * HiPriISR interrupt service routine
 *
 * Included to show form, does nothing
 ******************************************************************************/

void __interrupt() HiPriISR(void) {
    
    // Check if the receive flag is set
    if(PIR1bits.RC1IF == 1)
    {
        receive_handler();
    }
    
}	// Supports retfie FAST automatically

/******************************************************************************
 * receive_handler subroutine, the receive flag is set
 * 
 ******************************************************************************/
void receive_handler()
{
    // Temporary character to read received byte
    char temp;
    
    // Read the value in RCREG1, this clears the interrupt flag
    temp = RCREG1;
    
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
        
        // Check if timer 3 flag has gone off
        if(PIR2bits.TMR3IF == 1)
        {
            updateSPI();
            TMR3 = 65536 - 1953;    // Instructions for 0.488281 ms
            PIR2bits.TMR3IF = 0;   // Clear the flag      
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
    // Increment counter for continuous transmission
    count = count + 1;
    
    // Condition to transmit
    if(count == 2 && cont_on == 1)
    {
        count = 0;  // Reset
        contSend(); // Output values
    }
    
    //Reset
    if(count > 2) 
    {
        count = 0;
    }
    
    // TOGGLE LED
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
 * writeSPI will send a 12 bit value to the DAC and read the buffer to clear the receive buffer
 * It will then update the value to be sent
 ******************************************************************************/
void writeSPI()
{    
    char garbo; // Garbage variable
    
    // Assert the CS bit
    LATEbits.LATE0 = 0;
    
    // Send one byte, get second most sig byte of the data to send
    char byteSend = (dacVal >> 8) & 0x0F;
    byteSend = byteSend | 0x70;   // OR with the command 0111 for the DAC, write to DACa, buffered input, gain = 1, output power down control bit
    
    // Send the first byte
    SSP1BUF = byteSend;
            
    // Wait until complete
    while(PIR1bits.SSP1IF == 0)
    {
        ;
    }
    PIR1bits.SSP1IF = 0;    // Clear the flag
    
   
    // Read in the received byte
    garbo = SSP1BUF;
    
    // Get the second byte, lower byte of the integer
    byteSend = dacVal & 0xFF;
    
    // Send another byte
    SSP1BUF = byteSend;
    
    // Wait until complete
    while(PIR1bits.SSP1IF == 0)
    {
        ;
    }
    PIR1bits.SSP1IF = 0;    // Clear the flag
    
    // Read in the received byte
    garbo = SSP1BUF;
    
    // De-assert the CS
    LATEbits.LATE0 = 1;
    
    // Make sure the flag is clear
    PIR1bits.SSP1IF = 0;    // Clear the flag
}


/******************************************************************************
 * updateSPI updates the value of the dacValue to send over SPI
 * it increments by 1 and resets if it is beyond the max value
 ******************************************************************************/
void updateSPI()
{
    dacVal = dacVal + 2;
    
    if(dacVal >= 4096)
    {
       dacVal = 0;  // Switch to decrease
    }
    
    
//    if(direction == 1)
//    {
//        // Increase
//        dacVal = dacVal + 2;
//        
//        // See if it has reached the max value
//        if(dacVal >= 4096)
//        {
//            direction = 0;  // Switch to decrease
//        }
//    }
//    else
//    {
//        // Decrease
//        dacVal = dacVal - 2;
//        
//        // See if it has reached the min value
//        if(dacVal <= 0)
//        {
//            direction = 1;  // Switch to increase
//        }
//    }
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
    char str1[10] = "TEMP";
    char str2[10] = "POT";
    char str3[10] = "CONT_ON";
    char str4[10] = "CONT_OFF";
    
    // Use string compare to see what case it is
    if(!strcmp(str1, UART_buffer)) //TEMP
    {
        // Output the temperature
        for(int i = 2; i < 7; i++)
        {
            send_byte(tempBuffer[i]);
        }
    }
    else if(!strcmp(str2, UART_buffer)) //POT
    {
        // Output the potentiometer
        for(int i = 3; i < 8; i++)
        {
            send_byte(potBuffer[i]);
        }
    }
    else if(!strcmp(str3, UART_buffer)) //CONT_ON
    {
        cont_on = 1;
    }
    else if(!strcmp(str4, UART_buffer)) //CONT_OFF
    {
        cont_on = 0;;
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
 * contSend
 * This subroutine will send T and PT for the continuous send
 ******************************************************************************/
void contSend()
{
    // Output the temperature value
    for(int i = 0; i < 7; i++)
    {
        send_byte(tempBuffer[i]);
    }
    
    send_byte(';');
    send_byte(' ');
    
    // Output the potentiometer value
    for(int i = 0; i < 8; i++)
    {
        send_byte(potBuffer[i]);
    }
    
    // Carriage return
    send_byte(0x0D);
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
    
    // Send byte over UART
    TXREG1 = byte;
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
        
        // Get string to write over UART
        for(int i = 0; i < 7; i++)
        {
            tempBuffer[i] = word[i]; // Copy over the word
        }
        
        // Display on the LCD
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
        
        // Get string to write over UART
        for(int i = 0; i < 8; i++)
        {
            potBuffer[i] = word[i]; // Copy over the word
        }
        
        // Display on the LCD
        DisplayV(buffer);
    }
}