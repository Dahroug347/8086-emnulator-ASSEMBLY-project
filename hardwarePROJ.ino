// The password is ("5229"):D ;
#include "Keypad.h"
#include <LiquidCrystal.h>
const byte ROWS = 4; //four rows
const byte COLS = 4; //four columns
//define the cymbols on the buttons of the keypads
int delay1=3000;
int c=0;
int i=0;
int error=0;
int led=8;
int buzzer=9;
char hexaKeys[ROWS][COLS] = {
  { '1','2','3','A' },
  { '4','5','6','B' },
  { '7','8','9','C' },
  { 'F','0','E','D' }
};
char pass[]= {'5','2','2','9'};
char user[15];
byte rowPins[ROWS] = {13, 7, A5, A4}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {A3, A2, A1, A0}; //connect to the column pinouts of the keypad
int f=0;
//initialize an instance of class NewKeypad
Keypad customKeypad = Keypad( makeKeymap(hexaKeys), rowPins, colPins, ROWS, COLS); 
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
void setup() {
pinMode(led,OUTPUT);
digitalWrite(led,LOW);
pinMode(buzzer,OUTPUT);
digitalWrite(buzzer,LOW);
lcd.begin(16,2);
lcd.setCursor(0,0);
lcd.print("Hint if u enter ");
lcd.setCursor(0,1);
lcd.println("a wrong password");
delay(delay1);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("after 3 times");
lcd.setCursor(0,1);
lcd.println("you will wait a ");
delay(delay1);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("half minute to");
lcd.setCursor(0,1);
lcd.println(" try again ");
delay(delay1);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("Enter password");
lcd.setCursor(0,1);
lcd.println(" please ! ");
delay(delay1);
}
void print1()
{  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("enter the psw!! ");
}
void print2()
{
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("try again!!");
}
void loop() 
{
  char key = customKeypad.getKey();
  if ( key != NO_KEY&&i<4)
{
 if (f==0)
{
lcd.clear();
f=1; 
}
lcd.setCursor(0,0);
lcd.print("password:");
lcd.setCursor(i,1);
lcd.print("*");
user[i]=key;
if(user[i]==pass[i])c++;
i++;
}
if (c==4)
{
delay(500);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("signed in :)");
digitalWrite(led,HIGH);
delay(delay1);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("to switch off");
lcd.setCursor(0,1);
lcd.println(" load press 0 ");
delay(delay1);
bool exit = false;
while (!exit)
{
  char key1 = customKeypad.getKey();
  if (key1 == '0')
{
  exit = true;
  digitalWrite(led,LOW);
  delay(delay1);
}
}
char user[]={'0','0','0','0'};
print1();
c=0;
i=0;
f=0;
}
else if (c<4&&i==4)
{
delay(500);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("invalid passw!");
delay(1000); 
i=0;
c=0;
error++;
if (error<3)
{
 print2();
} 
f=0;     
}
if (error==3)
{
digitalWrite(buzzer,HIGH);
delay(3500);
digitalWrite(buzzer,LOW);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("you ent wrong");
lcd.setCursor(0,1);
lcd.print(" psw 3 times ");
delay(3000);
lcd.clear();
lcd.setCursor(0,0);
lcd.print(" w8 till 0.5 min ");
delay(30000);
error=0;
print1();
f=0;
}
}
