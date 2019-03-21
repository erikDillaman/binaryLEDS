      /*---------------------------------------------       
      |     Binary LEDs with Arduino & Processing   |
      |             ~Erik Dillaman~                 |
      ---------------------------------------------*/

import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;

Arduino arduino;
String binNum = "";
PFont myFont;

void setup() {
  surface.setSize(300,150);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  for (int i = 2; i < 10; i++) {
    arduino.pinMode(i, Arduino.OUTPUT);
  }
      // You might not have this font on your computer.  In that case, choose one that you do have // 
  myFont = createFont("League Gothic", 130);
  textAlign(CENTER, CENTER);
  textFont(myFont);
}


void draw() {
  background(200);
  float numInput = arduino.analogRead(0);
  numInput = map(numInput, 0, 1023, 0, 255);
  binDigit((int)numInput);
  lightEmUp(binNum);
  fill(50);
  text((int)numInput, width/2+1, height/2+1);
  fill(255);
  text((int)numInput, width/2, height/2);
  println((int)numInput+":  "+binNum);
}

// Take a number (0-255) and convert it into a String that represents the binary number
void binDigit(int num) {
  binNum = "";
  int i = 0;
  while(num > 0){
    binNum = num%2 + binNum;
    num = num/2;
    i++;
  }
  while(i<8){
    binNum = "0"+binNum;
    i++;
  }
}

// Take the binary string and read it one char at a time, lighting up or turning off the LEDs accordingly
void lightEmUp(String bin){
  for (int j = 0; j < 8; j++){
    if (bin.substring(j, j+1).equals("1")){
      // I started wiring my LEFT LED light in Digital Port 2.  As I moved to the right down the series of LEDs, I used the next port.
      // This is shown in my j+2 value below.
      arduino.digitalWrite(j+2, Arduino.HIGH);
    } else {
      arduino.digitalWrite(j+2, Arduino.LOW);
    }
  }
}
