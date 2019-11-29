/* Drew Martins
 * 
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
	
	TCNT1 = 39062; // Timer1 is invoked every second
	TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	TCCR1B = (0b00<<WGM12)|(0b101<<CS10); // Set Prescaler to 1
	TIMSK1 = (0b1<<TOIE1); // Enables interrupts for TOV1
	
	sei();
	while (1) 
    	{
		asm("NOP");
	}
}

ISR (TIMER1_OVF_vect)
{
	cli();
 	sig ^= 3; // Toggles between PORTB1:0 both on and off
	// By toggling the signal between 0 and 3, the auxiliary ports will be turned on and off
	// Each side of the headphones is connected to PORTB1 and PORTB0
	PORTB = sig;
	TCNT1 = 39062;
	sei();
}

