#include <stdint.h>
static const char digits[] = "0123456789ABCDEF";

void Bits2HexString(uint8_t bits, char string[]) { // radix 16
	unsigned int nibble1 = bits >> 4;
	unsigned int nibble2 = bits & 0b00001111; // take nibbles of 4 digits

	string[0] = digits[nibble1]; // add to string based on value of nibble with the digit array
	string[1] = digits[nibble2];
	string[2] = '\0';
}

void Bits2OctalString(uint8_t bits, char string[]) { // radix 8
	unsigned int nibble1 = bits >> 6;
	uint8_t bits2 = bits << 2;
	bits2 = bits2 >> 5;
	unsigned int nibble2 = bits2 & 0b00000111;
	unsigned int nibble3 = bits & 0b00000111; // 3 nibbles of three digits
	
	string[0] = digits[nibble1];
	string[1] = digits[nibble2];
	string[2] = digits[nibble3];
	string[3] = '\0';
}


void Bits2UnsignedString(uint8_t bits, char string[]) { // radix 10
	unsigned int nibble1 = bits/100;
	uint8_t bits2 = bits - (nibble1*100);
	unsigned int nibble2 = bits2/10;
	uint8_t bits3 = bits2 - (nibble2*10); // division by base 10 with remainder to convert
	unsigned int nibble3 = bits3;
	
	string[0] = digits[nibble1];
	string[1] = digits[nibble2];
	string[2] = digits[nibble3];
	string[3] = '\0';
}

/*

void Bits2SignMagString(uint8_t bits, char string[]) {

}

void Bits2TwosCompString(uint8_t bits, char string[]) {

}

*/