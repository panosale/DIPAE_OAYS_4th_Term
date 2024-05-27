// Askisi 3.2.b
// C++ code
//
#define RED 11
#define GREEN 9
#define BLUE 10
#define BTN 2
#define TMPRTURE 0

uint64_t lastMillis = 0;
uint64_t currentMillis = 0;

int measureInterval = 10000; // Μεγαλύτερο interval για να προλαβαίνουμε να πατήσουμε το κουμπί για έλεγχο

void setup()
{
  pinMode(RED, INPUT);
  pinMode(GREEN, INPUT);
  pinMode(BLUE, INPUT);
  pinMode(BTN, OUTPUT);
  pinMode(TMPRTURE, OUTPUT);
  
  attachInterrupt(digitalPinToInterrupt(BTN), calculateTemperature, FALLING);
    
  Serial.begin(9600);
}


void lightYellow() {
  analogWrite(RED, 255);
  analogWrite(GREEN, 255);
  analogWrite(BLUE, 0);
}

void lightRed() {
  analogWrite(RED, 255);
  analogWrite(GREEN, 0);
  analogWrite(BLUE, 0);
}
void lightBlue() {
  analogWrite(RED, 0);
  analogWrite(GREEN, 0);
  analogWrite(BLUE, 255);
}
                 
void lightOff() {
  analogWrite(RED, 0);
  analogWrite(GREEN, 0);
  analogWrite(BLUE, 0);
}
void changeColor(String color) {
	if (color == "yellow")
      lightYellow();
  	else if (color == "red")
      lightRed();
  	else if (color == "blue")
      lightBlue();
}

String chooseColor(float measuredTemperature) {
  if (measuredTemperature > 25)
    return "red";
  else if (measuredTemperature < 5)
    return "blue";
  else
    return "yellow";
}

void calculateTemperature() {
  Serial.print("Button pressed: ");
  float voltageMeasure, temperatureMeasure;
  voltageMeasure = (analogRead(TMPRTURE) * 5.0) / 1024;
  temperatureMeasure = (voltageMeasure - 0.5) * 100;
  changeColor(chooseColor(temperatureMeasure));
  Serial.println(temperatureMeasure);
  lastMillis = millis(); // Αποθήκευση του τελευταίου millis για επαναφορά του χρόνου μέχρι την επόμενη αυτόματη μέτρηση
}
  
void loop()
{
  currentMillis = millis();
  float voltageMeasure, temperatureMeasure;
  if (currentMillis > lastMillis + measureInterval) {
    voltageMeasure = (analogRead(TMPRTURE) * 5.0) / 1024;
    temperatureMeasure = (voltageMeasure - 0.5) * 100;
    changeColor(chooseColor(temperatureMeasure));
    lastMillis = currentMillis;
    Serial.println(temperatureMeasure);
  }
}

