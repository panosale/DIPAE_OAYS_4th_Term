// Askisi 5.3
#include <Servo.h>

Servo servo;

const int trigPin = 6;
const int echoPin = 5;
float duration, distance;

void setup()
{
  // Initialize Servo
  servo.attach(9, 500, 2500);
  // Initialize Ultrasonic
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  
//  Serial.begin(9600); // For debugging
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

  int mapped_distance = map(distance, 0, 320, 0, 180);
  servo.write(mapped_distance);
  
//  Serial.println(mapped_distance); // For debugging
}