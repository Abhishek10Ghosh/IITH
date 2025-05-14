int pot=A3;

void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
float sensorvalue=analogRead(pot);
sensorvalue=(sensorvalue*255)/1023;
Serial.println(sensorvalue);
delay(20);

}
