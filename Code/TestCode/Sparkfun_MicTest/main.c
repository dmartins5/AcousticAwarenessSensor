#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint16_t adc_data[200] __attribute__((address(0x0100)));
volatile uint32_t interrupt[10] __attribute((address(0x290)));
volatile uint16_t ambient __attribute__((address(0x02B8)));
volatile uint8_t adc_idx __attribute__((address(0x02B9)));
volatile uint8_t int_idx __attribute__((address(0x02BA)));

int main()
{
	ambient = 0x0000;
	adc_idx = 0;
	int_idx = 0;
	DDRB = 0x03;
	DDRD = 0xFF;
	DDRC = 0x00;
	PORTC = 0x01; // Pull-Up Enabled
	
	TCNT0 = 96; // Sets the timer to go off every 10 ms
	TCCR0A = (0b00<<COM0A0)|(0b00<<COM0B0)|(0b00<<WGM00); // Normal mode
	TCCR0B = (0b0<<WGM02)|(0b101<<CS00); // prescaler = divide by 1024
	TIMSK0 = (0b1<<TOIE0); // enable interrupts for TOV0

	TCNT1 = 19530; // Sets the timer to go off every 2 seconds.
	TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	TCCR1B = (0b00<<WGM12)|(0b101<<CS00); // prescaler = divide by 1024
	TIMSK1 = (0b1<<TOIE1); // Enables interrupts for TOV1

	ADMUX = (0b01<<REFS0);
	ADMUX = (0b0000<<MUX0);
	ADCSRA = (0b111<<ADPS0);
	ADCSRB = (0b100<<ADTS0);
	ADCSRA |= (0b1<<ADEN);
	
	sei();
	while(1)
	{
		PORTB = interrupt[int_idx] >> 8;
		PORTD = interrupt[int_idx];
	}
}

ISR (TIMER1_OVF_vect)
{
	cli();
	//TIMSK0 &=~ (0b1<<TOIE0);
	adc_idx = 0;
	for(adc_idx = 0; adc_idx < 200; adc_idx++)
	{
		interrupt[int_idx] += adc_data[adc_idx];
	}
	interrupt[int_idx] /= 200;
	int_idx++;
	if(int_idx >= 10)
	{
		int_idx = 0;
		for(int_idx = 0; int_idx < 10; int_idx++)
		{
			ambient += interrupt[int_idx];
		}
		ambient /= 10;
		int_idx = 0;
	}
	adc_idx = 0;
	//TIMSK0 |= (0b1<<TOIE0);
	sei();
}

ISR (TIMER0_OVF_vect)
{
	cli();
	adc_data[adc_idx] = ADC;
	adc_idx++;
	if(adc_idx == 200)
	{
		TIMSK0 &=~ (0b1<<TOIE0);
		adc_idx = 0;
	}
	else
		TCNT0 = 96;
	sei();
}
