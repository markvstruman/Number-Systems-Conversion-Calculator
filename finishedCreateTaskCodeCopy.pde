int[] decNums = new int[3]; // integer array gang
int[] binNums = new int[8];
int[] octNums = new int[3];
String[] hexNums = new String[2]; // string array gang
String joinedDecNums, joinedBinNums, joinedOctNums; // string gang
int digit, numer, decOutput, otherThing, binKey, binDigit, quantity; // integer gang
char asciiOutput; // character
void setup() {
  size(450,435);
  background(255);
  textAlign(CENTER);
  digit = 0;
  binKey = -1;
}
void draw() {
  conversion();
  background(255); // visuals start here
  
  fill(0);
  rect(0,0, width, height);
  fill(255);
  rect(10,10,width-20, height-20);
  textSize(40); // headers
  fill(255,0,0);
  text("Decimal", 225, 50);
  text("Binary", 225, 130);
  text("HexaDecimal", 225, 210);
  text("Octal", 225, 290);
  text("ASCII Letter", 225, 370);
  
  textSize(35); // outputs
  fill(0);
  text(joinedBinNums, 225, 170);
  text(hexNums[0] + hexNums[1], 225, 250);
  text(joinedOctNums, 225, 330);
  text(asciiOutput, 225, 410);
  text(joinedDecNums, 225, 90);
}

void conversion() {
  joinedBinNums = join(nf(binNums, 0), "");
  joinedDecNums = join(nf(decNums, 0), ""); 
  joinedOctNums = join(nf(octNums, 0), "");
  if(binKey == -1) {
    binConvert();
  }
  else if(binKey == 1) {
    decConvert();
  }
  decOutput = int(joinedDecNums);
  hexConvert();
  octConvert();
  asciiConvert();
}

String decConvert() {
  otherThing=0;
  for(int i = 0; i < 8; i++) {
    quantity = int(binNums[i] * (pow(2, (7-i))));
    otherThing = otherThing+quantity;
    quantity=0;
  }
  joinedDecNums=str(otherThing);
  otherThing = 0;
  return(joinedDecNums);
}

void keyPressed() {
    if(key==BACKSPACE) {
      if(binKey==-1) {
        check(-1);
      }
      else {
        binCheck(-1);
      }
    }
    else {
      for(int i = 0; i < 10; i++) {
        if(key==(char(48+i))) {
          if(binKey == -1) {
            decNums[digit] = char(i);
            check(1); 
          }
          else if(binKey==1) {
            if(key == '1') {
              binNums[binDigit] = 1;
              binCheck(1);
            }
            if(key == '0') {
              binNums[binDigit] = 0;
              binCheck(1);
            }
          }
        }
    }
    if(key==TAB) {
      binKey=binKey*-1;
      binDigit = 0;
      digit = 0;
      for(int e = 0; e < 3; e++) {
        decNums[e] = 0;
      }
      for(int g = 0; g < 8; g++) {
        binNums[g] = 0;
      }
      decOutput=0;
      joinedDecNums = str(0);
      joinedBinNums = str(0);
    }
  }
}

void binCheck(int i) {
  if((binDigit+i)>7 || (binDigit+i==-1)) {
  }
  else {
    binDigit = binDigit+i;
  }
}

void check(int i) {
  if((digit+i)>2 || (digit+i==-1)) {
  }
  else {
    digit = digit+i;
  }
}

int[] binConvert() {
  otherThing = decOutput;
  if(otherThing <= 255) {
    if(otherThing == 255) {
      for(int i = 0; i < 8; i++) {
        binNums[i] = 1;
      }
    }
    else {
      for(int i =0; i<8; i++) {
        binNums[(7-i)] = otherThing%2;
        otherThing = otherThing/2;
      }
    }
  }
  return(binNums);
}

String[] hexConvert() { // my child #2
  otherThing = decOutput;
  if(otherThing <= 255) {
    if(otherThing == 255) {
      hexNums[0] = "F";
      hexNums[1] = "F";
    }
    else {
      for(int i =0; i<2; i++) { // again probably a better way to do it but its chill
        if(otherThing%16 == 10) {
          hexNums[1-i] = "A";
        }
        if(otherThing%16 == 11) {
          hexNums[1-i] = "B";
        }
        if(otherThing%16 == 12) {
          hexNums[1-i] = "C";
        }
        if(otherThing%16 == 13) {
          hexNums[1-i] = "D";
        }
        if(otherThing%16 == 14) {
          hexNums[1-i] = "E";
        }
        if(otherThing%16 == 15) {
          hexNums[1-i] = "F";
        }
        else if(otherThing%16 < 10) {
          hexNums[1-i] = str(otherThing%16);
        }
        otherThing = otherThing/16;
      }
    }
  }
  else {
      hexNums[0] = "0";
      hexNums[1] = "0";
    }
  return(hexNums);
}

int[] octConvert() {
  otherThing = decOutput;
  if(otherThing <= 255) {
    if(otherThing == 255) {
      octNums[0] = 3;
      octNums[1] = 7;
      octNums[2] = 7;
    }
    else {
      for(int i =0; i<3; i++) { // something wacky is happening here but it works ig
        octNums[(2-i)] = otherThing%8;
        otherThing = otherThing/8;
      }
    }
  }
  else if(decOutput > 255) {
    for(int i = 0; i < 3; i++) {
      octNums[i] = 0;
    }
  }
  return(octNums);
}

char asciiConvert() {
  if(decOutput > 64 && decOutput < 123){
    asciiOutput = char(decOutput);
  }
  else {
    asciiOutput = 45;
  }
  return(asciiOutput);
}
