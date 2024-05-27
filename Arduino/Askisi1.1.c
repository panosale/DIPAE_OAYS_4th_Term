// Askisi 1.1
// C++ code
//
#define LED1 7
#define LED2 9
void setup()
{
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
}

void loop()
{
  digitalWrite(LED1, HIGH);
  int foteinotita_led = 0.4 * 255;
  analogWrite(LED2, foteinotita_led);
}
 
