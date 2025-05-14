int pinDir=40;
int pinPul=50;
int stepsPerRevolution=1600;



void setup() {
  // put your setup code here, to run once:
pinMode(pinDir,OUTPUT);
pinMode(pinPul,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
digitalWrite(pinDir,HIGH);
for(int i=0;i<stepsPerRevolution;i++)
{
  digitalWrite(pinPul,HIGH);
  delay(2);
  digitalWrite(pinPul,LOW);
  delay(2);
}
delay(1000);


digitalWrite(pinDir,LOW);
for(int i=0;i<stepsPerRevolution;i++)
{
  digitalWrite(pinPul,HIGH);
  delay(1);
  digitalWrite(pinPul,LOW);
  delay(1);
}
delay(1000);


}
