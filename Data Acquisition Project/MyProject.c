// LCD module connections
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
// End LCD module connections


// Function to initialize the LCD

void servoRotate0()
{
  unsigned int i;
  for(i=0;i<50;i++)
  {
    PORTC.B2 = 1;
    Delay_us(1000);
    PORTC.B2 = 0;
  }
}

void servoRotate90()
{
  unsigned int i;
  for(i=0;i<50;i++)
  {
    PORTC.B2 = 1;
    Delay_us(1500);
    PORTC.B2 = 0;
  }
}

void servoRotate180()
{
  unsigned int i;
  for(i=0;i<50;i++)
  {
    PORTC.B2 = 1;
    Delay_us(2200);
    PORTC.B2 = 0;
  }
}


unsigned int Avilable_places = 10;

void main() {

    float analogVoltage;
    unsigned int digitalVoltage;
    int temprature;
    unsigned int adc_value;
    char text[16];
    unsigned short ir_status = 0;
    unsigned short ir_prev_status = 0;
    unsigned short ir_status2 = 0;
    unsigned short ir_prev_status2 = 0;
    
    ADCON1 = 0x80;               // Configure analog inputs and Vref
    Lcd_Init();                  // Initialize LCD
    Lcd_Cmd(_LCD_CLEAR);         // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);    // Cursor off

    TRISD.B0 = 1;                // Set RB0 & RB2 as input for IR sensor
    TRISD.B2 = 1;

    TRISA.B0 = 1;                //// Set RA0 as input from LDR
    TRISA.B1 = 0;                // Set RA1 as output for LDR control

    TRISA.B2 = 1;                // Set RA2 as input from LM35
    TRISD.B7 = 0;                // Set RD7 as output for LM35 control


    TRISC = 0;                  // Set PortC as output for the motor

    servoRotate0();             // Set Servo initially



    while (1) {
          // Read LM35 sensor value
        digitalVoltage = ADC_Read(2);
        analogVoltage = digitalVoltage / 1023.0 * 5;
        temprature = analogVoltage * 100.0;
        if (temprature > 60) {
            Lcd_Out(1, 1, "Warning!!!!");
            Lcd_Out(2, 1, "Please evacuate");
            PORTD.B7 = 1;
        }
        else
        {
            PORTD.B7 = 0;
          // Read LDR sensor value
          adc_value = ADC_Read(0); // Read from channel 0 (AN0)
          if (adc_value < 512) {   // Assuming 512 as the threshold for light detection
              Lcd_Out(1, 1, "Morning         ");
              PORTA.B1 = 0;
          }
          else {
              Lcd_Out(1, 1, "Night           ");
              PORTA.B1 = 1;
          }
        }

        // Read IR sensor status
        ir_status = PORTD.B0;

        if (ir_status == 1 && ir_prev_status == 0) {
           if (Avilable_places > 0) {
               Avilable_places--;   // Decrement available places
               servoRotate90();
           }
        }

        ir_prev_status = ir_status;

        ir_status2 = PORTD.B2;

        if (ir_status2 == 1 && ir_prev_status2 == 0) {
            if (Avilable_places < 10)
            {
               Avilable_places++;   // Decrement available places
               servoRotate90();
           }
        }

        ir_prev_status2 = ir_status2;

        // Turn off the servo after rotation
        if (ir_status == 0 && ir_status2 == 0)
        {
           servoRotate0();
        }

        if (temprature <= 60 && Avilable_places > 0)
        {
            sprinti(text, "Available: %u   ", Avilable_places);
            Lcd_Out(2, 1, text);
        }
        
        if (Avilable_places == 0 && temprature <= 60)
        {
            Lcd_Out(2, 1, "No places left");
        }


        Delay_ms(200);           // Small delay to avoid flickering
    }
}