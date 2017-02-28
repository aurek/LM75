/*
    LM75 - An arduino library for the LM75 temperature sensor
    Copyright (C) 2011  Dan Fekete <thefekete AT gmail DOT com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <Wire.h>
#include <LM75.h>

LM75 sensor;  // initialize an LM75 object
// You can also initiate with another address as follows:
//LM75 sensor(LM75_ADDRESS | 0b001);  // if A0->GND, A1->GND and A2->Vcc
byte sensaddr[2]={
	0x49, // A0->GND, A1->GND and A2->GND
	// 0x4B, // A0->Vcc, A1->Vcc and A2->Vcc
	0x4F // A0->Vcc, A1->Vcc and A2->Vcc
}; 
float senshigh[2]={
	27.5,
	22.5
};
float sensdown[2]={
	25.0,
	20.0
};

void setup()
{
	Wire.begin();
	Serial.begin(9600);
	while (!Serial);             // Leonardo: wait for serial monitor
	Serial.println("\nMultiple LM75 I2C temperature sensor");
	for (int i = 0 ; i < sizeof(sensaddr) ; i++) {
		Serial.println(sensaddr[i]);
		// set address
		sensor.setaddr(sensaddr[i]);
		// Tos Set-point
		sensor.tos(senshigh[i]);
		Serial.print("Tos set at ");
		Serial.print(sensor.tos());
		Serial.println(" C");

		// Thyst Set-point
		sensor.thyst(sensdown[i]);
		Serial.print("Thyst set at ");
		Serial.print(sensor.thyst());
		Serial.println(" C");
	}
}

void loop()
{
	for (int i = 0 ; i < sizeof(sensaddr) ; i++) {
		// set address
		sensor.setaddr(sensaddr[i]);
		// get temperature from sensor
		Serial.print("Current temp ");
		Serial.print(sensaddr[i]);
		Serial.print(": ");
		Serial.print(sensor.temp());
		Serial.println(" C");
	}
	delay(3000);
}
