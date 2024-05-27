// Askisi 3.1
// C++ code
//
#define RED 11
#define GREEN 9
#define BLUE 10
#define BTN 2

String color = "yellow"; // Set yellow as default color

void setup()
{
  pinMode(RED, INPUT);
  pinMode(GREEN, INPUT);
  pinMode(BLUE, INPUT);
  pinMode(BTN, INPUT_PULLUP);
    
  changeColor();
  
  attachInterrupt(digitalPinToInterrupt(BTN), swapColor, FALLING);

  Serial.begin(9600); // For debugging
}

void lightOff() {
  analogWrite(RED, 0);
  analogWrite(GREEN, 0);
  analogWrite(BLUE, 0);
}
void changeColor() {
	if (color == "yellow")
      lightYellow();
  	else if (color == "purple")
      lightPurple();
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

void swapColor() {
  if (color == "yellow")
    color = "purple";
  else if (color == "purple")
    color = "yellow";
  Serial.println(color); // For debugging
}
                 
void loop()
{
  changeColor();
}
 
