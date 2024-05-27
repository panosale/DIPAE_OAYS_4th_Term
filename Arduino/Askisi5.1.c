// Askisi 5.1
// C++ code
//
#define RED 11
#define GREEN 9
#define BLUE 10

const int trigPin = 6;
const int echoPin = 5;
float duration, distance;

String tmp_color;

void changeRGBColor(String color)
{
  if (color == "red") {
    analogWrite(RED, 255);
    analogWrite(GREEN, 0);
    analogWrite(BLUE, 0);
  }
  else if (color == "green") {
    analogWrite(RED, 0);
    analogWrite(GREEN, 255);
    analogWrite(BLUE, 0);
  }
  else if (color == "blue") {
    analogWrite(RED, 0);
    analogWrite(GREEN, 0);
    analogWrite(BLUE, 255);
  }
  
}
void setup()
{
  // Initialize Ultrasonic
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  // Initialize RGD led
  pinMode(RED, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLUE, OUTPUT);
  //Serial.begin(9600); // For debugging
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
  
  if (distance < 100)
    changeRGBColor("blue");
  else if (distance < 200)
    changeRGBColor("green");
  else if (distance < 300)
    changeRGBColor("red");
  
  delay(1000);
}