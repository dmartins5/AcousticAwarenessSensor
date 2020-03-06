#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint8_t adc_value __attribute__((address(0x800100)));


int main()
{
	adc_value = 0;
	DDRC &=~ (1 << DDC5); // Enable DDC5 as input.
	DDRB = 0x03; // Set PB1:0 as outputs
	DDRD = 0xFF; // Set PD7:0 as outputs
	TCNT1 = 39062; // Sets the timer to go off every 1s.
	TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	TCCR1B = (0b00<<WGM12)|(0b101<<CS10); // Set the Prescaler to 256
	TIMSK1 = (0b1<<TOIE1); // Enables interrupts for TOV1

	ADMUX = (1 << REFS1)|(1 << MUX2)|(1 << MUX0);
	ADCSRA |= (0b111 << ADPS0);
	ADCSRA |= (1 << ADEN);
	
	sei();

	while(1)
	{
		asm("NOP");
	}
}

ISR (TIMER1_OVF_vect)
{
	// This interrupt is non-atomic
	TCNT1 = 39062;
	ADCSRA |= (1 << ADSC);
	while(ADCSRA & (1 << ADSC));
	adc_value = ADC;
	PORTB = ((adc_value >> 8) & 0x03); // Displays the highest 2 digits of the ADC
	PORTD = adc_value; // Displays the lowest 8 digits of the ADC
}
