// Askisi 5.2
// LiquiCrystalDisplay parameters
#include <LiquidCrystal.h>
const int rs = 12, e = 11, db4 = 5, db5 = 4, db6 = 3, db7 = 2;
LiquidCrystal lcd_1(rs, e, db4, db5, db6, db7);

// Ultrasonic parameters
const int trigPin = 10;
const int echoPin = 9;
float duration, distance;

void setup()
{
  lcd_1.begin(16, 1); // Set up the number of columns and rows on the LCD.

  // Initialize Ultrasonic
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void loop()
{
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  duration = pulseIn(echoPin, HIGH);
  distance = (duration*.0343)/2;

  lcd_1.setCursor(0, 1);  
  lcd_1.print(distance);
  delay(1000); // Wait for 1000 millisecond(s)
}