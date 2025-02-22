#include "BluetoothSerial.h"
//#include "DHT.h"
#include <ESP32Servo.h>
#include <WiFi.h>
#include <HTTPClient.h>
//#define  DHTPIN 13
//#define DHTTYPE DHT11|
//DHT dht(DHTPIN,DHTTYPE);
byte ch=0,ph=0;
byte ct=0,pt=0;
String device_name="ESP32 InnovaAquaICP";
const char *pin="1234";
Servo servoMotor;
int estadoServo = 0;
int modServoC = 3;
//#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
//#error Bluetooth is not enabled! Please run `make menuconfig` and enable it
//#endif
//#if !defined(CONFIG_BT_SPP_ENABLED)
//#error Serial Bluetooth not available or not enabled. It is only available for ESP32 chip.
//#endif
//BluetoothSerial SerialBT;
String message="";
char incommingChar;
//const int led1=2;
const int trigPin = 5;
const int echoPin = 18;
//float cmC = 0;
//float cmP = 0;
float currentDistance = 0.0;
//float lecturas[numLecturas]; // Array para almacenar lecturas
int lecturaActual = 0; // Lectura por la que vamos
//float total = 0; // Total de las que llevamos
//float media = 0; // Media de las medidas
//bool primeraMedia = false; // Para saber que ya hemos calculado por lo menos una
bool capacidad = true;
//define sound speed in cm/uS
#define SOUND_SPEED 0.034
#define CM_TO_INCH 0.393701

long duration;
float distanceCm = 0.0;
//float distanceInch;

// Configura las credenciales de tu red WiFi
const char* ssid = "Hackaton2";
const char* password = "12345678";

// URL de tu API
const char* serverName = "https://unov5-rqaaa-aaaap-ahohq-cai.raw.icp0.io/update"; // Ajusta esto a la IP de tu servidor
int currentPos = 0;  // posición objetivo del servo
void setup() {
  Serial.begin(115200);
  //SerialBT.begin(device_name);
  //dht.begin();
   // Conecta al WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");
 // pinMode(led1,OUTPUT);
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
  // Iniciamos el servo para que empiece a trabajar con el pin 
  servoMotor.attach(17);

}

void loop() {

  // Clears the trigPin
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH);
    // Calculate the distance
  distanceCm = duration * SOUND_SPEED/2;
  if(distanceCm != currentDistance){
     if(distanceCm > 0.0){
        if(distanceCm>3.6){
          capacidad = true;
          estadoServo = 0;
        }else if(distanceCm < 3.6){
          capacidad = false;
          
          estadoServo = 1;
        }
        String jsonData = "{\"distance\": " + String(distanceCm, 2) + 
                    ", \"capacity\": " + String(capacidad) + 
                    "}";
        Serial.println(jsonData);
        String jsonDataTest = "{\"title\":\"foo\",\"body\":\"bar\",\"userId\":1}";
        Api(jsonData);
      }
      currentDistance = distanceCm;
      
      if(estadoServo==1){
         ActivateServo();
      }else{
        DesActivateServo();
      }
  }

 
 
  // Convert to inches
 // distanceInch = distanceCm * CM_TO_INCH;
  
  
  
 // delay(1000);
}

void Api(String jsonData){
   if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;

    // Configura la URL del servidor
    http.begin(serverName);

    // Especifica el tipo de contenido
    http.addHeader("Content-Type", "application/json; charset=UTF-8");

    // Crea el objeto JSON
    //String jsonData = "{\"title\":\"foo\",\"body\":\"bar\",\"userId\":1}";

    // Envía la solicitud POST
    int httpResponseCode = http.POST(jsonData);

    // Verifica la respuesta
    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println(httpResponseCode);
      Serial.println(response);
    } else {
      Serial.print("Error on sending POST: ");
      Serial.println(httpResponseCode);
    }

    // Libera los recursos
    http.end();
  } else {
    Serial.println("WiFi Disconnected");
  }

  // Espera un tiempo antes de enviar otra solicitud
  delay(10000);
}

void ActivateServo(){
  // Desplazamos a la posición
  if(modServoC != estadoServo){
       Serial.println("Servo Motor Activado CERRAR");
      
       for(int i = 180; i>0; i--){
        servoMotor.write(i);
        delay(10);
     } 
       
  }
  modServoC = estadoServo;  
  
}
void DesActivateServo(){
  if(modServoC != estadoServo){
     // Desplazamos a la posición 180º
     Serial.println("Servo Motor Activado ABRIR");
     for(int i = 0; i<=180; i++){
          servoMotor.write(i);
          delay(10);
       }
     modServoC = estadoServo;
  }
   
}
