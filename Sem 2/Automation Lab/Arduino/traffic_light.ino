void setup() {
  // put your setup code here, to run once:
  
pinMode(7,OUTPUT);
pinMode(6,OUTPUT);
pinMode(5,OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(7,1);   //red
  digitalWrite(6,0);
  digitalWrite(5,0);

delay(1000);

digitalWrite(7,0);  //yellow
  digitalWrite(6,1);
  digitalWrite(5,0);

delay(1000);

digitalWrite(7,0); //green or blue
  digitalWrite(6,0);
  digitalWrite(5,1);

delay(1000);
}
