// Askisi 2.1
// C++ code
//
#define RED 11
#define GREEN 9
#define BLUE 10

void setup()
{
  pinMode(RED, INPUT);
  pinMode(GREEN, INPUT);
  pinMode(BLUE, INPUT);
  Serial.begin(9600);
}

void lightYellow() {
  analogWrite(RED, 255);
  analogWrite(GREEN, 255);
  analogWrite(BLUE, 0);
}

void lightPurple() {
  analogWrite(RED, 168);
  analogWrite(GREEN, 0);
  analogWrite(BLUE, 255);
}

void loop()
{
  String color = Serial.readString();
  if (color != "")
    if (color == "yellow")
      lightYellow();
    else if (color == "purple")
      lightPurple();
    else
      Serial.println("You gave wrong color.");
}

