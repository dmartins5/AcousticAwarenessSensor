/* Senior Project: Test Program
 * Display ADC through LEDs
 * 
 * The goal of this program is to connect the microphone to
 * the ADC on the microphone
 * left signal and right signal on and off simultaniously
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint16_t mic_data __attribute__((address(0x800100)));

void clear_ports()
{
	PORTD &= 0x00;
	PORTB &= 0x00;
}

int main()
{
	mic_data = 0;
	DDRC &=~ (1 << DDC5);
	// PORTC0 is the input from the Microphone
	DDRB |= 0x03;
	DDRD |= 0xFF;
	clear_ports();
	// PORTB1:0 and PORTD7:0 is the output of the Microphone.
	ADMUX = (1 << REFS1)|(1 << MUX2)|(1 << MUX0);
	ADCSRA |= (0b111 << ADPS0);
	ADCSRA |= (1 << ADEN);
	ADCSRA |= (1 << ADSC);
	
	TCNT1 = 9999; 
	TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	TCCR1B = (0b00<<WGM12)|(0b101<<CS10);
	TIMSK1 = (0b1<<TOIE1); // Enables interrupts for TOV1
	
	sei();
	while(1)
	{
		asm("NOP");
	}
}



ISR (TIMER1_OVF_vect)
{
	clear_ports();
	TCNT1 = 9999;
	mic_data = ADC;
	PORTB = ((mic_data >> 8) & 0x03); // Displays the highest 2 digits of the ADC
	PORTD = mic_data; // Displays the lowest 8 digits of the ADC
}
