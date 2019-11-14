/*
 * SwitchTest.c
 * Created: 11/13/2019 7:38:20 PM
 * Author : Drew Martins
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint8_t num;

int main(void)
{
	DDRB = 0x0F;
	DDRD = 0x0F;
	num = 0;
	
	TCNT1 = 2841;
	TCCR1A = (0b00 << COM1A0)|(0b00 << COM1B0)|(0b00 << WGM00);
	TCCR1B = (0b00 << WGM02)|(0b101 << CS00);
	TIMSK1 = (0b1 << TOIE1);
	
	sei();
	
    while (1) 
    {
		PORTB = 0x0F;
		PORTD = num;
    }
}

ISR (TIMER1_OVF_vect)
{
	if(num >= 16)
		num = 0;
	else
		num++;
	TCNT1 = 2841;
}
