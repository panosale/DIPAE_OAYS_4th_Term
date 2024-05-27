// Askisi 1.3
// C++ code
//
#define LED1 7
#define LED2 9
#define BTN 2
#define POTENSMTR 0

int foteinotita_led;
int xamili_foteinotita_led;

void setup()
{
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(BTN, INPUT);
  pinMode(POTENSMTR, INPUT);
  digitalWrite(LED1, LOW);
  foteinotita_led = analogRead(POTENSMTR) / 4;
  analogWrite(LED2, foteinotita_led);
  Serial.begin(9600);
}

void loop()
{
  int tmp_led = analogRead(POTENSMTR);
// Με τα παρακάτω η φωτεινότητα του led2 αλλάζει με την αλλαγή του ποτενσιομέτρου και μένει σταθερά αναμένο
  foteinotita_led = tmp_led / 4;
  analogWrite(LED2, foteinotita_led);
  Serial.println(foteinotita_led);
  if (digitalRead(BTN)) {
  	digitalWrite(LED1, HIGH);
//	Με τα παρακάτω αλλάζει η φωτεινότητα του led2 με το πάτημα του κουμπιού
//	foteinotita_led = tmp_led / 4;
//	analogWrite(LED2, foteinotita_led);
//	Serial.println(foteinotita_led);
  }
  else {
  	digitalWrite(LED1, LOW);
  	//analogWrite(LED2, xamili_foteinotita_led);    
  }
}

