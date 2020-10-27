
#include<Wire.h>
#include <ESP8266WiFi.h> 
#include "FirebaseESP8266.h"

#define FIREBASE_HOST "upgo-47506.firebaseio.com"                    //enter host and authorization key
#define FIREBASE_AUTH "VVLhwAUHtzCPIEON7xleAVbk7SADalVvQLca7xBU" 
const char *ssid="Lelouch";//Enter WiFi Name 
const char *pass="gotyabitch";//WiFi Password 

const int MPU_addr=0x68;  // I2C address of the MPU-6050 
int16_t AcX,AcY,AcZ,Tmp,GyX,GyY,GyZ; 
float ax=0, ay=0, az=0, gx=0, gy=0, gz=0; 
boolean fall = false; //stores if a fall has occurred 
boolean trigger1=false; //stores if first trigger (lower threshold) has occurred 
boolean trigger2=false; //stores if second trigger (upper threshold) has occurred 
boolean trigger3=false; //stores if third trigger (orientation change) has occurred 

byte trigger1count=0; //stores the counts past since trigger 1 was set true 
byte trigger2count=0; //stores the counts past since trigger 2 was set true 
byte trigger3count=0; //stores the counts past since trigger 3 was set true 

int WIFI_LED=16;
int SEND_LED = 2;
int angleChange=0;
FirebaseData firebaseData;
int var=0; 
void send_event(); 

int buzzerPin =15;
int interruptPin = 14;

void setup() 

{ 
  pinMode(buzzerPin,OUTPUT);
  pinMode(WIFI_LED,OUTPUT);
  pinMode(SEND_LED,OUTPUT);
  digitalWrite(SEND_LED,HIGH);
  
attachInterrupt(digitalPinToInterrupt(interruptPin), handleInterrupt, RISING);

Serial.begin(115200); 

 Wire.begin(); 
 Wire.beginTransmission(MPU_addr); 
 Wire.write(0x6B);  // PWR_MGMT_1 register 
 Wire.write(0);     // set to zero (wakes up the MPU-6050) 
 Wire.endTransmission(true); 
 Serial.println("Wrote to IMU"); 
 Serial.println("Connecting to "); 
 Serial.println(ssid);
  
 WiFi.begin(ssid, pass);  
  while (WiFi.status() != WL_CONNECTED) //Code for connecting to WiFi 
  { 

    delay(500); 
    digitalWrite(WIFI_LED,  !digitalRead(WIFI_LED));
    Serial.print(".");              // print ... till not connected 

  } 
  Serial.println(""); 
  digitalWrite(WIFI_LED,HIGH);
  Serial.println("WiFi connected"); 
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH); 
 } 

ICACHE_RAM_ATTR void handleInterrupt() {    //THE PROBLEM IS THIS LINE!
fall = !fall;
tone(buzzerPin,0,0);  
}

void loop()
{ 
 mpu_read(); 
 ax = (AcX-2050)/16384.00;    //MPU6050 sensor data. 2050, 77, 1947 are values for calibration of an accelerometer.
 ay = (AcY-77)/16384.00; 
 az = (AcZ-1947)/16384.00; 
 gx = (GyX+270)/131.07; 
 gy = (GyY-351)/131.07; 
 gz = (GyZ+136)/131.07; 

 float Raw_Amp = pow(pow(ax,2)+pow(ay,2)+pow(az,2),0.5);  // calculating Amplitute vector for 3 axis 
 int Amp = Raw_Amp * 10;  // Mulitiplied by 10 bcz values are between 0 to 1 

 Serial.println(Amp); 

 if (Amp<=2 && trigger2==false)  //if AM breaks lower threshold (0.4g) 

 {  

   trigger1=true; 
   Serial.println("TRIGGER 1 ACTIVATED"); 

   } 

    if (trigger1==true){ 
    trigger1count++; 

   if (Amp>=12){ //if AM breaks upper threshold (3g) 

     trigger2=true; 
     Serial.println("TRIGGER 2 ACTIVATED"); 
     trigger1=false; trigger1count=0; 

     } 

 } 

 if (trigger2==true){ 

   trigger2count++; 
   angleChange = pow(pow(gx,2)+pow(gy,2)+pow(gz,2),0.5); 
   Serial.println(angleChange); 
   if (angleChange>=30 && angleChange<=400)
   {                                                  //if orientation changes by between 80-100 degrees 

     trigger3=true; trigger2=false; trigger2count=0; 

     Serial.println(angleChange); 

     Serial.println("TRIGGER 3 ACTIVATED"); 

       } 

   } 

 if (trigger3==true)
 { 

    trigger3count++; 

    if (trigger3count>=10)
    {  

       angleChange = pow(pow(gx,2)+pow(gy,2)+pow(gz,2),0.5); 

       //delay(10); 

       Serial.println(angleChange);  

       if ((angleChange>=0) && (angleChange<=10)){ //if orientation changes remains between 0-10 degrees 

           fall=true; trigger3=false; trigger3count=0; 

           Serial.println(angleChange); 

             } 

       else
       {                                             //user regained normal orientation 

          trigger3=false; trigger3count=0; 

          Serial.println("TRIGGER 3 DEACTIVATED"); 

       } 

     } 

  } 

 if (fall==true)
 {                                                      //in event of a fall detection 

   Serial.println("FALL DETECTED");
   tone(buzzerPin,1,5000);
   delay(5000);
   if(fall==true){
   tone(buzzerPin,1000);
   send_event();
   fall=false; 
   }
   } 

 if (trigger2count>=6){ //allow 0.5s for orientation change 

   trigger2=false; trigger2count=0; 

   Serial.println("TRIGGER 2 DECACTIVATED"); 

   } 

 if (trigger1count>=6)
 {                                             //allow 0.5s for AM to break upper threshold 

   trigger1=false; trigger1count=0; 

   Serial.println("TRIGGER 1 DECACTIVATED"); 

   } 

  delay(100); 

   } 

 void mpu_read(){ 

 Wire.beginTransmission(MPU_addr); 

 Wire.write(0x3B);  // starting with register 0x3B (ACCEL_XOUT_H) 

 Wire.endTransmission(false); 

 Wire.requestFrom(MPU_addr,14,true);  // request a total of 14 registers 

 AcX=Wire.read()<<8|Wire.read();  // 0x3B (ACCEL_XOUT_H) & 0x3C (ACCEL_XOUT_L)     

 AcY=Wire.read()<<8|Wire.read();  // 0x3D (ACCEL_YOUT_H) & 0x3E (ACCEL_YOUT_L) 

 AcZ=Wire.read()<<8|Wire.read();  // 0x3F (ACCEL_ZOUT_H) & 0x40 (ACCEL_ZOUT_L) 

 Tmp=Wire.read()<<8|Wire.read();  // 0x41 (TEMP_OUT_H) & 0x42 (TEMP_OUT_L) 

 GyX=Wire.read()<<8|Wire.read();  // 0x43 (GYRO_XOUT_H) & 0x44 (GYRO_XOUT_L) 

 GyY=Wire.read()<<8|Wire.read();  // 0x45 (GYRO_YOUT_H) & 0x46 (GYRO_YOUT_L) 

 GyZ=Wire.read()<<8|Wire.read();  // 0x47 (GYRO_ZOUT_H) & 0x48 (GYRO_ZOUT_L) 

 } 

 void send_event() 

{ 
  digitalWrite(SEND_LED,LOW);

  //4. Enable auto reconnect the WiFi when connection lost
  Firebase.reconnectWiFi(true);

  //5. Try to set int data to Firebase
  //The set function returns bool for the status of operation
  //firebaseData requires for sending the data
  if(Firebase.setString(firebaseData, "/notification/text", "fall"+String(var)))
  {
    //Success
    var=var+1;
     Serial.println("Data transmission success");

  }else{
    //Failed?, get the error reason from firebaseData

    Serial.print("Error in data transmission, ");
    Serial.println(firebaseData.errorReason());
  }


  //6. Try to get int data from Firebase
  //The get function returns bool for the status of operation
  //firebaseData requires for receiving the data
  if(Firebase.getString(firebaseData, "/notification/text"))
  {
    //Success
    Serial.print("Get int data success, int = ");
    Serial.println(firebaseData.stringData());

  }else{
    //Failed?, get the error reason from firebaseData

    Serial.print("Error in getInt, ");
    Serial.println(firebaseData.errorReason());
  }
  
  digitalWrite(SEND_LED,HIGH);

}

  
