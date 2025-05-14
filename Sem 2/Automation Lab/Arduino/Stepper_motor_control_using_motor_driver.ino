//pole1
int pinAp=51;
int pinAm=52;


//pole2
int pinBp=41;
int pinBm=42;

void setup() {
  // put your setup code here, to run once:
pinMode(pinAp,OUTPUT);
pinMode(pinBp,OUTPUT);
pinMode(pinAm,OUTPUT);
pinMode(pinBm,OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(pinAp,1);
  digitalWrite(pinBm,0);
  digitalWrite(pinAm,0);
  digitalWrite(pinBp,0);
  delay(10);

   digitalWrite(pinAp,0);
  digitalWrite(pinBm,1);
  digitalWrite(pinAm,0);
  digitalWrite(pinBp,0);
  delay(10);

   digitalWrite(pinAp,0);
  digitalWrite(pinBm,0);
  digitalWrite(pinAm,1);
  digitalWrite(pinBp,0);
  delay(10);

   digitalWrite(pinAp,0);
  digitalWrite(pinBm,0);
  digitalWrite(pinAm,0);
  digitalWrite(pinBp,1);
  delay(10);


}
