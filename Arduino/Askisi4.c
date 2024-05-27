// Askisi 4
// C++ code
//
/*
  LiquidCrystal Library - Hello World

   Demonstrates the use of a 16x2 LCD display.
  The LiquidCrystal library works with all LCD
  displays that are compatible with the  Hitachi
  HD44780 driver. There are many of them out
  there, and you  can usually tell them by the
  16-pin interface.

  This sketch prints "Hello World!" to the LCD
  and shows the time.

  The circuit:
  * LCD RS pin to digital pin 12
  * LCD Enable pin to digital pin 11
  * LCD D4 pin to digital pin 5
  * LCD D5 pin to digital pin 4
  * LCD D6 pin to digital pin 3
  * LCD D7 pin to digital pin 2
  * LCD R/W pin to ground
  * LCD VSS pin to ground
  * LCD VCC pin to 5V
  * 10K resistor:
  * ends to +5V and ground
  * wiper to LCD VO pin (pin 3)

  Library originally added 18 Apr 2008  by David
  A. Mellis
  library modified 5 Jul 2009  by Limor Fried
  (http://www.ladyada.net)
  example added 9 Jul 2009  by Tom Igoe
  modified 22 Nov 2010  by Tom Igoe

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/LiquidCrystal
*/

#include <LiquidCrystal.h>

const int rs = 12, e = 11, db4 = 5, db5 = 4, db6 = 3, db7 = 2;
LiquidCrystal lcd_1(rs, e, db4, db5, db6, db7);
String message = "Panagiotis says 'Hello world!'";
int msg_length;

void setup()
{
  // set up the LCD's number of columns and rows:
  // Αν στο παρακάτω το βάλουμε (16, 2)...
  // ...έχει πολύ μεγάλο κενό ανάμεσα στο κείμενο. Γιατί;
  lcd_1.begin(16, 2);
  // Print a message to the LCD.
  lcd_1.print(message);
  msg_length = message.length();
  delay(500);
}

void loop()
{
  
  // scroll "message.length" positions to the left
  // to move it offscreen left:
  for (int positionCounter = 0; positionCounter < msg_length; positionCounter++) {
    // scroll one position left:
    lcd_1.scrollDisplayLeft();
    // wait some ms
    delay(250);
  }
}
