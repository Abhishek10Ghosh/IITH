int pin1=50;  //anti
int pin2=51;  //clockwise
int pin3=4;   // speed control


void setup() {
  // put your setup code here, to run once:
pinMode(pin1,OUTPUT);
pinMode(pin2,OUTPUT);
pinMode(pin3,OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
digitalWrite(pin1,1);
digitalWrite(pin2,0);
analogWrite(pin3,50);
delay(2000);

digitalWrite(pin1,0);
digitalWrite(pin2,0);
analogWrite(pin3,0);
delay(1000);

digitalWrite(pin1,0);
digitalWrite(pin2,1);
analogWrite(pin3,250);
delay(1000);

digitalWrite(pin1,0);
digitalWrite(pin2,0);
analogWrite(pin3,0);
delay(1000);



}
