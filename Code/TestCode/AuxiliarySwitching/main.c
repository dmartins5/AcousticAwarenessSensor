/* Drew Martins
 * Senior Project
 * Test Program
 * Auxiliary Switch
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint8_t sig __attribute__((address(0x0100)));

int main(void)
{
	sig = 0;
	DDRB |= (1 << PORTB1)|(1 << PORTB0); // PORTB1:0 are outputs
	
	TCNT1 = 49999; // Sets the timer to go off every 1.004s.
	TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	TCCR1B = (0b00<<WGM12)|(0b101<<CS10); // Set Prescaler to 1
	TIMSK1 = (0b1<<TOIE1); // Enables interrupts for TOV1
	
	sei();
	while (1) 
    {
		PORTB = sig;
    }
}

ISR (TIMER1_OVF_vect)
{
	cli();
 	sig ^= 3; // Toggles between PORTB1:0 both on and off
	TCNT1 = 49999;
	sei();
}

