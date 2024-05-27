// Askisi 1.2
// C++ code
//
#define LED1 7
#define LED2 9
#define BTN 2

int xamili_foteinotita_led = 0.4 * 255;
int ypsili_foteinotita_led = 0.8 * 255;

void setup()
{
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(BTN, INPUT);
  digitalWrite(LED1, LOW);
  analogWrite(LED2, xamili_foteinotita_led);
}

void loop()
{
  if (digitalRead(BTN)) {
  	digitalWrite(LED1, HIGH);    
  	analogWrite(LED2, ypsili_foteinotita_led);
  }
  else {
  	digitalWrite(LED1, LOW);
  	analogWrite(LED2, xamili_foteinotita_led);    
  }
}

