// Askisi 2.2
// C++ code
//
#define LED 9
void setup()
{
  pinMode(LED, OUTPUT);
}

void loop()
{
  digitalWrite(LED, HIGH);
  delay(500); // Wait for 1000 millisecond(s)
  digitalWrite(LED, LOW);
  delay(500); // Wait for 1000 millisecond(s)
}

