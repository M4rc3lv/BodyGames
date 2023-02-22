#include <Keyboard.h>
#include <Wire.h>
#include <Adafruit_VL53L0X.h>

// Key strokes Game Console:
// Shift     - Squat sensor (VL53L0X sensor)
// Ctrl      - Trampoline
// Alt       - Exercise bike
// Cursor  R - Right button
// Cursor  L - Left button

#define SENSOR_BIKE    9
#define SENSOR_TRAMP   12
#define SENSOR_RIGHT   6
#define SENSOR_LEFT    7

#define LED_ON         10
#define LED_SENSE      11

#define BUTTON         8

// Max. distance for squat sensor to detect human (i.e. not a squat)
#define MAX_DISTANCE_CM 100

Adafruit_VL53L0X SquatSensor = Adafruit_VL53L0X();
boolean IsOn=true;

void setup() { 
 //Serial.begin(115200);
 pinMode(SENSOR_BIKE,INPUT_PULLUP);
 pinMode(SENSOR_TRAMP,INPUT_PULLUP);
 pinMode(SENSOR_RIGHT,INPUT_PULLUP);
 pinMode(SENSOR_LEFT,INPUT_PULLUP);

 pinMode(LED_ON,OUTPUT);
 pinMode(LED_SENSE,OUTPUT);

 pinMode(BUTTON,INPUT_PULLUP);
 delay(1000);   

 Keyboard.begin(); 
 digitalWrite(LED_ON,IsOn?HIGH:LOW);
 digitalWrite(LED_SENSE,LOW);    
}


void loop() {
 static boolean ShiftPressed=false; 
 static boolean CtrlPressed=false;
 static boolean AltPressed=false;
 static boolean CursorR=false;
 static boolean CursorL=false;
  
 if(digitalRead(BUTTON)==LOW) {
  IsOn = !IsOn;
  digitalWrite(LED_ON,IsOn?HIGH:LOW);
  delay(20);
  while(digitalRead(BUTTON)==LOW) {
   // Debounce
   delay(20);
  }  
 }

 // Do nothing if the console is switched off
 if(!IsOn) {
  Keyboard.releaseAll();
  digitalWrite(LED_SENSE,LOW);
  digitalWrite(LED_ON,LOW);  
  return;
 }

 bool SomeKeyWasPressed=false; 
 VL53L0X_RangingMeasurementData_t measure; 
 SquatSensor.getSingleRangingMeasurement(&measure); 
 if(measure.RangeStatus != 4) {   
  int cm = measure.RangeMilliMeter/10;   
  if(cm<MAX_DISTANCE_CM) {Keyboard.press(KEY_LEFT_SHIFT); SomeKeyWasPressed=true;}
 }

 if(digitalRead(SENSOR_TRAMP)==LOW) 
  {Keyboard.press(KEY_LEFT_CTRL); SomeKeyWasPressed=true;}

 if(digitalRead(SENSOR_BIKE)==LOW) 
  {Keyboard.press(KEY_LEFT_ALT); SomeKeyWasPressed=true;}

 if(digitalRead(SENSOR_LEFT)==LOW) 
  {Keyboard.press(KEY_LEFT_ARROW); SomeKeyWasPressed=true;}

 if(digitalRead(SENSOR_RIGHT)==LOW) 
  {Keyboard.press(KEY_RIGHT_ARROW); SomeKeyWasPressed=true;} 

 if(SomeKeyWasPressed) {
  delay(80);
  Keyboard.releaseAll();
 }
}
