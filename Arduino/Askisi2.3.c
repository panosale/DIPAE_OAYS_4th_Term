// Askisi 2.3
// C++ code
//
#define LED1 7
#define LED2 8

uint64_t lastMillis1 = 0;
uint64_t lastMillis2 = 0;
uint64_t currentMillis = 0;

int led1Period = 300;
int led2Period = 1000;

void setup()
{
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
}

void loop()
{
  currentMillis = millis();
  if (currentMillis > lastMillis1 + led1Period) {
    lastMillis1 = currentMillis;
    digitalWrite(LED1, !digitalRead(LED1));
  }
  if (currentMillis > lastMillis2 + led2Period) {
    lastMillis2 = currentMillis;
    digitalWrite(LED2, !digitalRead(LED2));
  }
}

