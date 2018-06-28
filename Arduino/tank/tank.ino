/* ******************************************************
 * Title:     tank.ino
 * Purpose:   Controls tank by sending bytes over UART
 *            for University of Kentucky Computer Vision
 *            reseach.
 * Aurthor:   Sam McCauley
 * Professor: Dr. Daniel Lau
 * Date:      6/28/2018
 *******************************************************/
 
// Pin Declarations
#define SL_PIN  6 // Speed     Right Pin
#define SR_PIN  5 // Speed     Left  Pin
#define DL_PIN  7 // Direction Right Pin
#define DR_PIN  4 // Direction Left  Pin

// Options
#define TWOS_COMPLIMENT 1 // If true '1' dir bit is backwards, '0' is forwards
#define DELAY 50 // How long (ms) to wait between each control update

void setup(void) {
  // init pins 
  pinMode(SL_PIN, OUTPUT);
  pinMode(SR_PIN, OUTPUT);
  pinMode(DL_PIN, OUTPUT);
  pinMode(DR_PIN, OUTPUT); 

  // init Serial
  Serial.begin(19200);              
} 
void loop(void) 
{
  // Always wait for at least 2 to be in the buffer
  if(Serial.available() >= 2) {
    char LChar = Serial.read();
    char RChar = Serial.read();
    setMotor(LChar, 'L');
    setMotor(RChar, 'R');
    details(LChar, RChar); // Print info
    delay(DELAY); // Hold that control for DELAY ms
  }
}


// Sets motor direction and speed based on byte/char and side
// Where side is either 'L'/'l' (left) or 'R'/'r' (right)
void setMotor(char c, char side){
  if(side == 'L' || side == 'l'){
    digitalWrite(DL_PIN, getDirection(c));
    analogWrite (SL_PIN, getSpeed(c)); 
  }
  if(side == 'R' || side == 'r'){
    digitalWrite(DR_PIN, getDirection(c));
    analogWrite (SR_PIN, getSpeed(c)); 
  }
}

// Returns what the direction pin output should be
bool getDirection(unsigned char c){
  if(TWOS_COMPLIMENT){
    return (c & 0x80) > 0;   
  } else {
    return (c & 0x80) == 0; 
  }
}

// Returns the speed (2 - 255) parsed from byte
char getSpeed(unsigned char c){
  return (c & 0x7F) << 1;
}

// Prints bits of a byte without cutting off leading 0's
void printBits(byte myByte){
 for(byte mask = 0x80; mask; mask >>= 1){
   if(mask & myByte)
       Serial.print('1');
   else
       Serial.print('0');
 }
}

// General debug info
void details(char LChar, char RChar){
  Serial.print("Captured (char): "); 
    Serial.print(LChar); 
    Serial.print("\t  ");
    Serial.println(RChar);
  Serial.print("Captured (byte): "); 
    printBits(LChar);
    Serial.print(" "); 
    printBits(RChar);
    Serial.println();
  Serial.print("Direction Bit:   ");
    int LDirBit = int(getDirection(LChar));
    int RDirBit = int(getDirection(RChar));
    Serial.print(LDirBit);
    Serial.print("\t  ");
    Serial.println(RDirBit);
  Serial.print("Direction:       ");
    if(TWOS_COMPLIMENT){
      if(LDirBit)
        Serial.print("BACK.    ");
      else
        Serial.print("FORW.    ");
      if(RDirBit)
        Serial.println("BACK.    ");
      else
        Serial.println("FORW.    ");
    } else {
      if(LDirBit)
        Serial.print("FORW.    ");
      else
        Serial.print("BACK.    ");
      if(RDirBit)
        Serial.println("FORW.    ");
      else
        Serial.println("BACK.    ");
    }
  Serial.print("Speed:           ");
    Serial.print(int(getSpeed(LChar)));
    Serial.print("\t ");
    Serial.println(int(getSpeed(RChar)));
}
